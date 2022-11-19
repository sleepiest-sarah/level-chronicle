local lc = LevelingChronicle
local UI = lc.UI

local ef = require('Libs.WowEventFramework.WowEventFramework') or WowEventFramework

local manager = require('UI.UIManager') or lc.UI.Manager
local ds = require('Utils.DataServices') or lc.DataServices

local function refreshUi()
  if (lc.UI.State.session_monitor_visible) then
    local model = lc.UI.Manager.buildSessionMonitorModel()
    if (model) then
      lc.UI.State.active_session_monitor:Refresh(model)
    end
  end
end

local function init(event, current_character)
  local saved_state = ds.getUiState()
  
  UI.Widgets.MainWindow:InitializeRpModeButton(saved_state.rp_mode_on)
  
  lc.UI.Options = ds.getSavedOptions()
  lc.UI.RegisterOptionsPanel()
  
  local model = lc.UI.Manager.buildCharacterTreeModel()
  lc.UI.Widgets.CharacterTreeWidget:Refresh(model)
  
  
  lc.UI.Widgets.CharacterTreeWidget:Select(current_character.guid)
  lc.UI.Widgets.CharacterTreeWidget:RefreshAccordion()
  
  if (saved_state.session_monitor_visible) then
    lc.UI.OpenSessionMonitor(saved_state.session_monitor_expanded)
  end
  
  refreshUi() --there's some kind of race condition with the initial refresh when the session monitor is opened
  lc.UI.uiRefreshTimer = C_Timer.NewTicker(lc.UI.REFRESH_RATE, refreshUi)
end

local function saveUiState()
  local state = {}
  
  state.session_monitor_visible = UI.State.session_monitor_visible
  state.session_monitor_expanded = UI.State.session_monitor_expanded
  state.rp_mode_on = UI.State.rp_mode_on
  
  ds.saveUiState(state)
end

local function saveOptions()
  local options = {}
  
  options.minimap_show = UI.Options.minimap_show
  options.show_monitor_on_login = UI.Options.show_monitor_on_login
  
  ds.saveOptions(options)
end

local function teardown()
  saveUiState()
  saveOptions()
end

local function onOptionChanged(event, key, old_value, new_value)
  if (old_value == new_value) then
    return
  end
  
  if (key == "minimap_show") then
    if (new_value) then
      LibStub("LibDBIcon-1.0"):Show("LevelingChronicle")
    else
      LibStub("LibDBIcon-1.0"):Hide("LevelingChronicle")
    end
  end
end

function lc.UI.MinimapButton_OnClick(button, mouseButton, down)
  if (mouseButton == "LeftButton") then
    if (IsAltKeyDown()) then
      lc.UI.OptionsPanel:Open()
    elseif (IsShiftKeyDown()) then
      lc.UI.AboutPanel:Open()
    else
      lc.UI.OpenSessionMonitor()
    end
  elseif (mouseButton == "RightButton") then
    lc.UI.OpenMainWindow()
  end
end

function lc.UI.MinimapButton_OnTooltipShow(tooltip)
  tooltip:SetText(lc.UI.Strings.MinimapButton_TooltipHover)
end

function lc.UI.OpenMainWindow()
  lcMainWindowContainer:Show()
  lc.UI.State.main_window_shown = true
end

function lc.UI.OpenSessionMonitor(full)
  if (not lc.UI.State.session_monitor_visible) then
    lc.UI.State.session_monitor_expanded = (full == nil and lc.UI.State.session_monitor_expanded) or full
    lc.UI.State.session_monitor_visible = true
    
    lc.UI.State.active_session_monitor = lc.UI.State.session_monitor_expanded and lc.UI.Widgets.SessionMonitor or lc.UI.Widgets.MiniSessionMonitor
    
    lc.UI.State.active_session_monitor:Show()
    refreshUi()
  end
end

function lc.UI.CloseSessionMonitor()
  lc.UI.State.session_monitor_visible = false
  if (lc.UI.State.active_session_monitor) then
    lc.UI.State.active_session_monitor:Hide()
    lc.UI.State.active_session_monitor = nil
  end
end

ef.registerCustomEvent(lc.Event.CHARACTER_INITIALIZED, init)
ef.registerEvent("PLAYER_LOGOUT", teardown)
ef.registerCustomEvent("ON_OPTION_CHANGED", onOptionChanged)