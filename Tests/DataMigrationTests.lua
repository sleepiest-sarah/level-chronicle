local lt = require('Libs.LuaTesting.LuaTesting')

local table_utils = require('Libs.LuaCore.Utils.TableUtils')

local dm = require('Utils.DataMigrations')

local lu = require('luaunit')

DataMigrationTests = {}

function DataMigrationTests:testRunMigrations()
  lcCharacterDb = {
    characters = {
        ["test-guid"] = {
            stats = {
                total = {
                    elapsed_time = 1500
                  }
              },
            stats_by_level = {
                ["45"] = {
                    elapsed_time = 500
                  },
                ["46"] = {
                    elapsed_time = 1000
                  }
              },
         }
      }
  }
  
  dm.runDataMigrations("1.0", "1.0.1")
  
  lu.assertEquals(lcCharacterDb.characters["test-guid"].stats.total.elapsed_time, 1500)
  
  dm.runDataMigrations("1.0-beta-1", "1.0")
  
  lu.assertEquals(lcCharacterDb.characters["test-guid"].stats.total.elapsed_time, 750)
end

lu.LuaUnit.verbosity = lu.VERBOSITY_VERBOSE
lu.LuaUnit.run('DataMigrationTests')