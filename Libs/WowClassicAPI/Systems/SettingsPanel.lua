WowClassicAPI.Systems.SettingsPanel = {}
local SettingsPanel = WowClassicAPI.Systems.SettingsPanel

function SettingsPanel:OpenToCategory(id)
  InterfaceOptionsFrame_OpenToCategory(id)
end

function SettingsPanel:SelectCategory(category)
  InterfaceOptionsFrame_OpenToCategory(category.ID)
end