WowClassicAPI.Systems.Settings = {}
local Settings = WowClassicAPI.Systems.Settings

function Settings.RegisterCanvasLayoutCategory(frame, addon, position)
  InterfaceOptions_AddCategory(frame, addon, position)
  return {ID = addon}
end

function Settings.RegisterCanvasLayoutSubcategory(category, frame, name)
  InterfaceOptions_AddCategory(frame)
  return {ID = name}
end

-- doesn't need to do anything for the legacy the InterfaceOptions used in Classic
function Settings.RegisterAddOnCategory(category) end