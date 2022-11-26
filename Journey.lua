local lc = require('Utils.Constants') or LevelingChronicle

local ef = require('Libs.WowEventFramework.WowEventFramework') or WowEventFramework

local ds = require('Utils.DataServices') or lc.DataServices
local rm = require('Recorder.RecorderManager') or lc.RecorderManager

local function initializeMinimapIcon()
  local ldb = LibStub("LibDataBroker-1.1"):NewDataObject("Journey", {
    type = "data source",
    text = "Journey",
    icon = "Interface\\AddOns\\Journey\\UI\\Textures\\better_chronicle_icon.tga",
    OnClick = lc.UI.MinimapButton_OnClick,
    OnTooltipShow = lc.UI.MinimapButton_OnTooltipShow
  })
  local icon = LibStub("LibDBIcon-1.0")
  icon:Register("Journey", ldb, lcOptionsDb.profile.minimap)
end

local function loadAddon(event, addon)
  if (event == "ADDON_LOADED" and addon == lc.ADDON_NAME) then
    ds.initializeDatabase()
    
    initializeMinimapIcon()
  end
end

local function slashCmd(msg)
  local _, _, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)")

  if (cmd == "monitor" and args == "reset") then
    lc.UI.ResetSessionMonitorPosition()
  elseif(cmd == "journal") then
    lc.UI.ToggleMainWindow()
  elseif(cmd == "monitor") then
    lc.UI.ToggleSessionMonitor()
  elseif (cmd == "help") then
    lc.UI.AboutPanel:Open()
  elseif (cmd == "options") then
    lc.UI.OptionsPanel:Open()
  else
    DEFAULT_CHAT_FRAME:AddMessage(lc.UI.Strings.SlashCommand_Info1)
  end
end

ef.registerEvent("ADDON_LOADED", loadAddon)

SLASH_journey1 = "/journey"
SLASH_journey2 = "/jy"
SlashCmdList["journey"] = slashCmd

return lc