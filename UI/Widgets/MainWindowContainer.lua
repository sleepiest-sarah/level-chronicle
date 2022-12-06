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

function lcMainWindowMixin:OnShow()
  lc.UI.State.main_window_shown = true
  UI.Controller.loadMainWindow()
end

function lcMainWindowMixin:OnHide()
  lc.UI.State.main_window_shown = false
end

function lcMainWindowMixin:OnLoad()
  UI.Widgets.MainWindow = self
  
  self.backgroundTexture:SetAtlas(lc.UI.Definitions.MAIN_WINDOW_BACKGROUND_TEXTURE)
  
  NineSliceUtil.ApplyLayout(self, lc.UI.Definitions.MAIN_WINDOW_NINE_SLICE)
end