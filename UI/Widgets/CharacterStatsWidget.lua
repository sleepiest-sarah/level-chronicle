local lc = LevelingChronicle
local UI = lc.UI

local math_utils = LCMathUtils

CharacterStatsWidgetMixin = {}

local function styleSummaryFields(self, fs)
  if (fs.index % 2 == 0) then
    fs:SetJustifyH("RIGHT")
    fs:SetFontObject("GameFontBlack")
  else
    fs:SetJustifyH("LEFT")
    fs:SetFontObject("QuestFont")
  end
end

local function styleTableFields(self, fs)
  if (fs.x == 0) then
    fs:SetJustifyH("LEFT")
  else
    fs:SetJustifyH("RIGHT")
    if (fs.y > 0) then
      fs:SetFontObject("GameFontBlack")
    end
  end
end

function CharacterStatsWidgetMixin:Refresh(model)
  self.model = model
  
  if (model) then
  
    local formatter = UI.Formatters.OverallStats:new(model)
    local items = formatter:format()

    self.summary:SetTextItems(items)
    
    formatter = UI.Formatters.XpSourceTable:new(model)
    items = formatter:format()
    self.xp_source_table:SetTableItems(items)
    
    if (#items > 0) then
      self.xp_source_table.header_divider:Show()
    else
      self.xp_source_table.header_divider:Hide()
    end
  end
end

function CharacterStatsWidgetMixin:CharacterStatsWidget_OnLoad()
  UI.Widgets.CharacterStatsWidget = self
  
  self.summary:SetOnAcquireCallback(styleSummaryFields)
  self.xp_source_table:SetOnAcquireCallback(styleTableFields)
end