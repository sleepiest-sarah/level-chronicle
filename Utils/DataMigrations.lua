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

-- return true if parameter a is an older version than parameter b
function m.versionCompare(a,b)
  local version_a, maturity_a, build_a = string.match(a, "(%d+%.%d+)%-?(%a*)%-?(%d*)")
  local version_b, maturity_b, build_b = string.match(b, "(%d+%.%d+)%-?(%a*)%-?(%d*)")
  
  maturity_a = maturity_a == "alpha" and 1 or maturity_a == "beta" and 2 or 3
  maturity_b = maturity_b == "alpha" and 1 or maturity_b == "beta" and 2 or 3
  
  build_a = build_a == "" and 0 or tonumber(build_a)
  build_b = build_b == "" and 0 or tonumber(build_b)
  
  if (version_a == version_b) then
    if (maturity_a == maturity_b) then
      return build_a < build_b
    else
      return maturity_a < maturity_b
    end
  end
  
  return tonumber(version_a) < tonumber(version_b)
end

function m.runDataMigrations(db_version, addon_version)
  
  if (m.versionCompare(db_version,"1.0")) then
    halfTotalAndLevelTimes()
  end
  
end

return m