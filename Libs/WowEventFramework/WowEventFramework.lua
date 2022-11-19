local string_utils = require('Libs.LuaCore.Utils.StringUtils') or LCStringUtils

local event_map = {}
local secure_hooks = {}
local next_frame_callbacks = {}
local timer_callbacks = {}
local custom_event_map = {}

local next_frame_queued = false

WowEventFramework = {}

local m = WowEventFramework

local sframe = CreateFrame("FRAME")
m.sframe = sframe

local function nextFrame()
  next_frame_queued = false
  
  local callbacks = {}
  
  --add currently registered callbacks to local list so callbacks can register new next frame callbacks without being affected by this function
  for id,c in pairs(next_frame_callbacks) do
    callbacks[id] = c
  end
  
  next_frame_callbacks = {}
  
  for id,c in pairs(callbacks) do
    c.callback(unpack(c.args))
  end
end

local function timerFired()
  local exhausted = {}
  for id,c in pairs(timer_callbacks) do
    if (GetTime() - c.start > c.seconds) then
      table.insert(exhausted,id)            --remove after loop so iterator isn't affected
      c.callback(unpack(c.args))
    end
  end
  
  --remove expired timers
  for _,id in pairs(exhausted) do
    timer_callbacks[id] = nil
  end
  
end

function sframe:OnEvent(event, ...)
  if (event_map[event]) then
    for _, f in pairs(event_map[event]) do
      f(event, ...)
    end
  end
end

function m.registerNextFrame(callback, ...)
  local uuid = string_utils.generateUUID() --for random access deletes
  next_frame_callbacks[uuid] = {callback = callback, args = {...}}
  
  if (not next_frame_queued) then
    next_frame_queued = true
    C_Timer.After(0, nextFrame)
  end
end

function m.registerTimer(callback, seconds, ...)
  local uuid = q:generateUUID()  --for random access deletes
  timer_callbacks[uuid] = {callback = callback, seconds = seconds, args = {...}, start = GetTime()}
  
  C_Timer.After(seconds, timerFired)
end

--TODO passing args in here seems like a hella weird case; think it indicates a very strange design that should probably be avoided
--not sure why quantify was doing it, but it should have probably been done a different way
function m.registerCustomEvent(event,func, ...)
  if (custom_event_map[event] == nil) then
    custom_event_map[event] = {}
  end

  table.insert(custom_event_map[event], {func = func, args = {...}})  
end

function m.registerEvent(event, func)
  if not sframe:IsEventRegistered(event) then
    sframe:RegisterEvent(event)
  end
  
  if (event_map[event] == nil) then
    event_map[event] = {}
  end
    
  table.insert(event_map[event], func)
end

function m.registerAllEvents(eventList, func)
  for _,v in ipairs(eventList) do
    m.registerEvent(v, func)
  end
end

function m.unregisterEvent(event, func)
  if (event_map[event] ~= nil) then
    for i,f in ipairs(event_map[event]) do
      if (f == func) then
        event_map[event][i] = nil
        break
      end
    end
  end
end

function m.unregisterAllEvents()
  event_map = {}
  
  sframe:UnregisterAllEvents()
end

function m.hookSecureFunc(func, callback, t)
  if (not secure_hooks[func]) then
    t = t or _G
    
    secure_hooks[func] = {}
    hooksecurefunc(t, func, function (...)
                          for _,cb in pairs(secure_hooks[func]) do
                            cb(...)
                          end
                         end)
  end
  
  table.insert(secure_hooks[func], callback)
end

function m.triggerCustomEvent(event, ...)
  if (custom_event_map[event]) then
    for _, f in pairs(custom_event_map[event]) do

      if (#f.args > 0) then
        local args = {unpack(f.args)}
        for _,v in pairs({...}) do
          table.insert(args, v)
        end
        
        f.func(event, unpack(args))
      else
        f.func(event, ...)
      end
    end
  end  
end

sframe:SetScript("OnEvent", sframe.OnEvent)

return m