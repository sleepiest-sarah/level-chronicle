local lc = LevelingChronicle
local UI = lc.UI

local controller = {}
UI.Controller = controller

local manager = require('UI.UIManager') or lc.UI.Manager

function controller.loadCharacterJourneyWidget(character_guid, page)
  local widget = UI.Widgets.CharacterJourneyWidget
  
  character_guid = character_guid or (widget.model and widget.model.char.guid)
  
  -- don't use the current page if it's a new character
  if ((widget.model and widget.model.char.guid) == character_guid) then
    page = page or (widget.model and widget.model.page)
  end
  
  local model = lc.UI.Manager.buildCharacterJourneyModel(character_guid, tonumber(page), 2)
  lc.UI.Widgets.CharacterJourneyWidget:Refresh(model)
end

function controller.loadMainWindow(character_guid)
  if (not character_guid) then
    local char = lc.RecorderManager.getCurrentCharacter()
    character_guid = char.guid
  end
  
  local model = lc.UI.Manager.buildCharacterTreeModel()
  lc.UI.Widgets.CharacterTreeWidget:Refresh(model)
  
  lc.UI.Widgets.CharacterTreeWidget:Select(character_guid)
  lc.UI.Widgets.CharacterTreeWidget:RefreshAccordion()  
end