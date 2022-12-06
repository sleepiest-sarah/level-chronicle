WowClassicAPI.Systems.C_ClassColor = {}
local C_ClassColor = WowClassicAPI.Systems.C_ClassColor 

function C_ClassColor.GetClassColor(class_file_name)
  local color = {}
  color.r, color.g, color.b = GetClassColor(class_file_name)
  
  return color
end