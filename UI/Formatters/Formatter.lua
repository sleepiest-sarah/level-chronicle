local lc = LevelingChronicle

lc.UI.Formatters = {}

local math_utils = LCMathUtils

local Formatter = {}
lc.UI.Formatters.Base = Formatter
function Formatter:new(o, model, dict)
  o.model = model
  o.buffer = {}
  o.dict = dict or lc.UI.Strings.JourneyStatDisplay
  
  setmetatable(o, self)
  self.__index = self
  return o
end

function Formatter:format()
  return self.buffer
end

function Formatter:append(s)
  table.insert(self.buffer, s)
end

function Formatter:prepend(s)
  table.insert(self.buffer, 1, s)
end

function Formatter:insert(s, i)
  table.insert(self.buffer, i, s)
end

function Formatter:getRandomSeed()
  return self.model.level_seed
end

function Formatter:isValidDuration(v)
  return v and v > 1 and not (math_utils.isInf(v) or math_utils.isNan(v))
end

function Formatter:isValidKeyValue(k, v, dict)
  dict = dict or self.dict
  return v and dict[k] and (v ~= '0s') and (type(v) ~= 'number' or v > 0)
end

function Formatter:appendFormattedString(k,v, dict)
  dict = dict or self.dict
  v = v or self.model[k]
  if (self:isValidKeyValue(k, v, dict)) then
    self:append(string.format(dict[k], v))
  end
end



return Formatter