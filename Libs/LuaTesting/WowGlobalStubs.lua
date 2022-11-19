SlashCmdList = {}

function GetCoinTextureString(n)
  return tostring(n)
end

function CreateFrame(s)
  local f = {}
  
  f.events = {}
  f.IsEventRegistered = function (self, event)
    return self.events[event]
  end
  
  f.RegisterEvent = function (self, event)
    self.events[event] = event
  end
  
  f.SetScript = function (self, handler, func)
    self[handler] = func
  end
  
  f.UnregisterAllEvents = function (self)
    self.events = {}
  end
  
  return f
end

function hooksecurefunc(table, func, callback)
  
end

function GetInstanceInfo()
  return "Ragefire Chasm", "party", 1, "Normal", 5, 0, false, 389, 5
end

function time()
  return os.time()
end

function GetTime()
  return os.clock()
end

function CombatLogGetCurrentEventInfo()
  return os.time(), ""
end

function UnitXPMax(unit)
  return 69
end

function UnitXP(unit)
  return 15
end

function UnitLevel(unit) 
  return 5
end

function GetXPExhaustion()
  return 5000
end

function GetMaxLevelForPlayerExpansion()
  return 60
end

function GetMaxLevelForLatestExpansion()
  return 60
end

function IsXPUserDisabled()
  return false
end

function GetRealZoneText(mapId)
  return nil
end

function EJ_GetInstanceForMap(mapId)
  return nil
end

function IsInGroup()
  return true
end

function IsInRaid()
  return false
end

function GetNumGroupMembers()
  return 5
end

function GetUnitName(unit_id, showServerName)
  return showServerName and unit_id.."-Thrall" or unit_id
end

function UnitGroupRolesAssigned(unit_id)
  return "damage"
end

function UnitIsDeadOrGhost(unit_id)
  return false
end

function UnitGUID(unit_id)
  return "Player-71-0BBA3E27"
end

function UnitFullName(unit_id)
  return "Airei", "Gorgonnash"
end
  
function UnitClassBase(unit_id)
  return "DRUID"
end

function IsInInstance()
  return false, "none"
end

function GetAddOnMetadata(addon, field)
  if (field == "Version") then
    return "0.1a"
  end
end