local lc = LevelingChronicle
local UI = lc.UI

local table_utils = LCTableUtils
local math_utils = LCMathUtils

CharacterJourneyPageOneMixin = {}

function CharacterJourneyPageOneMixin:Refresh(model)
  self.model = model
end

function CharacterJourneyPageOneMixin:OnPageTurn(file, coords)
  self.background:SetTexture(file)
  self.background:SetTexCoord(coords.ULx,coords.ULy,coords.LLx,coords.LLy,coords.URx,coords.URy,coords.LRx,coords.LRy)

  
  local stamp = UI.Definitions.JOURNAL_STAMPS[math_utils.rand(1,#UI.Definitions.JOURNAL_STAMPS, self.model.page_seed)]
  
  self.stampOne:SetTexture(stamp.file)
  self.stampOne:SetTexCoord(stamp.coords.left, stamp.coords.right, stamp.coords.top, stamp.coords.bottom)
end