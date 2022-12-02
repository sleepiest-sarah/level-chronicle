local lc = require('Utils.Constants') or LevelingChronicle

local ef = require('Libs.WowEventFramework.WowEventFramework') or WowEventFramework
local table_utils = require('Libs.LuaCore.Utils.TableUtils') or LCTableUtils
local time_utils = require('Libs.LuaCore.Utils.TimeUtils') or LCTimeUtils

local templates = require('Objects.RecordTemplates') or lc.RecordTemplates

lc.Recorder = {}
local recorder = lc.Recorder

local char, session

local stats_template = templates.stats_record_template
  
local timestamps = {
    player_kill = -math.huge,
    quest_completed = -math.huge,
    pet_battle_finished = -math.huge,
    gathering = -math.huge,
    scenario_completed = -math.huge,
    pet_battle_started = -math.huge,
    scenario_started = -math.huge
  }
  
local function sanityCheckValue(key, delta)
  if (key == "time_scenarios") then
    return delta < 3600
  elseif (key == "time_pet_battles") then
    return delta < 1200
  end
end
  
local function inEventWindow(timestamp)
  return time_utils.systemTime() - timestamp < lc.EVENT_WINDOW_SECONDS
end

local function incrementStat(stat, delta)
  session.stats[stat] = session.stats[stat] + delta
  
  session.stats_by_level[char.level][stat] = session.stats_by_level[char.level][stat] + delta
end

local function playerExpUpdate(event, unitid)
  if (unitid == "player") then
    recorder.refresh()
    
    local current_xp = UnitXP("player")
    local max_xp = UnitXPMax("player")

    local xp_gain = current_xp - char.xp
    if (xp_gain < 0) then
      xp_gain = (char.max_xp - char.xp) + current_xp
    end
    incrementStat("total_xp_gained", xp_gain)
    
    local xp_pct = xp_gain / max_xp
    incrementStat("pct_levels_gained", xp_pct)
    
    local inInstance, instanceType = IsInInstance()
    if (inEventWindow(timestamps.pet_battle_finished)) then
      
      local delta = timestamps.pet_battle_finished - timestamps.pet_battle_started
      if (sanityCheckValue("time_pet_battles", delta)) then
        -- want to do increment stats here so we aren't counting pet battles that don't give xp
        incrementStat("num_pet_battles", 1)    
        incrementStat("time_pet_battles", delta)
        incrementStat("pet_battle_xp_gained", xp_gain)
      end
      
      timestamps.pet_battle_started = -math.huge
    elseif (inEventWindow(timestamps.gathering)) then
      incrementStat("gathering_xp_gained", xp_gain)
    elseif (C_PvP.IsBattleground()) then
      incrementStat("battleground_xp_gained", xp_gain)
    elseif (inInstance and instanceType == "party") then
      incrementStat("scenario_xp_gained", xp_gain)
    elseif (not (inEventWindow(timestamps.player_kill) or inEventWindow(timestamps.quest_completed) or inEventWindow(timestamps.scenario_completed))) then
      incrementStat("other_xp_gained", xp_gain)
    end
    
    char.xp = current_xp
    char.max_xp = max_xp
    char.rested_xp = GetXPExhaustion()
  end
end

local function playerScenarioCompleted(event, questId, xp, money)
  
  if (xp) then
    incrementStat("scenario_xp_gained", xp)
    timestamps.scenario_completed = time_utils.systemTime()
  end
  
  local delta = time_utils.systemTime() - timestamps.scenario_started
  if (sanityCheckValue("time_scenarios", delta)) then
    incrementStat("time_scenarios", delta) 
    incrementStat("num_scenarios_completed", 1)
    timestamps.scenario_started = -math.huge
  end
end

--TODO check for war mode bonus xp
local function playerQuestTurnedIn(event, questId, xp, money)
  if (xp and xp > 0) then
    incrementStat("quest_xp_gained", xp)
    timestamps.quest_completed = time_utils.systemTime()
    
    incrementStat("num_quests_completed", 1)
  end
end

--TODO check for war mode bonus xp
local function playerMsgCombatXpGain(event, ...)
  local msg = ...
  
  local rested_xp = string.match(msg, "%+(%d+) exp Rested bonus")
  if (rested_xp) then
    incrementStat("bonus_rested_xp_gained", rested_xp)
  end
  
  local group_xp = string.match(msg, "%+(%d+) group bonus")
  if (group_xp) then
    incrementStat("bonus_group_xp_gained", group_xp)
  end
  
  local xp_gain = string.match(msg, "dies, you gain (%d+) experience.")
  if (xp_gain) then
    incrementStat("kill_xp_gained", xp_gain)
    incrementStat("num_kills", 1)
    
    group_xp = group_xp or 0
    rested_xp = rested_xp or 0
    incrementStat("kill_xp_raw_gained", xp_gain - rested_xp)
    
    local inInstance, instanceType = IsInInstance()
    if (instanceType == "party") then
      incrementStat("kill_xp_raw_instance_gained", xp_gain - rested_xp)
      incrementStat("kill_xp_instance_gained", xp_gain)
      incrementStat("num_kills_instance", 1)
    else
      incrementStat("kill_xp_raw_world_gained", xp_gain - rested_xp)
      incrementStat("kill_xp_world_gained", xp_gain)
      incrementStat("num_kills_world", 1)      
    end
    
    timestamps.player_kill = time_utils.systemTime()
  end
  
end

-- PET_BATTLE_CLOSE gets called twice. could use PET_BATTLE_OVER but the gap between that and PLAYER_XP_UPDATE is significant
local function petBattleClose()
  timestamps.pet_battle_finished = time_utils.systemTime()
end

local function petBattleStart()
  timestamps.pet_battle_started = time_utils.systemTime()
end

local function playerLevelUp(event, newLevel)
  if (newLevel ~= char.level) then
    incrementStat("levels_gained", 1)
  
    session.events.levels[char.level] = {date_reached = time_utils.unixTime()}
    char.level = newLevel
    -- TODO convert keys to string OR convert when initializing the character
    if (not session.stats_by_level[char.level]) then
      session.stats_by_level[char.level] = table_utils.shallowCopy(stats_template)
      session.stats_by_level[char.level].elapsed_time = 0
    end
    
    if (newLevel == char.max_level) then
      recorder.stop()
    end
    
    ef.triggerCustomEvent(lc.Event.PLAYER_LEVEL_UP, newLevel)
  end
end

local function chatMsgOpening(event, msg)
  local mining = string.match(msg, "You perform (Mining)") 
  local herbing = string.match(msg, "You perform (Herb Gathering)")
  
  if (mining or herbing) then
    timestamps.gathering = time_utils.systemTime()
    incrementStat("num_gathers", 1)
  end
end

local function playerBattlegroundComplete(event, winner, duration)
  if (C_PvP.IsBattleground()) then
    incrementStat("num_battlegrounds_completed", 1)
    incrementStat("time_battlegrounds", duration)
  end
end

local function playerEnteringWorld(event, isInitialLogin, isReloadingUi)
  local name, instanceType = GetInstanceInfo()
  if (instanceType == "party") then
    timestamps.scenario_started = time_utils.systemTime()
  end
end

function recorder.onEvent(event, ...)
  if (not recorder.started) then
    return
  end
  
  if (event == "PLAYER_XP_UPDATE") then
    playerExpUpdate(event, ...)
  elseif (event == "CHAT_MSG_COMBAT_XP_GAIN") then
    playerMsgCombatXpGain(event, ...)
  elseif (event == "QUEST_TURNED_IN") then
    playerQuestTurnedIn(event, ...)
  elseif (event == "PLAYER_LEVEL_UP") then
    playerLevelUp(event, ...)
  elseif (event == "CHAT_MSG_OPENING") then
    chatMsgOpening(event, ...)
  elseif (event == "SCENARIO_COMPLETED") then
    playerScenarioCompleted(event, ...)
  end
  
  ef.triggerCustomEvent(lc.Event.SESSION_DATA_CHANGED)
end

function recorder.refresh()
  if (recorder.recording) then
    local delta = time_utils.systemTime() - session.current_time
    session.elapsed_time = session.elapsed_time + delta
    session.stats_by_level[char.level].elapsed_time = session.stats_by_level[char.level].elapsed_time + delta
  end
  
  if (recorder.inactivity_timer) then
    recorder.inactivity_timer:Cancel()
  end
  recorder.inactivity_timer = C_Timer.NewTimer(lc.INACTIVITY_PAUSE_AFTER, recorder.stop)
  
  session.current_time = time_utils.systemTime()
  recorder.recording = true
end

function recorder.start()
  recorder.recording = false
  recorder.started = true
  recorder.session = {}
  
  session = recorder.session
  session.start_time = time_utils.unixTime()
  session.current_time = time_utils.systemTime()
  session.elapsed_time = 0
  session.stats = table_utils.shallowCopy(stats_template)
  session.stats_by_level = {}
  session.stats_by_level[char.level] = table_utils.shallowCopy(stats_template)
  session.stats_by_level[char.level].elapsed_time = 0
  
  session.events = {levels = {}}
  
  recorder.inactivity_timer = C_Timer.NewTimer(lc.INACTIVITY_PAUSE_AFTER, recorder.stop)
  
  ef.triggerCustomEvent(lc.Event.SESSION_DATA_CHANGED)
end

function recorder.stop()
  recorder.recording = false
  
  if (recorder.inactivity_timer) then
    recorder.inactivity_timer:Cancel()
  end
  recorder.inactivity_timer = nil
  
  ef.triggerCustomEvent(lc.Event.SESSION_DATA_CHANGED)
end

function recorder.close()
  if (recorder.recording) then
    local delta = time_utils.systemTime() - session.current_time
    session.elapsed_time = session.elapsed_time + delta
    session.stats_by_level[char.level].elapsed_time = session.stats_by_level[char.level].elapsed_time + delta
     recorder.session.end_time = time_utils.unixTime()
  end
  
  recorder.stop()
  
  recorder.started = false
  recorder.closed = true
end

function recorder.initialize(character)
  char = character
  
  recorder.started = false
  recorder.closed = false
  recorder.recording = false

  ef.registerEvent("PLAYER_XP_UPDATE", recorder.onEvent)
  ef.registerEvent("CHAT_MSG_COMBAT_XP_GAIN", recorder.onEvent)
  ef.registerEvent("QUEST_TURNED_IN", recorder.onEvent)
  ef.registerEvent("PLAYER_LEVEL_UP", recorder.onEvent)
  ef.registerEvent("CHAT_MSG_OPENING", recorder.onEvent)
  ef.registerEvent("SCENARIO_COMPLETED", recorder.onEvent)
  
  --want to capture these even if experience hasn't been received recently
  ef.registerEvent("PET_BATTLE_CLOSE", petBattleClose)
  ef.registerEvent("PVP_MATCH_COMPLETE", playerBattlegroundComplete)
  ef.registerEvent("PLAYER_ENTERING_WORLD", playerEnteringWorld)
  ef.registerEvent("PET_BATTLE_OPENING_DONE", petBattleStart)
end

return recorder