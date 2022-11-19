local lc = require('Utils.Constants') or LevelingChronicle

local math_utils = require('Libs.LuaCore.Utils.MathUtils') or LCMathUtils
local safediv = math_utils.safediv

--TODO options for unit conversions and outputting sorted keys to reduce manager clutter
lc.Calculator = {}
local m = lc.Calculator

function m.calculateSessionStats(stats, elapsed_time, char)
  local res = {}
  elapsed_time = elapsed_time == 0 and 1 or elapsed_time
  
  res.xp_rate = stats.total_xp_gained / elapsed_time
  res.pct_levels_rate = (stats.pct_levels_gained or 0) / elapsed_time
  
  local total_xp_no_rested = stats.total_xp_gained - stats.bonus_rested_xp_gained
  local total_xp_no_rested_rate = total_xp_no_rested / elapsed_time
  res.rested_xp_time_saved = stats.bonus_rested_xp_gained / total_xp_no_rested_rate
  
  res.time_to_level = res.xp_rate == 0 and nil or ((char.max_xp - char.xp) / res.xp_rate)
  
  return res
end

function m.calculateToLevelNumbers(stats, char)
  local res = {}
  
  local xp_to_level = char.max_xp - char.xp
  
  --x_to_level = xp_to_level / (x_xp_gained / num_x_completed)
  res.kills_to_level = safediv(xp_to_level, safediv(stats.kill_xp_gained,stats.num_player_kills))
  res.quests_to_level = safediv(xp_to_level, safediv(stats.quest_xp_gained,stats.num_quests_completed))
  res.scenarios_to_level = safediv(xp_to_level, safediv(stats.scenario_xp_gained,stats.num_scenarios_completed))
  res.gathers_to_level = safediv(xp_to_level, safediv(stats.gathering_xp_gained,stats.num_gathers))
  res.battlegrounds_to_level = safediv(xp_to_level, safediv(stats.battleground_xp_gained,stats.num_battlegrounds_completed))
  res.pet_battles_to_level = safediv(xp_to_level, safediv(stats.pet_battle_xp_gained,stats.num_pet_battles))
  
  return res
end

function m.calculateXpSourcePercents(stats)
  local res = {}
  
  res.quest = safediv(stats.quest_xp_gained, stats.total_xp_gained)
  res.gathering = safediv(stats.gathering_xp_gained, stats.total_xp_gained)
  res.pet_battle = safediv(stats.pet_battle_xp_gained, stats.total_xp_gained)
  res.scenario = safediv(stats.scenario_xp_gained, stats.total_xp_gained)
  res.kill = safediv(stats.kill_xp_gained, stats.total_xp_gained)
  res.battleground = safediv(stats.battleground_xp_gained, stats.total_xp_gained)
  
  return res
end

function m.calculateXpRates(stats)
  local res = {}
  
  local open_world_time = stats.elapsed_time - stats.time_pet_battles - stats.time_scenarios - stats.time_battlegrounds
  res.pet_battle = safediv(stats.pet_battle_xp_gained, stats.time_pet_battles)
  res.gathering = safediv(stats.gathering_xp_gained, open_world_time)
  res.quest = safediv(stats.quest_xp_gained, open_world_time)
  res.scenario = safediv(stats.scenario_xp_gained, stats.time_scenarios)
  res.battleground = safediv(stats.battleground_xp_gained, stats.time_battlegrounds)
  res.kill = safediv(stats.kill_xp_gained, open_world_time) --TODO subtract out scenario kill xp
  --res.other = safediv(stats.other_xp_gained, open_world_time)
  
  return res
end

function m.calculateXpPerEvent(stats)
  local res = {}
  
  res.battleground = safediv(stats.battleground_xp_gained, stats.num_battlegrounds_completed)
  res.scenario = safediv(stats.scenario_xp_gained, stats.num_scenarios_completed)
  
  return res
end

function m.calculatePctLevelPerEvent(stats)
  local res = {}
  
  -- (activity_xp_gained / num_event) / total_xp_gained
  res.quest = safediv(safediv(stats.quest_xp_gained, stats.num_quests_completed), stats.total_xp_gained)
  res.gathering = safediv(safediv(stats.gathering_xp_gained, stats.num_gathers), stats.total_xp_gained)
  res.pet_battle = safediv(safediv(stats.pet_battle_xp_gained, stats.num_pet_battles), stats.total_xp_gained)
  res.scenario = safediv(safediv(stats.scenario_xp_gained, stats.num_scenarios_completed), stats.total_xp_gained)
  res.kill = safediv(safediv(stats.kill_xp_gained, stats.num_player_kills), stats.total_xp_gained)
  res.battleground = safediv(safediv(stats.battleground_xp_gained, stats.num_battlegrounds_completed), stats.total_xp_gained)  
  
  return res
end

function m.calculateAveragePctLevelPerEvent(char_level_records)
  local level_averages = {}
  local level_nums = {}
  local res = {}
  
  for level, level_record in pairs(char_level_records) do
    level_averages[level] = m.calculatePctLevelPerEvent(level_record)
    level_nums[level] = {
        quest = level_record.num_quests_completed,
        gathering = level_record.num_gathers,
        pet_battle = level_record.num_pet_battles,
        scenario = level_record.num_scenarios_completed,
        kill = level_record.num_player_kills,
        battleground = level_record.num_battlegrounds_completed
      }
  end
  
  local total_nums = {}
  local total_avg = {}
  for level, averages in pairs(level_averages) do
    local level_num = level_nums[level]
    for k,v in pairs(averages) do
      total_nums[k] = (total_nums[k] or 0) + (level_num[k] or 0)
      total_avg[k] = (total_avg[k] or 0) + (v * (level_num[k] or 0))  --weighted average
    end
  end
  
  for k,v in pairs(total_avg) do
    res[k] = safediv(v, total_nums[k])
  end
  
  return res
end

return m