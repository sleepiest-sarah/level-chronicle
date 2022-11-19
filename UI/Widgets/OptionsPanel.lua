local lc = LevelingChronicle

OptionsPanelBaseMixin = {}

--these are required for the canvas layout
function OptionsPanelBaseMixin:OnCommit() end
function OptionsPanelBaseMixin:OnDefault() end
function OptionsPanelBaseMixin:OnRefresh() end

function OptionsPanelBaseMixin:Open()
  --this has to be a defect or oversight in the underlying code
  --subcategories are not registered in a way that allows them to be opened with OpenToCategory
  --so just manually selecting the subcategory using one of the internal methods
  if (not SettingsPanel:OpenToCategory(self.category.ID)) then
    SettingsPanel:SelectCategory(self.category)
  end
end

lcOptionsPanelMixin = CreateFromMixins(OptionsPanelBaseMixin)
lcAboutPanelMixin = CreateFromMixins(OptionsPanelBaseMixin)

local function setOption(key, value)
  local old_value = lc.UI.Options[key]
  lc.UI.Options[key] = value
  
  WowEventFramework.triggerCustomEvent(lc.Event.ON_OPTION_CHANGED, key, old_value, value)
end 

function lcOptionsPanelMixin:LoadOptions()
  
  local option_widgets = {}
  for i,option in ipairs(lc.UI.Definitions.Options) do
    local control = CreateFrame("Frame", nil, self, "Options_CheckboxControlTemplate")
    control.text:SetText(option.text)
    control.checkbutton.key = option.key
    
    control.checkbutton:SetChecked(lc.UI.Options[option.key])
    control.checkbutton:SetScript("OnClick", self.Checkbox_OnClick)
    
    table.insert(option_widgets, control)
  end  
    
  self.controls:DoLayout(option_widgets)
end

function lcOptionsPanelMixin.Checkbox_OnClick(button)
  setOption(button.key, button:GetChecked())
end

function lcOptionsPanelMixin:OnLoad()
  lc.UI.OptionsPanel = self
end

function lcAboutPanelMixin:OnLoad()
  lc.UI.AboutPanel = self
  
  self.text:SetText(lc.UI.Strings.Information_Full)
end

function lc.UI.RegisterOptionsPanel()
  local options_frame = CreateFrame("Frame", nil, nil, "lcOptionsPanelTemplate")
  local about_frame = CreateFrame("Frame", nil, nil, "lcAboutPanelTemplate")
  
  local category, layout = Settings.RegisterCanvasLayoutCategory(options_frame, lc.UI.Strings.OPTIONS_CATEGORY)
  options_frame.category = category
  Settings.RegisterAddOnCategory(category)
  
  local subcategory, sub_layout = Settings.RegisterCanvasLayoutSubcategory(category, about_frame, lc.UI.Strings.ABOUT_CATEGORY);
  about_frame.category = subcategory
  
  options_frame:LoadOptions()
end