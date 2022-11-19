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
  
  --TODO also need consider how to refresh the widget after a character levels up
  -- and how to just mark as dirty instead of doing all this
  if (not widget.model or character_guid ~= widget.model.char.guid or page ~= widget.model.page or UI.State.rp_mode_on ~= widget.model.rp_mode_on) then
  
    local model = lc.UI.Manager.buildCharacterJourneyModel(character_guid, page, 2)
    lc.UI.Widgets.CharacterJourneyWidget:Refresh(model)
  end
end