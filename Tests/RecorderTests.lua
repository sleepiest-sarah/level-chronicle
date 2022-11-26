local lt = require('Libs.LuaTesting.LuaTesting')

local lc = require('Journey') or LevelingChronicle
local evf = require('Libs.WowEventFramework.WowEventFramework')
local table_utils = require('Libs.LuaCore.Utils.TableUtils')

local Character = require('Objects.Character') or lc.Character
local recorder = require('Recorder.Recorder') or lc.Recorder

local basic_level_reel = require('EventVCR.Reels.BasicLevelingReel')
local replayer = require('EventVCR.Replayer')

local lu = require('luaunit')

TestRecorder = {}

function TestRecorder:tearDown()
  evf.unregisterAllEvents()
end

function TestRecorder:testRecorderRunsSuccessfully()
  local char_mock = Character:new()
  char_mock.guid = "Player-1096-06DF65C1"
  char_mock.name = "Airei"
  char_mock.realm = "Gorgonnash"
  char_mock.max_level = 60
  char_mock.level = 3
  char_mock.xp = 15
  char_mock.max_xp = 250
  char_mock.rested_xp = 0
  
  recorder.initialize(char_mock)
  recorder.start()
  
  UnitXP = function () return 37 end
  UnitMaxXP = function () return 250 end
  
  lt.fireEvent("CHAT_MSG_COMBAT_XP_GAIN", "Rampaging Worgen dies, you gain 22 experience.")
  lt.fireEvent("PLAYER_XP_UPDATE", "player")
  lt.fireEvent("QUEST_TURNED_IN", 14093, 100)
  
  UnitXP = function () return 137 end
  lt.fireEvent("PLAYER_XP_UPDATE", "player")
  
  recorder.close()
  
  local stats = recorder.session.stats
  lu.assertEquals(stats.total_xp_gained, 122)
  lu.assertEquals(stats.quest_xp_gained, 100)
  lu.assertEquals(stats.kill_xp_gained, 22)
  
  lu.assertEquals(stats.num_quests_completed, 1)
  lu.assertEquals(stats.num_kills, 1)
  
  lu.assertNotNil(recorder.session.end_time)
end

function TestRecorder:testRecorderWithReel()
  replayer.fastForward(basic_level_reel)
  
  --didn't capture these in the reel
  UnitFullName = function () return "Airei", "Gorgonnash" end
  UnitGUID = function () return "Player-71-0BBA3E27" end
  
  local char = Character:new()
  char:loadCharacterData("player")
  
  recorder.initialize(char)
  recorder.start()
  
  replayer.play(basic_level_reel, lt.fireEvent)
  
  recorder.close()
  
  lu.assertEquals(recorder.session.stats.quest_xp_gained, 420)
end

lu.LuaUnit.verbosity = lu.VERBOSITY_VERBOSE
lu.LuaUnit.run('TestRecorder')