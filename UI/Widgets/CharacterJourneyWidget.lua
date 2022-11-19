local lc = LevelingChronicle
local UI = lc.UI

local journal_backgrounds = lc.UI.Definitions.JOURNAL_BACKGROUNDS

local math_utils = LCMathUtils
local table_utils = LCTableUtils
local string_utils = LCStringUtils

CharacterJourneyWidgetMixin = {}

local function refreshControlState(self, page, total_pages)
  if (page == 1 or total_pages == 0) then
    self.controls.pagePrev:Disable()
  else
    self.controls.pagePrev:Enable()
  end
  
  if (page == total_pages or total_pages == 0) then
    self.controls.pageNext:Disable()
  else
    self.controls.pageNext:Enable()
  end
      
end

function CharacterJourneyWidgetMixin:Refresh(model)
  refreshControlState(self, model.page, model.total_pages)
  
  self.model = model
  
  self.pageOne:Refresh(model)
  self.pageTwo:Refresh(model)
  self.bookmarks:Refresh(model)
  
  self:OnPageTurn()
end

function CharacterJourneyWidgetMixin:OnPageTurn()
  local texture = journal_backgrounds[math_utils.rand(1,#journal_backgrounds, self.model.page_seed)]
  
  local coords = type(texture) == 'table' and texture.coords or lc.UI.Definitions.DEFAULT_JOURNAL_BACKGROUND_COORDS
  local file = type(texture) == 'table' and texture.file or texture
  
  self.pageTwo:OnPageTurn(file, coords)
  
  local reflected_coords = math_utils.reflectRectInPlace(coords)
  self.pageOne:OnPageTurn(file, reflected_coords)
end

function CharacterJourneyWidgetMixin:PageButton_OnClick(button, direction)
  local model = self.model
  local new_page = direction == "next" and model.page + 1 or model.page - 1
  
  UI.Controller.loadCharacterJourneyWidget(model.char.guid, new_page)
end

function CharacterJourneyWidgetMixin:PageTwo_OnMouseWheel(delta)
  if (delta > 0 and self.controls.pageNext:IsEnabled()) then
    self:PageButton_OnClick(nil, "next")
  elseif (delta < 0 and self.controls.pagePrev:IsEnabled()) then
    self:PageButton_OnClick(nil, "prev")
  end
end

function CharacterJourneyWidgetMixin:CharacterJourneyWidget_OnLoad()
  UI.Widgets.CharacterJourneyWidget = self
end