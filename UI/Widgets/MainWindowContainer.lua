local lc = LevelingChronicle
local UI = lc.UI

lcMainWindowMixin = {}

function lcMainWindowMixin:RoleplayModeButton_OnClick(button)
  lc.UI.State.rp_mode_on = button:GetChecked()

  UI.Controller.loadCharacterJourneyWidget()
end

function lcMainWindowMixin:InitializeRpModeButton(rp_mode_on)
  self.roleplayModeButton:SetChecked(rp_mode_on)
  lc.UI.State.rp_mode_on = rp_mode_on
end

function lcMainWindowMixin:InfoButton_OnClick(button)
  UI.Widgets.InfoWidget:Open()
end

function lcMainWindowMixin:OnLoad()
  UI.Widgets.MainWindow = self
  
  --self:SetBackdrop(UI.Definitions.BACKDROP_MAIN_WINDOW)
  NineSliceUtil.ApplyLayout(self, NineSliceLayouts.WoodenNeutralFrameTemplate)
end