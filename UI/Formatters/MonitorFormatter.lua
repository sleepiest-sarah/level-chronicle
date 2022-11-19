local lc = LevelingChronicle

local string_utils = LCStringUtils
local math_utils = LCMathUtils

local f = {}
lc.UI.Formatters.MonitorFormatter = f

function f:new(model)
  local o = lc.UI.Formatters.TableFormatterBase:new(self, model, lc.UI.Strings.SessionMonitorDisplay)
  
  return o
end

function f:format()
  local m = self.model
  
  self:appendRow({text = self.dict.xp_rate_header, colspan = 2, font = "GameFontNormal"})
  
  self:appendKeyValueTableRow("xp_rate", m.xp_rate)
  self:appendKeyValueTableRow("average_xp_rate", m.average_xp_rate)
  
  self:appendRow({text = self.dict.time_to_level_header, colspan = 2, font = "GameFontNormal"})
  
  self:appendKeyValueTableRow("time_to_level", m.time_to_level)
  self:appendKeyValueTableRow("avg_time_to_level", m.avg_time_to_level)
  
  self:appendRow({text = self.dict.to_level_header, colspan = 2, font = "GameFontNormal"})
  
  self:appendKeyValueTableRow("kills_to_level", m.num_to_level.kills_to_level)
  self:appendKeyValueTableRow("quests_to_level", m.num_to_level.quests_to_level)
  self:appendKeyValueTableRow("scenarios_to_level", m.num_to_level.scenarios_to_level)
  self:appendKeyValueTableRow("battlegrounds_to_level", m.num_to_level.battlegrounds_to_level)
  self:appendKeyValueTableRow("gathers_to_level", m.num_to_level.gathers_to_level)
  self:appendKeyValueTableRow("pet_battles_to_level", m.num_to_level.pet_battles_to_level)
  
  return self.buffer
end

return f