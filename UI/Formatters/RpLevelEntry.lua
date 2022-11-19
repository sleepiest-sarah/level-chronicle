local lc = LevelingChronicle

local string_utils = LCStringUtils
local math_utils = LCMathUtils

local f = {}
lc.UI.Formatters.RpLevelEntry = f

function f:new(model)
  local o = lc.UI.Formatters.TableFormatterBase:new(self, model, lc.UI.Strings.JourneyRpStatDisplay)
  
  return o
end

--always want the same string selected for the same entry
function f:appendFormattedRpString(k,v)
  v = v or self.model[k]
  if (self:isValidKeyValue(k, v)) then
    local format_string = self.dict[k][math_utils.rand(1, #self.dict[k], self:getRandomSeed())]
    self:appendRow(string.format(format_string, v))
  end
end

function f:appendFormattedRpTableRow(k,v,colspan)
  v = v or self.model[k]
  if (self:isValidKeyValue(k, v)) then
    local format_string = self.dict[k][math_utils.rand(1, #self.dict[k], self:getRandomSeed())]

    self:appendRow({text = string.format(format_string, v), colspan = colspan})
  end  
end

function f:format()
  local m = self.model
    
  self:appendFormattedRpString("elapsed_time", string_utils.getLongFormDurationFormat(m.elapsed_time))
  self:appendFormattedRpString("rested_xp_time_saved", string_utils.getLongFormDurationFormat(m.rested_xp_time_saved, true))
  
  self:append("\n")
  self:append("To Do:")
  
  self:appendFormattedRpString("num_quests_completed", m.num_quests_completed)
  self:appendFormattedRpString("num_player_kills", m.num_player_kills)
  self:appendFormattedRpString("num_scenarios_completed", m.num_scenarios_completed)
  self:appendFormattedRpString("num_gathers", m.num_gathers,2)
  self:appendFormattedRpString("num_pet_battles", m.num_pet_battles)
  
  return self.buffer
end

return f