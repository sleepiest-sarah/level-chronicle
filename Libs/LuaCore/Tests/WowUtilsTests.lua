local wowUtils = require('Libs.LuaCore.Utils.WowUtils')

local lu = require('luaunit')

TestWowUtils = {}

function TestWowUtils:testGetCoppersFromText()
  local res = wowUtils.getCoppersFromText("10 Gold 15 Silver 1 Copper")
  
  lu.assertEquals(res, 101501)
end

function TestWowUtils:testGetCurrencyString()
  local res = wowUtils.getCurrencyString(101501)
  
  lu.assertEquals(res, "10g15s1c")
end

lu.LuaUnit.verbosity = lu.VERBOSITY_VERBOSE
lu.LuaUnit.run('TestWowUtils')