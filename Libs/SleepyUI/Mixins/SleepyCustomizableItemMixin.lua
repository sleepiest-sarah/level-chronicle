SleepyCustomizableItemMixin = {}

function SleepyCustomizableItemMixin:SetOnAcquireCallback(func)
  self.onAcquireCallback = func
end

function SleepyCustomizableItemMixin:OnAcquire(item)
  if (self.onAcquireCallback) then
    self:onAcquireCallback(item)
  end
end

function SleepyCustomizableItemMixin:SetFontStringOptions(fs, options)
  if (options.justifyh) then
    fs:SetJustifyH(options.justifyh)
  end
  
  if (options.justifyv) then
    fs:SetJustifyV(options.justifyv)
  end
  
  if (options.wordwrap) then
    fs:SetWordWrap(options.wordwrap)
  end
  
  if (options.font) then
    fs:SetFontObject(options.font)
  end
end