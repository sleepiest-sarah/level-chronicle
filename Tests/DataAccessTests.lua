local lt = require('Libs.LuaTesting.LuaTesting')

local table_utils = require('Libs.LuaCore.Utils.TableUtils')

local ds = require('Utils.DataServices')
local da = require('Utils.DataAccess')

local lu = require('luaunit')

DataAccessTests = {}

function DataAccessTests.testAggregateSessions()
  local sessions = {
      [1] = {
            total_xp_gained = 50,
            pet_battle_xp_gained = 15,
            gathering_xp_gained = 10,
        },
      [2] = {
            total_xp_gained = 31,
            pet_battle_xp_gained = 0,
            gathering_xp_gained = 10,
        },
      [3] = {
            total_xp_gained = 65,
            pet_battle_xp_gained = 20,
            gathering_xp_gained = 10,
        },
    }
    
  da.initializeDatabase()
  lcCharacterDb.characters["test"] = {}
  lcCharacterDb.characters["test"].sessions = sessions
  
  local res = ds.getAggregatedSessionStats("test")
  
  lu.assertEquals(res, {
            total_xp_gained = 146,
            pet_battle_xp_gained = 35,
            gathering_xp_gained = 30,
        })
      
  res = ds.getAggregatedSessionStats("test", 2)
  
  lu.assertEquals(res, {
            total_xp_gained = 96,
            pet_battle_xp_gained = 20,
            gathering_xp_gained = 20,
        })
end

lu.LuaUnit.verbosity = lu.VERBOSITY_VERBOSE
lu.LuaUnit.run('DataAccessTests')