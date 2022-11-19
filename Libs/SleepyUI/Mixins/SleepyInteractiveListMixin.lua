SleepyInteractiveListMixin = {}

function SleepyInteractiveListMixin:RegisterCallback(cb)
  self.interactiveCallback = cb
end

function SleepyInteractiveListMixin:Label_OnClick(button)
  if (self.selected) then
    self.selected:UnlockHighlight()
  end
  
  self.selected = button
  self.selected:LockHighlight()
  
  self.interactiveCallback(self, button.key)
end

function SleepyInteractiveListMixin:Select(key)
  if (not self.children or #self.children == 0) then
    return
  end
  
  for i,c in ipairs(self.children) do
    if (c.key == key) then
      self:Label_OnClick(c)
      return
    end
  end
  
  if (self.children and self.children[1]) then
    self:Label_OnClick(self.children[1])
  end
end