local lt = require('Libs.LuaTesting.LuaTesting')

local lc = require('Journey') or LevelingChronicle
local evf = require('Libs.WowEventFramework.WowEventFramework')
local table_utils = require('Libs.LuaCore.Utils.TableUtils')

require('UI.Constants.UIConstants')
require('UI.Constants.Strings')
require('UI.Constants.Definitions')
require('UI.Constants.ModelTemplates')
local ui_manager = require('UI.Managers.UIManager')

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

function UIManagerTests.testNewCharacterInTree()
  UnitGUID = function () return "test_guid" end
  
  pcall(lt.fireEvent, "ADDON_LOADED", lc.ADDON_NAME)
  lt.fireEvent("PLAYER_LOGIN")
  
  local model = ui_manager.buildCharacterTreeModel()
  
  lu.assertNotNil(model.character_colors["test_guid"])
  lu.assertEquals(#model.characters, 1)
  lu.assertNotNil(model.characters[1].text)
  lu.assertEquals(#model.characters[1].children, 1)
end

function UIManagerTests.testNewCharacterJourney()
  UnitGUID = function () return "test_guid" end
  
  pcall(lt.fireEvent, "ADDON_LOADED", lc.ADDON_NAME)
  lt.fireEvent("PLAYER_LOGIN")
  
  local model = ui_manager.buildCharacterJourneyModel("test_guid", nil, 2)  
  
  lu.assertNotNil(model)
end

lu.LuaUnit.verbosity = lu.VERBOSITY_VERBOSE
lu.LuaUnit.run('UIManagerTests')