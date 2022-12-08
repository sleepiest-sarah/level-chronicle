local lc = require('Utils.Constants') or LevelingChronicle

lc.DataMigrations = {}
local m = lc.DataMigrations

local function halfTotalAndLevelTimes()
  local db = lcCharacterDb
  for guid, char_record in pairs(db.characters) do
    char_record.stats.total.elapsed_time = char_record.stats.total.elapsed_time / 2
    
    for level, level_record in pairs(char_record.stats_by_level) do
      level_record.elapsed_time =  level_record.elapsed_time / 2
    end
  end
end

local function populateMaxLevelDateReached()
  local db = lcCharacterDb
  for guid, char_record in pairs(db.characters) do

    local unit_data = char_record.unit_data
    local max_level = unit_data.max_level
    if (max_level == unit_data.level and not char_record.events.levels[tostring(max_level)] and #char_record.sessions > 0) then
      local max_level_reached = char_record.sessions[#char_record.sessions].end_time
      char_record.events.levels[tostring(max_level)] = {date_reached = max_level_reached}
    end
  end  
end

function m.runDataMigrations(db_version, addon_version)
  if (string.find(db_version, "alpha") or string.find(db_version, "beta")) then
    halfTotalAndLevelTimes()
  end
  
  if (db_version < "1.0.3") then
    populateMaxLevelDateReached()
  end
  
end

return m