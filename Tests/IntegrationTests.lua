local lt = require('Libs.LuaTesting.LuaTesting')

local lc = require('Journey') or LevelingChronicle
local evf = require('Libs.WowEventFramework.WowEventFramework')
local table_utils = require('Libs.LuaCore.Utils.TableUtils')

local basic_level_reel = require('EventVCR.Reels.BasicLevelingReel')
local pet_battle_reel = require('EventVCR.Reels.LevelChronicle_PetBattleReel')
local bg_reel = require('EventVCR.Reels.LevelChronicle_BgReel')
local dungeon_reel = require('EventVCR.Reels.LevelChronicle_DungeonReel')
local replayer = require('EventVCR.Replayer')

local lu = require('luaunit')

require('UI.Constants.UIConstants')
require('UI.Constants.Strings')
require('UI.Constants.Definitions')
require('UI.Constants.ModelTemplates')
local ui_manager = require('UI.Managers.UIManager')

IntegrationTests = {}

function IntegrationTests:tearDown()
  evf.unregisterAllEvents()
end

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

function IntegrationTests:testPetBattleReel()
  replayer.fastForward(pet_battle_reel)
  
  pcall(lt.fireEvent, "ADDON_LOADED", lc.ADDON_NAME)
  
  replayer.play(pet_battle_reel, lt.fireEvent)
  
  local session_record = lcCharacterDb.characters["Player-3678-0CD16205"].sessions[1]
  
  lu.assertEquals(session_record.num_kills, 0)
  lu.assertEquals(session_record.num_pet_battles, 2)
  lu.assertEquals(session_record.pet_battle_xp_gained, 367)
  lu.assertEquals(session_record.total_xp_gained, 367)
end

function IntegrationTests:testBattlegroundReel()
  replayer.fastForward(bg_reel)
  
  pcall(lt.fireEvent, "ADDON_LOADED", lc.ADDON_NAME)
  
  replayer.play(bg_reel, lt.fireEvent)
  
  local session_record = lcCharacterDb.characters["Player-3678-0CD16205"].sessions[1]
  
  lu.assertEquals(session_record.num_kills, 0)
  lu.assertEquals(session_record.num_pet_battles, 1)
  lu.assertEquals(session_record.num_battlegrounds_completed, 1)
  lu.assertEquals(session_record.num_quests_completed, 2)
  
  lu.assertTrue(session_record.time_pet_battles > 0)
  lu.assertEquals(session_record.time_battlegrounds, 736)
  
  lu.assertEquals(session_record.pet_battle_xp_gained, 160)
  lu.assertEquals(session_record.battleground_xp_gained, 20022)
  lu.assertEquals(session_record.quest_xp_gained, 1132)
  lu.assertEquals(session_record.total_xp_gained, 21314)
end

function IntegrationTests:testDungeonReel()
  
  replayer.fastForward(dungeon_reel)
  
  pcall(lt.fireEvent, "ADDON_LOADED", lc.ADDON_NAME)
  
  replayer.play(dungeon_reel, lt.fireEvent)
  
  local session_record = lcCharacterDb.characters["Player-3678-0CD16205"].sessions[1]  
  
  local model = ui_manager.buildCharacterJourneyModel("Player-3678-0CD16205", 2, 2)  
  
  lu.assertEquals(session_record.num_kills, 75)
  lu.assertEquals(session_record.num_kills_instance, 75)
  lu.assertEquals(session_record.num_kills_world, 0)
  lu.assertEquals(session_record.num_gathers, 4)
  lu.assertEquals(session_record.num_scenarios_completed, 1)
  lu.assertEquals(session_record.num_quests_completed, 0)
  
  lu.assertTrue(session_record.time_scenarios > 0)
  
  lu.assertEquals(session_record.gathering_xp_gained, 4960)
  lu.assertEquals(session_record.scenario_xp_gained, 65943)
  lu.assertEquals(session_record.kill_xp_instance_gained, 37742)
  lu.assertEquals(session_record.kill_xp_raw_instance_gained, 18871)
  lu.assertEquals(session_record.total_xp_gained, 71418)
end

lu.LuaUnit.verbosity = lu.VERBOSITY_VERBOSE
lu.LuaUnit.run('IntegrationTests.testDungeonReel')