local lc = LevelingChronicle

local string_utils = LCStringUtils

local f = {}
lc.UI.Formatters.LevelEntry = f

function f:new(model)
  local o = lc.UI.Formatters.TableFormatterBase:new(self, model, lc.UI.Strings.JourneyStatDisplay)
  
  return o
end

function f:format()
  local m = self.model
    
  self:appendRow({text = "% Level Per", justifyh = "RIGHT", colspan=6})

  for _,k in ipairs(m.sorted_activity_keys) do
    local v = m.activity_stats[k]
    if (v.num > 0) then
      local row = {}
      row[1] = {text = self.dict[k], justifyh = "LEFT", colspan = 3, wordwrap = true}
      row[2] = {text = v.num, justifyh = "RIGHT", colspan = 1}
      row[3] = {text = string.format("%s", v.pct_per_event), justifyh = "RIGHT", colspan = 2}
      self:append(row)
    end
  end
  
  return self.buffer
end

return f