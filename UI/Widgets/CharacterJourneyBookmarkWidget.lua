local lc = LevelingChronicle
local UI = lc.UI

local table_utils = LCTableUtils
local math_utils = LCMathUtils
local string_utils = LCStringUtils

CharacterJourneyBookmarkMixin = {}

local bookmark_colors = {
    {r = 0, g = .9, b = .9},
    {r = 0, g = 0, b = .8},
    {r = .9, g = .8, b = .4},
    {r = 0.4, g = 0, b = .2},
    {r = 0.4, g = .6, b = .1},
    {r = 0.8, g = .6, b = .4},
    {r = 0.5, g = .4, b = .3},
  }
  
local function fuzzyListLayout(content, children)
		local width = content:GetWidth() or 0
    
    local child_height = children[1] and children[1]:GetHeight() or 0
    local num_rows = math.floor(content:GetHeight() / child_height)
    local num_rows_per_child = math.floor(num_rows / #children)
    
		for i = 1, #children do
			local child = children[i]
			
			child:ClearAllPoints()
			if i == 1 then
				child:SetPoint("TOPLEFT", content, "TOPLEFT", content.leftPadding, -content.topPadding)
			else
        local row = math_utils.rand(0,num_rows_per_child-1, content.model.seed)
				child:SetPoint("TOPLEFT", children[i-1], "BOTTOMLEFT", 0, -row * child_height)
			end
		end
end

local function getPageForLevel(level, page_map)

  for page_num, page in pairs(page_map) do
    for _,l in ipairs(page) do
      if (l == level) then
        return page_num
      end
    end
  end
  
  return nil
end

local function buildPageMap(level_range)
  local page_map = {}
  
  local page = nil
  local i = 1
  for _,level in ipairs(level_range) do
    if (not page) then
      page = {}
      page_map[tostring(i)] = page
    end
    
    if (#page < 2) then
      table.insert(page, level)
    end
    
    if (#page == 2) then
      i = i + 1
      page = nil
    end
      
  end
  
  return page_map
end

function CharacterJourneyBookmarkMixin:Refresh(model)
  if (not self.button_pool) then
    self.button_pool = CreateFramePool("BUTTON", self, "BookmarkButtonTemplate")
  end
  
  if (not self.num_level_keys or self.num_level_keys ~= #model.level_keys or self.guid ~= model.char.guid) then
    self.model = model
    self.num_level_keys = #model.level_keys
    self.guid = model.char.guid
  
    self.button_pool:ReleaseAll()
  
    local level_range = model.level_keys
    local page_map = buildPageMap(level_range)
    
    local num_bookmarks = math.floor(#level_range / 10)
    local levels = {}
    for i=1,num_bookmarks do
      table.insert(levels, tostring(i*10))
    end
    
    local buttons = {}
    for i,lvl in ipairs(levels) do
      local button = self.button_pool:Acquire()
      local color = bookmark_colors[math_utils.rand(1,#bookmark_colors, model.seed+i)]
      
      button.text:SetText(lvl)
      button.background:SetVertexColor(color.r, color.g, color.b)
      button:Show()

      button.page = getPageForLevel(lvl, page_map)

      local cb = function (button) UI.Controller.loadCharacterJourneyWidget(model.char.guid, button.page) end

      button:SetScript('OnClick', cb)
      
      table.insert(buttons, button)
    end

    self:DoLayout(buttons, fuzzyListLayout)
  end
end