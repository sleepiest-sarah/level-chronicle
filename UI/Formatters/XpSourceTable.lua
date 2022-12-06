local lc = LevelingChronicle

local string_utils = LCStringUtils
local math_utils = LCMathUtils

local f = {}
lc.UI.Formatters.XpSourceTable = f

local header_dict = lc.UI.Strings.XpSourceTable_Headers

function f:new(model)
  local o = lc.UI.Formatters.TableFormatterBase:new(self, model, lc.UI.Strings.XpSourceTable)

  return o
end

function f:format()
  local m = self.model
  
  for _,k in ipairs(m.sorted_percent_keys) do
    local source = m.xp_sources[k]
    if (source and source.pct ~= "-" and source.pct ~= "0%" and source.num > 0 and self.dict[k]) then
      local row = {}
      row[1] = {text = self.dict[k], colspan = 2, justifyh="LEFT"}
      row[2] = {text = source.pct}
      row[3] = {text = source.rate}
      row[4] = {text = source.num}
      row[5] = {text = source.per}
      self:append(row)
      
      if (k == "scenario" and m.dungeon_xp_sources.kill_instance.pct ~= "0%" and m.dungeon_xp_sources.scenario_bonus.pct ~= "0%") then
        row = {}
        row[1] = {text = self.dict.kill_instance, colspan = 2, justifyh="LEFT"}
        row[2] = {text = m.dungeon_xp_sources.kill_instance.pct}
        row[3] = {text = m.dungeon_xp_sources.kill_instance.rate}
        row[4] = {text = m.dungeon_xp_sources.kill_instance.num}
        row[5] = {text = m.dungeon_xp_sources.kill_instance.per}      
        self:append(row)
        
        row = {}
        row[1] = {text = self.dict.scenario_bonus, colspan = 2, justifyh="LEFT"}
        row[2] = {text = m.dungeon_xp_sources.scenario_bonus.pct}
        row[3] = {text = m.dungeon_xp_sources.scenario_bonus.rate}
        row[4] = {text = "-"}
        row[5] = {text = "-"}      
        self:append(row)
      end
    end
  end
  
  if (#self.buffer > 0) then
    self:prepend({
        {text = header_dict.source, colspan = 2, justifyh="LEFT"},
        {text = header_dict.pct},
        {text = header_dict.rate},
        {text = header_dict.num},
        {text = header_dict.per},
      })
  end
  
  return self.buffer
end

return f