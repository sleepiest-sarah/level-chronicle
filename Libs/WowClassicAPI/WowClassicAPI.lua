
local function writeGlobals()
  for name, func in pairs(WowClassicAPI.Globals) do
    if (not _G[name]) then
      _G[name] = func
    end
  end
end

local function writeSystems()
  for system, def in pairs(WowClassicAPI.Systems) do
    if (not _G[system]) then
      _G[system] = def
    else
      for name,func in pairs(def) do
        if (not _G[system].name) then
          _G[system][name] = func
        end
      end
    end
  end
end


writeGlobals()
writeSystems()