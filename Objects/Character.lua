local lc = require('Utils.Constants') or LevelingChronicle

lc.Character = {}
local Character = lc.Character

function Character:new(record)
  local o = record or {}
  
  setmetatable(o, self)
  self.__index = self
  return o
end

function Character:loadCharacterData(unit)
  self.guid = UnitGUID(unit)
  self.name, self.realm = UnitFullName(unit)
  self.class = UnitClassBase(unit)
  
  self.max_level = unit == "player" and GetMaxLevelForPlayerExpansion() or GetMaxLevelForLatestExpansion()
  self.level = UnitLevel(unit)
  
  if (unit == "player") then
    self.xp = UnitXP(unit)
    self.max_xp = UnitXPMax(unit)
    
    self.rested_xp = GetXPExhaustion()
    
    self.xp_disabled = IsXPUserDisabled()
  end
end

function Character:canGainXp()
  return not self.xp_disabled and self.level ~= self.max_level
end

return Character