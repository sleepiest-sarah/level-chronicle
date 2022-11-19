local lc = LevelingChronicle

local string_utils = LCStringUtils
local math_utils = LCMathUtils

local dict = lc.UI.Strings.JourneyStatDisplay

local f = {}
lc.UI.Formatters.OverallStats = f

function f:new(model)
  local o = lc.UI.Formatters.Base:new(self, model)
  
  return o
end

function f:format()
  local m = self.model
  
  if (self:isValidDuration(m.elapsed_time)) then
    self:append(dict.elapsed_time)
    self:append(string_utils.getTimerFormat(m.elapsed_time))
  end
  
  
  if (self:isValidDuration(m.rested_xp_time_saved)) then
    self:append(dict.rested_xp_time_saved)
    self:append(string_utils.getTimerFormat(m.rested_xp_time_saved))
  end

  if (m.xp_rate and m.xp_rate > 0) then
    local v = math_utils.getFormattedUnitString(m.xp_rate, "integer/hour")
    if (v ~= "-") then
      self:append(dict.xp_rate)
      self:append(v)
    end
  end
  
  if (m.pct_levels_rate and m.pct_levels_rate > 0) then
    local v = math_utils.getFormattedUnitString(m.pct_levels_rate, "decimal/hour")
    if (v ~= "-") then
      self:append(dict.pct_levels_rate)
      self:append(v)
    end
  end
  
  return self.buffer
end

return f