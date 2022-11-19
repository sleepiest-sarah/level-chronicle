local lc = require('Utils.Constants') or LevelingChronicle

local ef = require('Libs.WowEventFramework.WowEventFramework') or WowEventFramework
local table_utils = require('Libs.LuaCore.Utils.TableUtils') or LCTableUtils

local Character = require('Objects.Character') or lc.Character
local recorder = require('Recorder.Recorder') or lc.Recorder
local ds = require('Utils.DataServices') or lc.DataServices

lc.RecorderManager = {}

local manager = lc.RecorderManager

local char

local function timePlayedMsg(event, time_played, time_played_level)
  print(event, time_played, time_played_level)
  ChatTypeGroup["SYSTEM"][2] = "TIME_PLAYED_MSG"
  ChatFrame_AddMessageGroup(DEFAULT_CHAT_FRAME, "SYSTEM")
  ef.unregisterEvent("TIME_PLAYED_MSG", timePlayedMsg)
end

local function loadCharacterData()
  char = Character:new()
  char:loadCharacterData("player")
  ds.saveCharacter(char)
  
  if (char:canGainXp()) then
    recorder.initialize(char)
    recorder.start()
  end
  
  ef.triggerCustomEvent(lc.Event.CHARACTER_INITIALIZED, char)
end

local function loadCharacterPlayedTime()
  --manager.system_chat_type = ChatTypeGroup["SYSTEM"]
  RequestTimePlayed()
end

local function init()
  loadCharacterData()
  --loadCharacterPlayedTime()
end

local function saveSessionData(session)
  ds.saveCharacterSession(char, session)
end

local function closeRecorder()
  if (not recorder.closed) then
    recorder.close()
    
    saveSessionData(recorder.session)
  end
end

function manager.getRunningSessionData()
  return table_utils.deepCopy(recorder.session), char, recorder.started, recorder.recording
end

function manager.stopRecorder()
  recorder.stop()
end


ef.registerEvent("PLAYER_LOGIN", init)
ef.registerEvent("PLAYER_LOGOUT", closeRecorder)
--ef.registerEvent("TIME_PLAYED_MSG", timePlayedMsg)
  
--might do something with these for people logged in when expac launches
ef.registerEvent("MAX_EXPANSION_LEVEL_UPDATED", nil)
ef.registerEvent("UPDATE_EXPANSION_LEVEL", nil)

return manager