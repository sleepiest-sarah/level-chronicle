local lc = LevelingChronicle
local UI = lc.UI

local math_utils = LCMathUtils
local table_utils = LCTableUtils

CharacterJourneyPageTwoMixin = {}

local function setEntryData(entry, model)
  if (model) then
    entry.header.text:SetText("Level " .. model.level)
    entry.date.text:SetText(model.level_reached_date or "")
    
    if (UI.State.rp_mode_on) then
      entry.activities:Hide()
      entry.summary:Hide()
      
      local formatter = UI.Formatters.RpLevelEntry:new(model)
      local text = formatter:format()
        
      --entry.rp_entry:SetText(text)
    else
      local summary_formatter = UI.Formatters.LevelEntrySummary:new(model)
      local items = summary_formatter:format()
      entry.summary:SetTableItems(items)
      
      local activities_formatter = UI.Formatters.LevelEntry:new(model)
      items = activities_formatter:format()
      entry.activities:SetTableItems(items)
      
      if (#items <= 1) then
        entry.activities:Hide()
      else
        entry.activities:Show()
      end
      entry.summary:Show()
    end
  else
    entry.summary:SetTableItems(nil)
    entry.activities:SetTableItems(nil)
    entry.header.text:SetText("")
    entry.date.text:SetText("")
    entry.activities:Hide()
  end
end

function CharacterJourneyPageTwoMixin:Refresh(model)
  self.divider:Show()
  
  if (model.stats_by_level[2]) then
    setEntryData(self.entryTwo, model.stats_by_level[2])
  else
    self.divider:Hide()
    setEntryData(self.entryTwo, nil)
  end
  
  if (model.stats_by_level[1]) then
    setEntryData(self.entryOne, model.stats_by_level[1])
  else
    setEntryData(self.entryOne, nil)
  end
  
end

function CharacterJourneyPageTwoMixin:OnPageTurn(file, coords)
  self.background:SetTexture(file)
  self.background:SetTexCoord(coords.left, coords.right, coords.top, coords.bottom)
end

function CharacterJourneyPageTwoMixin:OnLoad()

end