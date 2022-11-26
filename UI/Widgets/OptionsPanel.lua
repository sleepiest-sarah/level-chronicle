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

local function createAndInitializeControlFrame(self, option)
  local frame
  if (option.control == "checkbox") then
    frame = CreateFrame("Frame", nil, self, "Options_CheckboxControlTemplate")
    frame.control:SetChecked(lc.UI.Options[option.key])
    frame.control:SetScript("OnClick", lcOptionsPanelMixin.Checkbox_OnClick)
  elseif (option.control == "dropdown") then
    frame = CreateFrame("Frame", nil, self, "Options_DropdownControlTemplate")
    
    local selections = {}
    for i,label in ipairs(option.selections) do
      table.insert(selections, {label = label, value = i, key=option.key})
    end
    
    frame.control.DropDown:SetupSelections(selections,lc.UI.Options[option.key])
    
    frame.control.cbrHandles:RegisterCallback(frame.control.DropDown.Button, SelectionPopoutButtonMixin.Event.OnValueChanged, lcOptionsPanelMixin.Dropdown_OnValueChanged);
  end
  
  if (option.tooltip) then
    frame:SetScript("OnEnter", lcOptionsPanelMixin.Control_OnEnter)
    frame:SetScript("OnLeave", lcOptionsPanelMixin.Control_OnLeave)
  end
  
  return frame
end

local function setOption(key, value)
  local old_value = lc.UI.Options[key]
  lc.UI.Options[key] = value
  
  WowEventFramework.triggerCustomEvent(lc.Event.ON_OPTION_CHANGED, key, old_value, value)
end 

function lcOptionsPanelMixin:LoadOptions()
  
  local option_widgets = {}
  for i,option in ipairs(lc.UI.Definitions.Options) do
    local frame = createAndInitializeControlFrame(self, option)
    frame.text:SetText(option.text)
    frame.control.key = option.key
    frame.tooltip_text = option.tooltip

    table.insert(option_widgets, frame)
  end  
    
  self.controls:DoLayout(option_widgets)
end

function lcOptionsPanelMixin.Checkbox_OnClick(button)
  setOption(button.key, button:GetChecked())
end

function lcOptionsPanelMixin.Dropdown_OnValueChanged(event_id, option)
  setOption(option.key, option.value)
end

function lcOptionsPanelMixin.Control_OnEnter(control)
  GameTooltip:SetOwner(control, "ANCHOR_NONE")
  GameTooltip:SetPoint("BOTTOMLEFT", control, "CENTER", 0, 10)
  
  GameTooltip:AddLine(control.tooltip_text, 1, 1, 1)
  
  GameTooltip:Show()
end

function lcOptionsPanelMixin.Control_OnLeave(control)
  GameTooltip:Hide()
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