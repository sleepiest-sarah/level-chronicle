local lc = require('Utils.Constants') or LevelingChronicle

local table_utils = require('Libs.LuaCore.Utils.TableUtils') or LCTableUtils

local templates = require('Objects.RecordTemplates') or lc.RecordTemplates

local db

lc.OptionsDataAccess = {}
local da = lc.OptionsDataAccess

function da.initializeDatabase()
  lcOptionsDb = lcOptionsDb or {}
  db = lcOptionsDb
  
  lcOptionsDb = table_utils.addKeysLeft(lcOptionsDb, templates.options_db_template)
end

function da.saveUiState(state)
  db.ui.state.session_monitor_visible = state.session_monitor_visible
  db.ui.state.session_monitor_expanded = state.session_monitor_expanded
  db.ui.state.rp_mode_on = state.rp_mode_on
end

function da.getUiState()
  return db.ui.state
end

function da.saveOptions(options)
  db.options.minimap_show = options.minimap_show
  db.options.show_monitor_on_login = options.show_monitor_on_login
end

function da.getOptions()
  return db.options
end

return da