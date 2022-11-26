local lc = LevelingChronicle
local UI = lc.UI

MiniSessionMonitorMixin = CreateFromMixins(BackdropTemplateMixin)

function MiniSessionMonitorMixin:Refresh(model)
  self.model = model
  
  local timer = model.time_to_level_timer
  if (not model.elapsed_time or model.elapsed_time < 60) then
    timer = model.avg_time_to_level
  end
  
  self.eta_timer:SetText(timer)
  
  if (model.recorder_running) then
    self.eta_timer:SetTextColor(unpack(lc.UI.Definitions.RECORDER_RUNNING_COLOR))
  else
    self.eta_timer:SetTextColor(unpack(lc.UI.Definitions.RECORDER_STANDBY_COLOR))
  end
end

function MiniSessionMonitorMixin:MainWindowOpenButton_OnClick()
  UI.OpenMainWindow()
end

function MiniSessionMonitorMixin:ExpandButton_OnClick()
  local x,y = self:GetCenter()
  UI.Widgets.SessionMonitor:ClearAllPoints()
  UI.Widgets.SessionMonitor:SetPoint("CENTER", nil, "BOTTOMLEFT", x, y)
  UI.CloseSessionMonitor()
  UI.OpenSessionMonitor(true)
end

function MiniSessionMonitorMixin:Timer_OnEnter()
  GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT", 5, 5)
  GameTooltip:AddLine(UI.Strings.MiniSessionMonitor_TimerTooltip, 1, 1, 1)
  if (self.model.recorder_running) then
    GameTooltip:AddLine(UI.Strings.MiniSessionMonitor_TimerTooltip_Running, unpack(lc.UI.Definitions.RECORDER_RUNNING_COLOR))
  else
    GameTooltip:AddLine(UI.Strings.MiniSessionMonitor_TimerTooltip_Standby, unpack(lc.UI.Definitions.RECORDER_STANDBY_COLOR))
  end
  
  GameTooltip:Show()
end

function MiniSessionMonitorMixin:Timer_OnLeave()
  GameTooltip:Hide()
end

function MiniSessionMonitorMixin:SessionMonitor_OnLoad()
  UI.Widgets.MiniSessionMonitor = self
  
  self.eta_timer = self.timer:CreateFontString(nil, "OVERLAY", "lcGameFontHighlightLarge")
  self.eta_timer:SetAllPoints(true)
  self.eta_timer:SetJustifyV("CENTER")
  
  self:SetBackdrop(UI.Definitions.BACKDROP_DEFAULT)
end