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

function m.runDataMigrations(db_version, addon_version)
  if (string.find(db_version, "alpha") or string.find(db_version, "beta")) then
    halfTotalAndLevelTimes()
  end
  
end

return m