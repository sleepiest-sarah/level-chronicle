local lc = LevelingChronicle
local UI = lc.UI

SessionMonitorMixin = CreateFromMixins(BackdropTemplateMixin)

local function styleTextLabels(self, fs)
  fs:SetJustifyH("LEFT")
end

local function statsLayoutFinished(widget, newHeight)
  local height = widget:GetHeight()
  if (not LCMathUtils.approxEquals(height, newHeight)) then
    widget:SetHeight(newHeight)
    widget:GetParent():ResizeToFitChildren()
  end
end

function SessionMonitorMixin:Refresh(model)
  
  if(model.recorder_running) then
    self.timer:SetTextColor(0, 1, 0.3)
  else
    self.timer:SetTextColor(1, .82, 0)
  end
  
  if (UI.Options.continuous_timer) then
    self.timer:SetText(model.live_timer_string)
  else
    self.timer:SetText(model.elapsed_time_string)
  end
  
  local formatter = UI.Formatters.MonitorFormatter:new(model)
  
  self.stats:SetTableItems(formatter:format())
end

function SessionMonitorMixin:MainWindowOpenButton_OnClick()
  UI.OpenMainWindow()
end

function SessionMonitorMixin:CollapseButton_OnClick()
  local x,y = self:GetCenter()
  UI.Widgets.MiniSessionMonitor:ClearAllPoints()
  UI.Widgets.MiniSessionMonitor:SetPoint("CENTER", nil, "BOTTOMLEFT", x, y)
  lc.UI.CloseSessionMonitor()
  lc.UI.OpenSessionMonitor(false)
end

function SessionMonitorMixin:SessionMonitor_OnLoad()
  UI.Widgets.SessionMonitor = self
  
  self:SetBackdrop(UI.Definitions.BACKDROP_DEFAULT)
  self.stats:SetOnAcquireCallback(styleTextLabels)
  self.stats.OnLayoutFinished = statsLayoutFinished
end