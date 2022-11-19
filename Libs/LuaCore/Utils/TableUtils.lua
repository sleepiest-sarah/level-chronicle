LCTableUtils = {}

local tableUtils = LCTableUtils

function tableUtils.printTable(t, depth)
  depth = depth or 0
  
  if (not t or depth > 5) then
    return
  end
  
  for k,v in pairs(t) do
    if (type(v) == "table") then
      print(string.format("%s:", tostring(k)))
      tableUtils.printTable(v, depth + 1)
    else
      print(string.format("%s: %s", tostring(k), tostring(v)))
    end
  end
end

function tableUtils.shallowCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function tableUtils.deepCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[tableUtils.deepCopy(orig_key)] = tableUtils.deepCopy(orig_value)
        end
        setmetatable(copy, tableUtils.shallowCopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function tableUtils.getKeys(t)
  local keys = {}
  
  for k,_ in pairs(t) do
    table.insert(keys, k)
  end
  
  return keys  
end

function tableUtils.getValues(t)
  local values = {}
  
  for _,v in pairs(t) do
    table.insert(values, v)
  end
  
  return values
end

function tableUtils.getKeyForMaxValue(t,subkey)
  local max = -math.huge
  local max_key = nil
  
  for k,v in pairs(t) do
    if (subkey and v[subkey] > max) then
      max_key = k
      max = v[subkey]
    elseif (not subkey and v > max) then
      max_key = k
      max = v
    end
  end
  
  return max_key
end

function tableUtils.getKeyForMinValue(t,subkey)
  local min = math.huge
  local min_key = nil
  
  for k,v in pairs(t) do
    if (subkey and v[subkey] < min) then
      min_key = k
      min = v[subkey]
    elseif (not subkey and v < min) then
      min_key = k
      min = v
    end
  end
  
  return min_key
end

function tableUtils.getKeysBySortedValues(t, comparator)
  local values = tableUtils.getValues(t)
  table.sort(values, comparator)
  
  local sorted_keys = {}
  for k,v in pairs(t) do
    for i,sorted_val in ipairs(values) do
      if (v == sorted_val) then
        if (sorted_keys[i]) then
          sorted_keys[i+1] = k
        else
          sorted_keys[i] = k
        end
        break
      end
    end
  end
  
  return sorted_keys
end

--Blizzard has tContains(table, value)
function tableUtils.contains(t,value)
  for i,v in ipairs(t) do
    if (v == value) then
      return i
    end
  end
  return nil
end

--#table doesn't work for non-integer indexes
function tableUtils.length(t)
  local count = 0
  for _,_ in pairs(t) do
    count = count + 1
  end
  
  return count
end

function tableUtils.keyTable(t)
  local res = {}
  for i,v in pairs(t) do
    res[v] = v
  end
  
  return res
end

--b expected to be the most up to date in the case of missing keys
function tableUtils.addTables(a,b,shallow)
  local res = {}
  
  for k,v in pairs(b) do
    if (type(v) == "table" and not shallow) then
      if (a[k] == nil) then
        a[k] = {}
      end
      res[k] = tableUtils.addTables(a[k], v)
    elseif (tonumber(v)) then
      if (a[k] == nil) then
        a[k] = 0
      end
      res[k] = a[k] + tonumber(v)
    end
  end
  
  return res
end

function tableUtils.subtractTables(b,a)
  local res = {}
  
  for k,v in pairs(b) do
    if (type(v) == "table") then
      if (a[k] == nil) then
        a[k] = {}
      end
      res[k] = tableUtils.subtractTables(v,a[k])
    elseif (tonumber(v) ~= nil) then
      if (a[k] == nil) then
        a[k] = 0
      end
      res[k] = tonumber(v) - a[k]
    end
  end
  
  return res 
end

function tableUtils.addKeysLeft(a,b)
  a = a or {}
  for k,v in pairs(b) do
    if (type(v) == 'table') then
      a[k] = a[k] or {}
      tableUtils.addKeysLeft(a[k], v)
    elseif (a[k] == nil) then
      a[k] = v
    end
  end
  
  return a
end

function tableUtils.rand(t)
  local rand_index = math.random(1,#t)
  return t[rand_index]
end

return LCTableUtils