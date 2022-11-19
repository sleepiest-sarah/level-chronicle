local lc = require('Utils.Constants') or LevelingChronicle

local ef = require('Libs.WowEventFramework.WowEventFramework') or WowEventFramework

local ds = require('Utils.DataServices') or lc.DataServices
local rm = require('Recorder.RecorderManager') or lc.RecorderManager

local function initializeMinimapIcon()
  local ldb = LibStub("LibDataBroker-1.1"):NewDataObject("LevelingChronicle", {
    type = "data source",
    text = "LevelingChronicle",
    icon = "Interface\\AddOns\\LevelingChronicle\\UI\\Textures\\better_chronicle_icon.tga",
    OnClick = lc.UI.MinimapButton_OnClick,
    OnTooltipShow = lc.UI.MinimapButton_OnTooltipShow
  })
  local icon = LibStub("LibDBIcon-1.0")
  icon:Register("LevelingChronicle", ldb, lcOptionsDb.profile.minimap)
end

local function loadAddon(event, addon)
  if (event == "ADDON_LOADED" and addon == lc.ADDON_NAME) then
    ds.initializeDatabase()
    
    initializeMinimapIcon()
  end
end

local function slashCmd(msg)
  local _, _, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)")
  
  if (cmd == "monitor") then
    lc.UI.OpenSessionMonitor()
  end
end

ef.registerEvent("ADDON_LOADED", loadAddon)

SLASH_levelingchronicle1 = "/lc"
SlashCmdList["levelingchronicle"] = slashCmd

return lc