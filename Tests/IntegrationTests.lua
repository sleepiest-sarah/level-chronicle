local lt = require('Libs.LuaTesting.LuaTesting')

local lc = require('LevelingChronicle') or LevelingChronicle
local evf = require('Libs.WowEventFramework.WowEventFramework')
local table_utils = require('Libs.LuaCore.Utils.TableUtils')

local basic_level_reel = require('EventVCR.Reels.BasicLevelingReel')
local replayer = require('EventVCR.Replayer')

local lu = require('luaunit')

IntegrationTests = {}

function IntegrationTests.testFullIntegrationWithReel()
  replayer.fastForward(basic_level_reel)
  
  --didn't capture these in the reel
  UnitFullName = function () return "Airei", "Gorgonnash" end
  UnitGUID = function () return "Player-71-0BBA3E27" end
  
  pcall(lt.fireEvent, "ADDON_LOADED", lc.ADDON_NAME)
  
  lt.fireEvent("PLAYER_LOGIN")
  
  replayer.play(basic_level_reel, lt.fireEvent)
  
  lt.fireEvent("PLAYER_LOGOUT")
  
  lu.assertNotNil(lcCharacterDb)
end

lu.LuaUnit.verbosity = lu.VERBOSITY_VERBOSE
lu.LuaUnit.run('IntegrationTests')