local lc = require('Utils.Constants') or LevelingChronicle

local table_utils = require('Libs.LuaCore.Utils.TableUtils') or LCTableUtils
local time_utils = require('Libs.LuaCore.Utils.TimeUtils') or LCTimeUtils

local templates = require('Objects.RecordTemplates') or lc.RecordTemplates

local db

lc.DataAccess = {}
local da = lc.DataAccess

function da.initializeDatabase()
  lcCharacterDb = lcCharacterDb or {}
  db = lcCharacterDb
  
  db = table_utils.addKeysLeft(db, templates.character_db_template)
end

function da.updateDatabaseSchema()
  for guid, char_record in pairs(db.characters) do
    table_utils.addKeysLeft(char_record, templates.character_record_template)
    
    for level, level_record in pairs(char_record.stats_by_level) do
      table_utils.addKeysLeft(level_record, templates.stats_record_template)
    end
    
    for _,session_record in ipairs(char_record.sessions) do
      table_utils.addKeysLeft(session_record, templates.stats_record_template)
    end
    
    for level, level_event_record in pairs(char_record.events.levels) do
      table_utils.addKeysLeft(level_event_record, templates.level_event_template)
    end
  end
end

function da.getDatabaseVersion()
  return db.metadata.database_version
end

function da.updateDatabaseVersion(version)
  db.metadata.database_version = version
end

function da.saveSession(char, session)
  local char_record = da.getCharacter(char)
  
  local session_record = session.stats
  session_record.elapsed_time = session.elapsed_time
  session_record.start_time = session.start_time
  session_record.end_time = session.end_time
  table.insert(char_record.sessions, session_record)
  
  local stats_record = char_record.stats.total or {}
  stats_record = table_utils.addTables(stats_record, session.stats)
  stats_record.elapsed_time = (stats_record.elapsed_time or 0) + session.elapsed_time
  
  char_record.stats.total = stats_record
  
  for level,stats in pairs(session.stats_by_level) do
    local level_string = tostring(level)
    local saved_record = char_record.stats_by_level[level_string] or {}
    saved_record = table_utils.addTables(saved_record, stats)
    saved_record.elapsed_time = (saved_record.elapsed_time or 0) + stats.elapsed_time
    
    char_record.stats_by_level[level_string] = saved_record
  end
  
  for evtType, events in pairs(session.events) do
    for key, event in pairs(events) do
      char_record.events[evtType][tostring(key)] = event
    end
  end
end

function da.saveCharacter(char)
  local char_record = da.getCharacter(char)
  
  if (not char_record) then
    db.characters[char.guid] = {}
    char_record = db.characters[char.guid]
  end
  
  char_record = table_utils.addKeysLeft(char_record, templates.character_record_template)
  
  local unit = char_record.unit_data
  unit.guid = char.guid
  unit.name = char.name
  unit.realm = char.realm
  unit.class = char.class
  unit.level = char.level
  unit.max_level = char.max_level
  unit.xp = char.xp
  unit.max_xp = char.max_xp
  unit.rested_xp = char.rested_xp
  unit.xp_disabled = char.xp_disabled
  unit.last_updated = time_utils.unixTime()
end

function da.getCharacter(char)
  return da.getCharacterByGuid(char.guid)
end

function da.getCharacterByGuid(guid)
  return db.characters[guid]
end

function da.getCharacters()
  return db.characters
end

function da.getCharacterOverallStatsByGuid(guid)
  return db.characters[guid] and db.characters[guid].stats.total
end

function da.getCharacterStatsByLevelByGuid(guid)
  return db.characters[guid] and db.characters[guid].stats_by_level
end

function da.getCharacterLevelEvents(guid)
  return db.characters[guid] and db.characters[guid].events and db.characters[guid].events.levels
end

return da