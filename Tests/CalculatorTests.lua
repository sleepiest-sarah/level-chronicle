local lt = require('Libs.LuaTesting.LuaTesting')

local calc = require('Utils.Calculator')

local lu = require('luaunit')

CalculatorTests = {}

function CalculatorTests.testCalculatePctLevelPerEvent()
  local stats = { 
          num_battlegrounds_completed = 3,
          total_xp_gained = 1000,
          battleground_xp_gained = 750,
        }
        
  local res = calc.calculatePctLevelPerEvent(stats)
  
  lu.assertAlmostEquals(res.battleground, 0.25, .00000001)
end

function CalculatorTests.testCalculateAveragePctLevelPerEvent()
  local stats = {
      ["25"] = { --.3333333333
          num_battlegrounds_completed = 3,
          total_xp_gained = 210,
          battleground_xp_gained = 210,
        },
      ["26"] = { --.25
          num_battlegrounds_completed = 2,
          total_xp_gained = 300,
          battleground_xp_gained = 150,
        },
      ["27"] = { --.5
          num_battlegrounds_completed = 1,
          total_xp_gained = 500,
          battleground_xp_gained = 250,
        },   
    }
    
  local res = calc.calculateAveragePctLevelPerEvent(stats)
  
  lu.assertAlmostEquals(res.battleground, .3333333, .000001)
end

lu.LuaUnit.verbosity = lu.VERBOSITY_VERBOSE
lu.LuaUnit.run('CalculatorTests')