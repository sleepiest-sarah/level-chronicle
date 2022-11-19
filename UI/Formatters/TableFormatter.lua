local lc = LevelingChronicle

local string_utils = LCStringUtils
local math_utils = LCMathUtils

local f = {}
lc.UI.Formatters.TableFormatterBase = f

function f:new(o, model, dict)
  o = lc.UI.Formatters.Base:new(o, model, dict)
    
  o.__index.appendKeyValueTableRow = self.appendKeyValueTableRow
  o.__index.appendToCurrentRow = self.appendToCurrentRow
  o.__index.appendCurrentRow = self.appendCurrentRow
  o.__index.appendRow = self.appendRow
    
  return o
end

function f:appendToCurrentRow(text, colspan)
  self.row = self.row or {}
  
  table.insert(self.row, {text = text, colspan = colspan})
end

function f:appendCurrentRow()
  self:append(self.row)
  self.row = nil
end

function f:appendRow(...)
  self:append({...})
end

function f:appendKeyValueTableRow(k,v,dict)
  v = v or self.model[k]
  dict = dict or self.dict
  if (self:isValidKeyValue(k,v,dict)) then
    self:append({{text = dict[k]},{text = v}})
  end
end

return f