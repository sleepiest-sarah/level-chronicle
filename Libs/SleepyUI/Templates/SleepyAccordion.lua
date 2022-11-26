local math_utils = LCMathUtils

SleepyAccordionMixin = CreateFromMixins(SleepyInteractiveListMixin, SleepyCustomizableItemMixin)

function SleepyAccordionMixin:RefreshAccordion()
  if (not self.children or #self.children == 0) then
    return
  end

  for i, child in ipairs(self.children) do
    if (child.expanded ~= nil) then
      self:OnAcquire(child)
      
      local j = i + 1
      local item = self.children[j]
      while (item and not item.header) do
        if (child.expanded) then
          item:Show()
        else
          item:Hide()
        end
        j = j + 1
        item = self.children[j]
      end
        
    end
  end
  
  self:DoLayout(self.children)
end

--[[
  items = {
    {text="header display text" children={
                                  {text="item 1" key="item callback key"},
                                  {text="item 2" key="item 2 callback key"}
                                }
    },
    {text="header 2 display text" children={...}}
  }
--]]
function SleepyAccordionMixin:SetAccordionItems(items)
  self.items = items
  
  self.headerPool:ReleaseAll()
  self.itemPool:ReleaseAll()
  
  self.children = {}
  for i, header in ipairs(items) do
    local headerFrame = self.headerPool:Acquire()
    header.frame = headerFrame
    headerFrame.header = true
    headerFrame.expanded = false
    headerFrame:SetNormalFontObject(self.header_font or self.font)
    headerFrame:SetHighlightFontObject(self.header_highlight_font or self.font)
    headerFrame:SetText(header.text)
    
    self:OnAcquire(headerFrame)

    headerFrame:Show()
    table.insert(self.children,headerFrame)
    
    for _,sub in ipairs(header.children) do
      local subFrame = self.itemPool:Acquire()
      sub.frame = subFrame
      subFrame:SetNormalFontObject(self.font)
      subFrame.key = sub.key or sub.text
      subFrame:SetText(sub.text)
      
      self:OnAcquire(subFrame)
      
      subFrame:Show()
      table.insert(self.children, subFrame)
    end
  end
  
  self:RefreshAccordion()
end

function SleepyAccordionMixin:CollapseAll()
  for widget in self.headerPool:EnumerateActive() do
    widget.expanded = false
  end
  
  self:RefreshAccordion()
end

function SleepyAccordionMixin:Header_OnClick(button)
  button.expanded = not button.expanded
  self:RefreshAccordion()
end

--override SleepyInteractiveListMixin.Label_OnClick
function SleepyAccordionMixin:Label_OnClick(button)
  if (self.selected) then
    self.selected:UnlockHighlight()
  end
  
  self.selected = button
  self.selected:LockHighlight()
  
  for _, header in ipairs(self.items) do
    if (not header.expanded) then
      for _, child in ipairs(header.children) do
        if (child.frame == self.selected) then
          header.frame.expanded = true
          break
        end
      end
    end
  end
  
  self.interactiveCallback(self, button.key)
end

function SleepyAccordionMixin:SleepyAccordion_OnLoad()
  self.headerPool = CreateFramePool("BUTTON", self, "SleepyExpandableHeaderTemplate")
  if (self.interactive) then
    self.itemPool = CreateFramePool("BUTTON", self, "SleepyInteractiveLabel")
  else 
    self.itemPool = CreateFontStringPool(self, "BACKGROUND", nil, self.font)
  end
end