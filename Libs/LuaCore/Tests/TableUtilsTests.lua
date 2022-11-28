local tableUtils = require('Libs.LuaCore.Utils.TableUtils')

local lu = require('luaunit')

TestTableUtils = {}

function TestTableUtils:testLength()
  local res = tableUtils.length({'a', 'b', 'c'})
  
  lu.assertEquals(res, 3)
  
  res = tableUtils.length({a = 'a', b = 'b', c = 'c'})
  
  lu.assertEquals(res, 3)
  
  res = tableUtils.length({})
  
  lu.assertEquals(res, 0)
end

function TestTableUtils:testAddTables()
  local res = tableUtils.addTables({a = 5, b = 10}, {a = 10, b = 20, c = 1})
  
  lu.assertEquals(res, {a = 15, b = 30, c = 1})
end

function TestTableUtils:testPrintTableList()
  local p = print
  print = function () end
  
  tableUtils.printTable({{"bear", {a = "b", b = "a"}}, {"chair"}})
  
  print = p
end

function TestTableUtils:testAddKeysLeft()
  local a = {a = 5, b = 10}
  local res = tableUtils.addKeysLeft(a, {a = 0, b = 0, c = 1})
  
  lu.assertIs(a, res)
  lu.assertEquals(res.a, 5)
  lu.assertEquals(res.c, 1)
  
  a = {a = 5, b = 10}
  res = tableUtils.addKeysLeft(a, {a = 0, b = 0, c = {d = 15, e = 10, f = {}}})
  
  lu.assertIs(a, res)
  lu.assertEquals(res.a, 5)
  lu.assertIsTable(res.c)
  lu.assertEquals(res.c.d, 15)
  lu.assertIsTable(res.c.f)
  
  res = tableUtils.addKeysLeft({a = 5, b = 10},{a = 0, b = 0})
  
  lu.assertEquals(res,{a = 5, b = 10})
  
  a = {a = 5, b = 10, c= {}}
  res = tableUtils.addKeysLeft(a, {a = 0, b = 0, c = {d = 15}})
  
  lu.assertEquals(res, {a = 5, b = 10, c = {d = 15}})
  
  a = {a = true, b = false}
  res = tableUtils.addKeysLeft(a, {a = true, b = true})
  
  lu.assertEquals(a, {a = true, b = false})
end

function TestTableUtils:testGetKeysBySortedValues()
  local res = tableUtils.getKeysBySortedValues({a = 5, b = 2, c = 4})
  
  lu.assertEquals(res, {"b", "c", "a"})
  
  res = tableUtils.getKeysBySortedValues({a = 5, b = 2, c = 4, d = 4})
  lu.assertEquals(res[1], "b")
  lu.assertEquals(res[4], "a")
  --duplicate values should be adjacent but no guarantee as to their exact order
  lu.assertTrue(res[2] == "d" or res[2] == "c")
  lu.assertTrue(res[3] == "d" or res[3] == "c")
  
  res = tableUtils.getKeysBySortedValues({a = 5, b = 2, c = 4}, function (a,b) return a > b end)
  
  lu.assertEquals(res, {"a", "c", "b"})
end

function TestTableUtils:testAddTables()
  local a,b = {x = 5, y = 8}, {x = 3, y = 10, z = 15}
  local res = tableUtils.addTables(a,b)
  
  lu.assertNotIs(res,a)
  lu.assertNotIs(res,b)
  
  lu.assertEquals(res, {x = 8, y = 18, z = 15})
  
  a,b = {x = 5, y = 8, z = {g = 2}}, {x = 3, y = 10, z = {g = 4, h = 13}}
  res = tableUtils.addTables(a,b)
  
  lu.assertEquals(res, {x = 8, y = 18, z = {g = 6, h = 13}})
  
  lu.assertNotIs(res.z, a.z)
  lu.assertNotIs(res.z, b.z)
end

function TestTableUtils:testShallowCopy()
  local a = {x = {a = 10, b = 20, c = 1}, y = {a = 5, b = 2, c = 4, d = 4}}
  
  local res = tableUtils.shallowCopy(a)
  
  lu.assertNotIs(a, res)
  lu.assertIs(a.x, res.x)
  lu.assertIs(a.y, res.y)
end
  
lu.LuaUnit.verbosity = lu.VERBOSITY_VERBOSE
lu.LuaUnit.run('TestTableUtils')