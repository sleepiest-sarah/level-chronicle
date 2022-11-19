local lc = LevelingChronicle

local table_utils = require('Libs.LuaCore.Utils.TableUtils') or LCTableUtils
local math_utils = require('Libs.LuaCore.Utils.MathUtils') or LCMathUtils
local string_utils = require('Libs.LuaCore.Utils.StringUtils') or LCStringUtils
local wow_utils = require('Libs.LuaCore.Utils.WowUtils') or LCWowUtils

local ds = require('Utils.DataServices') or lc.DataServices
local rm = require('Recorder.RecorderManager') or lc.RecorderManager
local calc = require('Utils.Calculator') or lc.Calculator

lc.UI.Manager = {}
local m = lc.UI.Manager

local safemult = math_utils.safemult

--TODO move to a util
local num_event_keys = {kill = "num_player_kills",
                        quest = "num_quests_completed",
                        scenario = "num_scenarios_completed",
                        battleground = "num_battlegrounds_completed",
                        gathering = "num_gathers",
                        pet_battle = "num_pet_battles"}
                      
local xp_gained_keys = {
    kill = "kill_xp_gained",
    quest = "quest_xp_gained",
    scenario = "scenario_xp_gained",
    battleground = "battleground_xp_gained",
    gathering = "gathering_xp_gained",
    pet_battle = "pet_battle_xp_gained"
  }

local function percentStringComparator(a,b)
  a = tonumber(string.sub(a,0,-2))
  b = tonumber(string.sub(b,0,-2))
  return a > b
end

local function descendingComparator(a,b)
  return a > b
end

function m.buildCharacterTreeModel()
  local character_records = ds.getAllCharacters()
  
  local model = {}
  model.character_colors = {}
  
  local characters = {}
  for _,c in pairs(character_records) do
    if (not characters[c.realm]) then
      characters[c.realm] = {text = c.realm, children = {}}
    end
    table.insert(characters[c.realm].children, {text = c.name, key = c.guid})
    
    model.character_colors[c.guid] =  c.class and C_ClassColor.GetClassColor(c.class)
  end
  
  for realm, tab in pairs(characters) do
    table.sort(tab.children, function (a,b) return a.text < b.text end)
  end
  
  model.characters = table_utils.getValues(characters)
  table.sort(model.characters, function (a,b) return a.text < b.text end)
  
  return model
end

function m.buildCharacterJourneyModel(character_guid, page, page_size)
  local model = {}
  model.char = ds.getCharacter(character_guid)
  local stats_by_level = ds.getCharacterStatsByLevel(character_guid)
  local level_events = ds.getCharacterLevelEvents(character_guid)
  
  local sorted_keys = table_utils.getKeys(stats_by_level)
  table.sort(sorted_keys, function (a,b) return tonumber(b) > tonumber(a) end)
  
  model.level_keys = sorted_keys
  model.total_pages = math.ceil(#sorted_keys / page_size)
  model.page = page or model.total_pages  --want to start on the last page (most recently written in the RP)
  
  model.seed = string_utils.toNumber(model.char.guid)
  model.page_seed = model.seed + model.page
  
  local min, max = (model.page * page_size) - page_size + 1 , math.min(model.page * page_size, #sorted_keys)
  
  model.stats_by_level = {}
  
  if (min < 0) then
    return model
  end
  
  for i=min,max do
    local level = sorted_keys[i]
    local stats = stats_by_level[level]
    local level_model = {
        pet_battle_xp_gained = stats.pet_battle_xp_gained,
        gathering_xp_gained = stats.gathering_xp_gained,
        other_xp_gained = stats.other_xp_gained,
        quest_xp_gained = stats.quest_xp_gained,
        kill_xp_gained = stats.kill_xp_gained,
        scenario_xp_gained = stats.scenario_xp_gained,
        elapsed_time = stats.elapsed_time,
        level = level,
        level_seed = model.seed + level,
      }
      
    local pct_per_event = calc.calculatePctLevelPerEvent(stats)
    
    level_model.activity_stats = {}
    for k,v in pairs(num_event_keys) do
      level_model.activity_stats[k] = {
          pct_per_event = string.format("%.2f%%",pct_per_event[k] * 100),
          num = stats[v],
          xp = stats[xp_gained_keys[k]]
        }
    end
    
    level_model.sorted_activity_keys = table_utils.getKeysBySortedValues(level_model.activity_stats, function (a,b) return a.num > b.num end)
    
    if (level_events[level]) then
      level_model.level_reached_date = date("%m/%d/%y", level_events[level].date_reached)
    end
    
    local calc_stats = calc.calculateSessionStats(stats, stats.elapsed_time, model.char)
    level_model.xp_rate = math_utils.getFormattedUnitString(calc_stats.xp_rate * 3600, "integer/hour")
    level_model.rested_xp_time_saved = calc_stats.rested_xp_time_saved
    
    table.insert(model.stats_by_level, level_model)
  end
  
  return model
end

function m.buildCharacterStatsModel(character_guid)
  local model = {}
  model.char = ds.getCharacter(character_guid)
  local overall_stats = ds.getCharacterOverallStats(character_guid)
  
  model.elapsed_time = overall_stats.elapsed_time
  
  local calc_stats = calc.calculateSessionStats(overall_stats, overall_stats.elapsed_time, model.char) 
  model.xp_rate = calc_stats.xp_rate * 3600
  model.pct_levels_rate = calc_stats.pct_levels_rate * 3600
  model.rested_xp_time_saved = calc_stats.rested_xp_time_saved
  
  local percents = calc.calculateXpSourcePercents(overall_stats)
  local activity_xp_rates = calc.calculateXpRates(overall_stats)
  
  local stats_by_level = ds.getCharacterStatsByLevel(character_guid)
  local xp_per_event = calc.calculateAveragePctLevelPerEvent(stats_by_level)
  
  model.xp_sources = {}
  model.sorted_percent_keys = table_utils.getKeysBySortedValues(percents, descendingComparator)
  for k,v in pairs(percents) do
    local per = string.format("%.2f%%", safemult(xp_per_event[k], 100))
    
    model.xp_sources[k] = { pct = math_utils.getFormattedUnitString(v, "percent"),
                            rate = math_utils.getFormattedUnitString(activity_xp_rates[k] * 3600, "integer/hour"),
                            per = (per == "0.00%" and "<0.01%") or per,
                            num = overall_stats[num_event_keys[k]]
                          }
  end
  
  return model
end

function m.buildSessionMonitorModel()
  local session, char, recorder_started, recorder_running = rm.getRunningSessionData()
  if (not recorder_started) then
    return nil
  end
  
  local model = table_utils.shallowCopy(lc.UI.ModelTemplates.SessionMonitor)
  
  model.recorder_started = recorder_started
  model.recorder_running = recorder_running
  
  local overall_stats = ds.getCharacterOverallStats(char.guid)
  local saved_level_stats = ds.getCharacterLevelStats(char.guid, char.level)
  local current_level_stats = (not saved_level_stats and session.stats_by_level[char.level]) or table_utils.addTables(saved_level_stats, session.stats_by_level[char.level])
  
  if (overall_stats) then
  
    model.average_xp_rate = math_utils.getFormattedUnitString((overall_stats.total_xp_gained / overall_stats.elapsed_time) * 3600, "integer/hour")
    
    local average_calc_stats = calc.calculateSessionStats(overall_stats, overall_stats.elapsed_time, char)
    model.avg_time_to_level = string_utils.getTimerFormat(average_calc_stats.time_to_level)
    
    model.num_to_level = calc.calculateToLevelNumbers(current_level_stats, char)
    
    for k,v in pairs(model.num_to_level) do
      model.num_to_level[k] = math.ceil(v)
    end
    
    if (session) then
      model.elapsed_time = session.elapsed_time
      model.elapsed_time_string = string_utils.getTimerFormat(session.elapsed_time)
      
      local delta = recorder_running and (LCTimeUtils.systemTime() - session.current_time) or 0
      model.live_timer_string = string_utils.getTimerFormat(session.elapsed_time + delta)
      
      model.xp_gained = session.stats.total_xp_gained
      
      local session_calculated_stats = calc.calculateSessionStats(session.stats, session.elapsed_time, char)
      
      model.xp_rate = math_utils.getFormattedUnitString(session_calculated_stats.xp_rate * 3600, "integer/hour")
      model.rested_xp_time_saved = math_utils.getFormattedUnitString(session_calculated_stats.rested_xp_time_saved, "time")
      model.time_to_level = math_utils.getFormattedUnitString(session_calculated_stats.time_to_level, "time")
      model.time_to_level_timer = string_utils.getTimerFormat(session_calculated_stats.time_to_level)
    end
  end
  
  return model
end

function m.getCurrentCharacter()
  local session, char = rm.getRunningSessionData()
  
  return char
end

function m.pauseRecorder()
  rm.stopRecorder()
end

return m