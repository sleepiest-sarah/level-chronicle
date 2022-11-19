LCMathUtils = {}

local mathUtils = LCMathUtils

-- Converts a number into k = thousands and m = millions format with (precision) decimal places
-- e.g. 1200 = 1.2k, 1250000 = 1.25m, 500 = 500
function mathUtils.getShorthandNumber(n,precision)
  precision = precision or 0
  
  local format = "%." .. tostring(precision) .. "f"
  
  local res
  if (n > 1000 and n < 1000000) then
    n = (n * 1.0) / 1000
    res = string.format(format,n).."k"
  elseif (n > 1000000) then
    n = (n * 1.0) / 1000000
    res = string.format(format,n).."m"
  else
    res = string.format(format,n)
  end  
  
  return res
end

-- formats string according to the units type
-- valid units values:
--  string = "n"
--  integer = equivalent of getCommaFormattedNumberString or getShorthandNumber for numbers larger than 1m
--  time = expects time in seconds; 23s, 5m22s, 1h32m14s
--  decimal = n rounded to two decimal places
-- abbr returns a shorter version of the formatted string; behavior changes according to the unit type
function mathUtils.getFormattedUnitString(n,units,abbr)
  if (not n or mathUtils.isInf(n) or mathUtils.isNan(n)) then
    return "-"
  end
  
  if (units == "string") then
    return n
  end
  
  local res
  if (units == "integer") then
    res = (abbr or n > 1000000) and q:getShorthandNumber(n) or q:getCommaFormattedNumberString(n)
  elseif (units == "time") then
    local min,sec,hour
    if (n < 60) then
      n = math.floor(n)
      res = tostring(n).."s"
    elseif (n >= 60 and n < 3600) then
      min = math.floor(n/60)
      sec = math.floor(n) % 60
      res = tostring(min).."m"..tostring(sec).."s"
    elseif (n >= 3600) then
      hour = math.floor(n/3600)
      min = math.floor((n % 3600)/60)
      sec = math.floor(n) % 60
      res = tostring(hour).."h"..tostring(min).."m"..tostring(sec).."s"
    end
    
    if (abbr and hour) then
      res = tostring(hour).."h"..tostring(min).."m"
    end
  elseif (units == "decimal") then
    res = string.format("%.2f",n)
  elseif (units == "integer/hour" or units == "integer/day") then
    res = mathUtils.getShorthandNumber(n)
  elseif (units == "decimal/hour") then
    res = mathUtils.getShorthandNumber(n,2,true)
  elseif (units == "percentage") then
    n = (n - math.floor(n)) > .5 and math.ceil(n) or math.floor(n)
    res = tostring(n).."%"
  elseif (units == "percent") then
    res = mathUtils.getFormattedUnitString(n * 100,"percentage")
  elseif (units == "money") then 
    if (abbr and n > 10000) then
      local copper = math.floor(n) % 100
      n = n - copper
    end
    local negative = n < 0
    res = GetCoinTextureString(math.abs(n))
    if (negative) then
      res = "-"..res
    end
  elseif (units == "money/hour") then
    if (abbr and n > 10000) then 
      local copper = math.floor(n) % 100
      n = n - copper
    end
    local negative = n < 0
    res = GetCoinTextureString(math.abs(n))
    if (negative) then
      res = "-"..res
    end
  end
    
  return res
end

--returns a string with commas after the thousands place
-- eg 1300 = 1,300; 1500000 = 1,500,000
function mathUtils.getCommaFormattedNumberString(n)
  if (n < 1000) then
    return tostring(n)
  end
  
  local decimalParts
  n, decimalParts = math.modf(n)
  
  n = string.reverse(tostring(n))

  local res = ""
  for i=#n,1,-1 do
    local c = string.sub(n, i, i)
    if (i ~= #n and i % 3 == 0) then
      res = res..","
    end
    
    res = res..c
  end
  
  if (decimalParts ~= 0) then
    res = res..string.sub(string.format("%.1f", decimalParts),2)
  end
  
  return res
end

function mathUtils.isInf(n)
  return n == math.huge or n == -math.huge
end

function mathUtils.isNan(n)
  return n ~= n
end

--mathematically this is reflecting over the y-axis and then translating back into its original position
--effectively it's just swapping the UR x coord with the UL x coord and the LR x coord with the LL x coord
function mathUtils.reflectRectInPlace(coords)
  if (coords.top) then
    return {ULx = coords.right, ULy = coords.top
           ,LLx = coords.right, LLy = coords.bottom
           ,URx = coords.left, URy = coords.top
           ,LRx = coords.left, LRy = coords.bottom}
  else
    return {ULx = coords.URx, ULy = coords.ULy
           ,LLx = coords.LRx, LLy = coords.LLy
           ,URx = coords.ULx, URy = coords.URy
           ,LRx = coords.LLx, LRy = coords.LRy}
  end
end

--true if a approximately equals b
function mathUtils.approxEquals(a,b,precision)
  precision = precision and (1 / 10^precision) or 0.0001
  return a <= b+precision and a >= b-precision
end

function mathUtils.rand(low, high, seed)
  local state = seed or os.time()
  
	local M = 0x7fffffff
	local A = 48271
	local Q = M / A
	local R = M % A
  
  local div = state / Q
  local rem = state % Q
  
  local s = rem * A
  local t = div * R
  local result = s- t
  
  result = result < 0 and result + M or result

  return low + math.floor(result % (1 + high - low))
end

-- returns a / b or 0 if divide by 0
function mathUtils.safediv(a,b)
  a = a or 0
  b = b or 0
  local res = a / b
  return (mathUtils.isInf(res) or mathUtils.isNan(res)) and 0 or res
end

-- returns a * b converting params to 0 if nil
function mathUtils.safemult(a,b)
  a = a or 0
  b = b or 0
  return a * b
end

return mathUtils