SleepyTableMixin = CreateFromMixins(SleepyCustomizableItemMixin)

local function fontStringResetter(pool, fs)
  fs:SetText(nil)
  fs.y = nil
  fs.x = nil
  fs.colspan = nil
  fs:SetWordWrap(false)
  fs:SetJustifyH("CENTER")
  FramePool_HideAndClearAnchors(pool, fs)
end

--[[
  items = {
    {{text = "row 1", colspan=2, font = "GameFontNormal"}},
    {{text = "row 2a"}, {text = "row 2b"}}
  }
--]]
function SleepyTableMixin:SetTableItems(table_def)
  self.fs_pool:ReleaseAll()
  
  if (table_def and #table_def > 0) then
    local item_widgets = {}
    for i,row in ipairs(table_def) do
      local x_coord = 0
      for j,col in ipairs(row) do
        local fc = self.fs_pool:Acquire()
        fc.y = i - 1
        fc.x = x_coord
        fc.colspan = col.colspan or 1
        x_coord = x_coord + fc.colspan
        
        --TODO clean up the resetters and use a pool collection instead of polluting the pool
        fc:SetFontObject(self.font)
        fc:SetText(col.text)
        self:SetFontStringOptions(fc, col)
        
        self:OnAcquire(fc)
        table.insert(item_widgets, fc)
      end
    end
    
    self:DoLayout(item_widgets)
  end
end

function SleepyTableMixin:OnLoad()
  self.fs_pool = CreateFontStringPool(self, "BACKGROUND", nil, self.font, fontStringResetter)
end

