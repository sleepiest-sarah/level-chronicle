WowClassicAPI.Globals = {}

local m = WowClassicAPI.Globals

function m.GetMaxLevelForPlayerExpansion()
  return GetMaxPlayerLevel()
end

function m.IsXPUserDisabled()
  return false
end

return m