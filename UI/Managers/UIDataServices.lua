local lc = require('Utils.Constants') or LevelingChronicle
local UI = lc.UI

local table_utils = require('Libs.LuaCore.Utils.TableUtils') or LCTableUtils

local ds = require('Utils.DataServices') or lc.DataServices
local rm = require('Recorder.RecorderManager') or lc.RecorderManager

UI.UIDataServices = {}
local m = UI.UIDataServices

function m.getCharacterOverallStats(character_guid)
  local res = ds.getCharacterOverallStats(character_guid)
  
  if (rm.getCurrentCharacter().guid == character_guid and rm.isRecorderStarted()) then
    local session = rm.getRunningSessionData()

    res = table_utils.addTables(res, session.stats)
  end
  
  return res
end

function m.getCharacterLevelStats(character_guid, level)
  local res = ds.getCharacterLevelStats(character_guid, level)
  
  local current_char = rm.getCurrentCharacter()
  if (current_char.guid == character_guid and rm.isRecorderStarted()) then
    local session = rm.getRunningSessionData()
    
    res = table_utils.addTables(res, session.stats_by_level[current_char.level])
  end  
  
  return res
end

return m