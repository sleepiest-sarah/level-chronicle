SleepyTextListMixin = CreateFromMixins(SleepyCustomizableItemMixin)

local function fontStringResetter(pool, fs)
  fs:SetText(nil)
  fs.index = nil
  FramePool_HideAndClearAnchors(pool, fs)
end

function SleepyTextListMixin:SetTextItems(items)
  if (not self.fs_pool) then
    self.fs_pool = CreateFontStringPool(self, "BACKGROUND", nil, self.font, self.resetter_func or fontStringResetter)
  end
  
  self.fs_pool:ReleaseAll()
  
  if (items) then
    local item_widgets = {}
    for i,item in ipairs(items) do
      local fc = self.fs_pool:Acquire()
      fc:SetWidth(self:GetWidth())
      fc:SetText(item)
      fc.index = i
      fc:SetFontObject(self.font)
      self:SetFontStringOptions(fc, item)
      self:OnAcquire(fc)
      
      table.insert(item_widgets, fc)
      fc:Show()
    end
    
    self:DoLayout(item_widgets)
  end
end


