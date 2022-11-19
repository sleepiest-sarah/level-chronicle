local time_utils = require('Libs.LuaCore.Utils.TimeUtils')

local lu = require('luaunit')

TestTimeUtils = {}

function TestTimeUtils:testGetDurationParts()
  local s,m,h,d = time_utils.getDurationParts(98568)
  
  lu.assertEquals(d, 1)
  lu.assertEquals(h, 3)
  lu.assertEquals(m, 22)
  lu.assertEquals(s, 48)
  
  s,m,h,d = time_utils.getDurationParts(0)
  
  lu.assertEquals(d, 0)
  lu.assertEquals(h, 0)
  lu.assertEquals(m, 0)
  lu.assertEquals(s, 0)
  
  s,m,h,d = time_utils.getDurationParts(86401)
  
  lu.assertEquals(d, 1)
  lu.assertEquals(h, 0)
  lu.assertEquals(m, 0)
  lu.assertEquals(s, 1)
end

lu.LuaUnit.verbosity = lu.VERBOSITY_VERBOSE
lu.LuaUnit.run('TestTimeUtils')