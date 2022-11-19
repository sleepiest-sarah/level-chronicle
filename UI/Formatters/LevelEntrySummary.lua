local lc = LevelingChronicle

local string_utils = LCStringUtils

local f = {}
lc.UI.Formatters.LevelEntrySummary = f

function f:new(model)
  local o = lc.UI.Formatters.TableFormatterBase:new(self, model, lc.UI.Strings.JourneyStatDisplay)
  
  return o
end

function f:format()
  local m = self.model
    
  if (self:isValidDuration(m.elapsed_time)) then
    self:append({{text = self.dict.elapsed_time, colspan = 1, justifyh = "LEFT"}, {text = string_utils.getTimerFormat(m.elapsed_time), justifyh = "RIGHT"}})
  end
  
  if (self:isValidDuration(m.rested_xp_time_saved)) then
    self:append({{text = self.dict.rested_xp_time_saved, colspan = 1, justifyh = "LEFT"}, {text = string_utils.getTimerFormat(m.rested_xp_time_saved), justifyh = "RIGHT"}})
  end
  
  if (self:isValidKeyValue("xp_rate", m.xp_rate)) then
    self:appendRow({text = self.dict.xp_rate, colspan = 1, justifyh = "LEFT"}, {text = m.xp_rate, justifyh = "RIGHT"})
  end
  
  self:appendRow({text = " ", colspan=2})
  
  return self.buffer
end

return f