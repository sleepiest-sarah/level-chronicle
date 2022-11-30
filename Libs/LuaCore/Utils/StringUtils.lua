local math_utils = require('Libs.LuaCore.Utils.MathUtils') or LCMathUtils
local time_utils = require('Libs.LuaCore.Utils.TimeUtils') or LCTimeUtils

LCStringUtils = {}
local m = LCStringUtils

function m.capitalizeString(str)
  local res
  
  if (str ~= nil and string.len(str) > 0) then
    local c = string.sub(str,0,1)
    c = string.upper(c)
    res = c..string.sub(str,2)
  end
  
  return res
end

function m.generateUUID()
  local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
  return string.gsub(template, '[xy]', function (c)
      local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
      return string.format('%x', v)
  end)
end

function m.split(s, delimiter)
  if (string.len(s) == 0) then
    return nil
  end
  
  local pieces = {}
  local piece_start = 1
  for i=1,string.len(s) do
    if (string.sub(s,i,i) == delimiter) then
      table.insert(pieces, string.sub(s, piece_start, i-1))
      piece_start = i+1
    end
  end
  
  table.insert(pieces, string.sub(s, piece_start))
  
  return unpack(pieces)
end

function m.getTimerFormat(n)
  if (not n or math_utils.isInf(n) or math_utils.isNan(n)) then
    return "-"
  end
  
  local sec, min, hour, days = time_utils.getDurationParts(n)
  
  hour = hour + (24 * days)
  hour = hour >= 10 and hour or "0"..hour
  min = min >= 10 and min or "0"..min
  sec = sec >= 10 and sec or "0"..sec

  return hour .. ":" .. min .. ":" .. sec
end

function m.getLongFormDurationFormat(n, include_seconds)
  if (not n or math_utils.isInf(n) or math_utils.isNan(n)) then
    return "-"
  end
  
  local sec, min, hour = time_utils.getDurationParts(n)
  
  hour = hour == 0 and ""
      or hour == 1 and "1 hour"
      or hour .. " hours"
      
  min = min == 0 and "" 
      or min == 1 and "1 minute"
      or min .. " minutes"
  
  local res = hour
  if (hour == "") then
    res = res .. min
  else
    res = res .. " " .. min
  end
  
  if (include_seconds) then
    sec = sec == 0 and "" 
        or sec == 1 and "1 second"
        or sec .. " seconds"
        
    if (min == "") then
      res = res .. sec
    else
      res = res .. " " .. sec
    end
  end
  
  return res
end

function m.toNumber(s)
  local res = 0
  for i=1,#s do
    local n = tonumber(string.sub(s,i,i), 36) or 0
    res = res + n
  end
  
  return res
end

return m