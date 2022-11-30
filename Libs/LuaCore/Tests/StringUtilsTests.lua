local stringUtils = require('Libs.LuaCore.Utils.StringUtils')

local lu = require('luaunit')

TestStringUtils = {}

function TestStringUtils:testCapitalizeString()
  local result = stringUtils.capitalizeString("bear in a chair.")
  
  lu.assertIsString(result)
  lu.assertEquals(result, "Bear in a chair.")
  
  result = stringUtils.capitalizeString("BEAR")
  
  lu.assertEquals(result, "BEAR")
  
  result = stringUtils.capitalizeString("8ear")
  lu.assertIsString(result)
  lu.assertEquals(result, "8ear")
end

function TestStringUtils:testGenerateUUID()
  local uuid1 = stringUtils.generateUUID()
  local uuid2 = stringUtils.generateUUID()
  
  lu.assertNotEquals(uuid1, uuid2)
  lu.assertIsString(uuid1)
  lu.assertEquals(#uuid1, 36)
end

function TestStringUtils:testSplit()
  local a,b = stringUtils.split("bear.chair", ".")
  
  lu.assertEquals(a, "bear")
  lu.assertEquals(b, "chair")
  
  local a,b,c = stringUtils.split("-bear-chair", "-")
  
  lu.assertEquals(a, "")
  lu.assertEquals(b, "bear")
  lu.assertEquals(c, "chair")
  
  a,b = stringUtils.split(".", ".")
  
  lu.assertEquals(a, "")
  lu.assertEquals(b, "")
  
  a,b,c = stringUtils.split("bear.chair.", ".")
  
  lu.assertEquals(a, "bear")
  lu.assertEquals(b, "chair")  
  lu.assertEquals(c, "")
end

function TestStringUtils.testConvertToTimerFormat()
  local res = stringUtils.getTimerFormat(39)
  
  lu.assertEquals(res, "00:00:39")
  
  res = stringUtils.getTimerFormat(3600)
  
  lu.assertEquals(res, "01:00:00")
  
  res = stringUtils.getTimerFormat(7262)
  
  lu.assertEquals(res, "02:01:02")
  
  res = stringUtils.getTimerFormat(nil)
  
  lu.assertEquals(res, "-")
  
  res = stringUtils.getTimerFormat(0)
  
  lu.assertEquals(res, "00:00:00")
  
  res = stringUtils.getTimerFormat(105916.292)
  
  lu.assertEquals(res, "29:25:16")
end

function TestStringUtils.testGetLongFormDurationFormat()
  local res = stringUtils.getLongFormDurationFormat(3801)
  
  lu.assertEquals(res, "1 hour 3 minutes")
end

function TestStringUtils:testToNumber()
  local res = stringUtils.toNumber("Aitek")
  
  lu.assertEquals(type(res), "number")
  lu.assertEquals(res, 91)
  
  res = stringUtils.toNumber("Alraera")
  
  lu.assertEquals(res, 119)
end

lu.LuaUnit.verbosity = lu.VERBOSITY_VERBOSE
lu.LuaUnit.run('TestStringUtils')