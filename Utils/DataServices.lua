local lc = require('Utils.Constants') or LevelingChronicle

local da = require('Utils.DataAccess') or lc.DataAccess
local oda = require('Utils.OptionsDataAccess') or lc.OptionsDataAccess
local Character = require('Objects.Character') or lc.Character

lc.DataServices = {}
local ds = lc.DataServices

function ds.initializeDatabase()
  da.initializeDatabase()
  oda.initializeDatabase()
  
  local db_version = da.getDatabaseVersion()
  local addon_version = GetAddOnMetadata(lc.ADDON_NAME, "Version")
  if (db_version < addon_version) then
    da.updateDatabaseSchema()
    da.updateDatabaseVersion(addon_version)
  end
end

function ds.saveCharacter(char)
  da.saveCharacter(char)
end

function ds.saveCharacterSession(char, session)
  da.saveCharacter(char)
  
  if (session.elapsed_time > 0) then
    da.saveSession(char,session)
  end
end

--returns map of GUID to character record
function ds.getAllCharacters()
  local character_records = da.getCharacters()
  
  local res = {}
  for k,v in pairs(character_records) do
    res[k] = Character:new(v.unit_data)
  end
  
  return res
end

function ds.getCharacterOverallStats(character_guid)
  return da.getCharacterOverallStatsByGuid(character_guid)
end

function ds.getCharacterStatsByLevel(character_guid)
  return da.getCharacterStatsByLevelByGuid(character_guid)
end

function ds.getCharacterLevelStats(guid, level)
  level = tostring(level)
  return da.getCharacterStatsByLevelByGuid(guid)[level]
end

function ds.getCharacter(guid)
  local char = da.getCharacterByGuid(guid)
  return char and char.unit_data or nil
end

function ds.getCharacterLevelEvents(guid)
  return da.getCharacterLevelEvents(guid) or {}
end

function ds.getUiState()
  return oda.getUiState()
end

function ds.saveUiState(state)
  oda.saveUiState(state)
end

function ds.getSavedOptions()
  return oda.getOptions()
end

function ds.saveOptions(options)
  oda.saveOptions(options)
end
  
return ds