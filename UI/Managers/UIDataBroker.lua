local lc = require('Utils.Constants') or LevelingChronicle
local UI = lc.UI

local table_utils = require('Libs.LuaCore.Utils.TableUtils') or LCTableUtils

local ds = require('Utils.DataServices') or lc.DataServices
local rm = require('Recorder.RecorderManager') or lc.RecorderManager

UI.UIDataBroker = {}
local udb = UI.UIDataBroker

function udb.getCharacterOverallStats(character_guid)
  local res = ds.getCharacterOverallStats(character_guid)
  
  if (rm.getCurrentCharacter().guid == character_guid and rm.isRecorderStarted()) then
    local session = rm.getRunningSessionData()

    res = table_utils.addTables(res, session.stats)
  end
  
  return res
end

function udb.getCharacterLevelStats(character_guid, level)
  local res = ds.getCharacterLevelStats(character_guid, level)
  
  local current_char = rm.getCurrentCharacter()
  if (current_char.guid == character_guid and rm.isRecorderStarted() and current_char.level == level) then
    local session = rm.getRunningSessionData()
    
    res = table_utils.addTables(res, session.stats_by_level[current_char.level])
  end  
  
  return res
end

function udb.getCharacterLevelEvents(character_guid)
  local level_events = ds.getCharacterLevelEvents(character_guid)
  
  local current_char = rm.getCurrentCharacter()
  if (current_char.guid == character_guid and rm.isRecorderStarted()) then
    local session = rm.getRunningSessionData()
    
    local combined_level_events = table_utils.shallowCopy(level_events)
    for level, stats in pairs(session.events.levels) do
      level_events[tostring(level)] = stats
    end
    
    level_events = combined_level_events
  end  
  
  return level_events
end

function udb.getCharacterStatsByLevel(character_guid)
  local stats_by_level = ds.getCharacterStatsByLevel(character_guid)
  
  local current_char = rm.getCurrentCharacter()
  if (current_char.guid == character_guid and rm.isRecorderStarted()) then
    local session = rm.getRunningSessionData()
    
    local combined_stats_by_level = table_utils.shallowCopy(stats_by_level)
    for level, stats in pairs(session.stats_by_level) do
      level = tostring(level)
      combined_stats_by_level[level] = combined_stats_by_level[level] and table_utils.addTables(stats_by_level[level], stats) or stats
    end
    
    stats_by_level = combined_stats_by_level
  end  
  
  return stats_by_level
end


return udb