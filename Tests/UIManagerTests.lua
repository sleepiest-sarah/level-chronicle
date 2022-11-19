local lt = require('Libs.LuaTesting.LuaTesting')

local lc = require('LevelingChronicle') or LevelingChronicle
local evf = require('Libs.WowEventFramework.WowEventFramework')
local table_utils = require('Libs.LuaCore.Utils.TableUtils')

require('UI.Constants.UIConstants')
require('UI.Constants.Strings')
require('UI.Constants.Definitions')
require('UI.Constants.ModelTemplates')
local ui_manager = require('UI.UIManager')

local lu = require('luaunit')

UIManagerTests = {}

function UIManagerTests.testSessionMonitorUpdate()
  ui_manager.buildSessionMonitorModel()
end

function UIManagerTests.testSessionMonitorNewCharacter()
  pcall(lt.fireEvent, "ADDON_LOADED", lc.ADDON_NAME)
  lt.fireEvent("PLAYER_LOGIN")
  
  ui_manager.buildSessionMonitorModel()
end

lu.LuaUnit.verbosity = lu.VERBOSITY_VERBOSE
lu.LuaUnit.run('UIManagerTests')