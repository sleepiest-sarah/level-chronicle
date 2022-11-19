LCTimeUtils = {}
local m = LCTimeUtils

--seconds since epoch
function m.unixTime()
  return time()
end

--system uptime with millisecond precision
function m.systemTime()
  return GetTime()
end

function m.getDurationParts(n)
  local days = n >= 86400 and math.floor(n/86400) or 0
  local hours = n >= 3600 and math.floor((n % 86400)/3600) or 0
  local minutes = n >= 60 and math.floor((n % 3600)/60) or 0
  local seconds = math.floor(n) % 60
  
  return seconds, minutes, hours, days
end

return m