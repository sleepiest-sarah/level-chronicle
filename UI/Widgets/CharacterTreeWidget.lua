local lc = LevelingChronicle
local UI = lc.UI
local def = UI.Definitions

CharacterTreeWidgetMixin = CreateFromMixins(BackdropTemplateMixin)

local function headerOnMouseDown(button)
  button:GetNormalTexture():AdjustPointsOffset(-1,1)
end

local function headerOnMouseUp(button)
  button:GetNormalTexture():ClearPointsOffset()
end

local function setupHeaderButton(button)
  button:SetNormalTexture(button.expanded and def.DRAWN_COLLAPSE_ICON_PATH or def.DRAWN_EXPAND_ICON_PATH)
	button:SetHighlightTexture(button.expanded and def.DRAWN_COLLAPSE_HIGHLIGHT_PATH or def.DRAWN_EXPAND_HIGHLIGHT_PATH);
	button:SetHitRectInsets(0, -button.ButtonText:GetWidth(), 0, 0);
  
  button:SetScript("OnMouseDown", headerOnMouseDown)
  button:SetScript("OnMouseUp", headerOnMouseUp)
end

local function setButtonStyles(self, button)
  if (button:GetObjectType() == "Button" and not button.header) then
    button:SetHighlightTexture(button.highlightTexture, "BLEND")
    local color = self.model.character_colors[button.key] or {r = 0, g = 0, b = 0}
    button:GetHighlightTexture():SetVertexColor(color.r, color.g, color.b)
  end
  
  if (button.header) then
    setupHeaderButton(button)
  end
end

function CharacterTreeWidgetMixin:OnLayoutFinished(height)
  if (height < self:GetParent():GetHeight()) then
    self:GetParent().ScrollBar:Hide()
  else
    self:GetParent().ScrollBar:Show()
  end
end

function CharacterTreeWidgetMixin:Refresh(model)
  self.model = model
  
  self:SetAccordionItems(model.characters)
end

function CharacterTreeWidgetMixin:Character_OnClick(guid)
  lc.UI.Controller.loadCharacterJourneyWidget(guid)
  
  local model = lc.UI.Manager.buildCharacterStatsModel(guid)
  lc.UI.Widgets.CharacterStatsWidget:Refresh(model)
end

function CharacterTreeWidgetMixin:CharacterTreeWidget_OnLoad()
  UI.Widgets.CharacterTreeWidget = self
  
  self.backgroundTexture:SetAtlas(def.CHARACTER_TREE_SCROLL_BACKGROUND_TEXTURE)
  
  self:RegisterCallback(self.Character_OnClick)
  self:SetOnAcquireCallback(setButtonStyles)
end