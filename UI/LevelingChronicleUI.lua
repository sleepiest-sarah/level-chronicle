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

local function setMinimapButtonState()
  local show = lc.UI.Options.minimap_show == lc.SHOW_MINIMAP_BUTTON_ALWAYS
  
  if (lc.UI.Options.minimap_show == lc.SHOW_MINIMAP_BUTTON_ONLY_SUB_MAX) then
    local char = manager.getCurrentCharacter()
    show = char.level < char.max_level
  end
    
  if (show) then
    LibStub("LibDBIcon-1.0"):Show("Journey")
  else
    LibStub("LibDBIcon-1.0"):Hide("Journey")
  end
end

local function init(event, current_character)
  local saved_state = ds.getUiState()
  
  --UI.Widgets.MainWindow:InitializeRpModeButton(saved_state.rp_mode_on)
  
  lc.UI.Options = ds.getSavedOptions()
  lc.UI.RegisterOptionsPanel()
  
  saved_state.session_monitor_visible = lc.UI.Options.show_monitor_on_login and (current_character.level < current_character.max_level)
  if (saved_state.session_monitor_visible) then
    lc.UI.OpenSessionMonitor(saved_state.session_monitor_expanded)
  end

  setMinimapButtonState()
end

local function saveUiState()
  local state = {}
  
  state.session_monitor_visible = UI.State.session_monitor_visible
  state.session_monitor_expanded = UI.State.session_monitor_expanded
  state.rp_mode_on = UI.State.rp_mode_on
  
  ds.saveUiState(state)
end

local function teardown()
  saveUiState()
end

local function onOptionChanged(event, key, old_value, new_value)
  if (old_value == new_value) then
    return
  end
  
  if (key == "minimap_show") then
    setMinimapButtonState()
  end
end

function lc.UI.MinimapButton_OnClick(button, mouseButton, down)
  if (mouseButton == "LeftButton") then
    if (IsShiftKeyDown()) then
      lc.UI.OptionsPanel:Open()
    else
      local char = manager.getCurrentCharacter()
      if (char.level < char.max_level) then
        lc.UI.ToggleSessionMonitor()
      end
    end
  elseif (mouseButton == "RightButton") then
    if (IsShiftKeyDown()) then
      lc.UI.AboutPanel:Open()
    else
      lc.UI.ToggleMainWindow()
    end
  end
end

function lc.UI.MinimapButton_OnTooltipShow(tooltip)
  tooltip:SetText(lc.UI.Strings.MinimapButton_TooltipHover)
end

function lc.UI.OpenMainWindow()
  lcMainWindowContainer:Show()
  lc.UI.State.main_window_shown = true
end

function lc.UI.CloseMainWindow()
  lcMainWindowContainer:Hide()
  lc.UI.State.main_window_shown = false  
end

function lc.UI.OpenSessionMonitor(full)
  if (not lc.UI.State.session_monitor_visible) then
    lc.UI.State.session_monitor_expanded = (full == nil and lc.UI.State.session_monitor_expanded) or full
    lc.UI.State.session_monitor_visible = true
    
    lc.UI.State.active_session_monitor = lc.UI.State.session_monitor_expanded and lc.UI.Widgets.SessionMonitor or lc.UI.Widgets.MiniSessionMonitor
    
    lc.UI.State.active_session_monitor:Show()

    refreshUi() --there's some kind of race condition with the initial refresh when the session monitor is opened
    lc.UI.uiRefreshTimer = C_Timer.NewTicker(lc.UI.REFRESH_RATE, refreshUi)
  end
end

function lc.UI.CloseSessionMonitor()
  lc.UI.State.session_monitor_visible = false
  if (lc.UI.State.active_session_monitor) then
    lc.UI.State.active_session_monitor:Hide()
    lc.UI.State.active_session_monitor = nil
    
    lc.UI.uiRefreshTimer:Cancel()
  end
end

function lc.UI.ResetSessionMonitorPosition()
  lc.UI.OpenSessionMonitor()
  lc.UI.State.active_session_monitor:ClearAllPoints()
  lc.UI.State.active_session_monitor:SetPoint("CENTER")
end

function lc.UI.ToggleSessionMonitor()
  if (lc.UI.State.session_monitor_visible) then
    lc.UI.CloseSessionMonitor()
  else
    lc.UI.OpenSessionMonitor()
  end
end

function lc.UI.ToggleMainWindow()
  if (lc.UI.State.main_window_shown) then
    lc.UI.CloseMainWindow()
  else
    lc.UI.OpenMainWindow()
  end
end

ef.registerCustomEvent(lc.Event.CHARACTER_INITIALIZED, init)
ef.registerEvent("PLAYER_LOGOUT", teardown)
ef.registerCustomEvent("ON_OPTION_CHANGED", onOptionChanged)