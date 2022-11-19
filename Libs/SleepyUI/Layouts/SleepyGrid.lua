
--allows for laying out children on an x rows by y columns grid with children placed at specific x,y coordinates
--set num_rows and num_cols on the grid and rowspan/colspan and grid position (x/y) on the children
function SleepyLayout.Grid (content, children)
  local num_rows = content.num_rows
  local num_cols = content.num_columns
  
  local height = content:GetHeight()
  local width = content:GetWidth()
  local rowHeight = height / num_rows
  local columnWidth = width / num_cols
  
  local anchorPoints = {}
  for x=0,num_cols do
    for y=0,num_rows do
      anchorPoints[tostring(x)..","..tostring(y)] = {x = x * columnWidth, y = y * rowHeight}
    end
  end
  
  for i,child in ipairs(children) do
    child:ClearAllPoints()
    child:Show()
    
    local child_grid_position = tostring(child.x)..","..tostring(child.y)
    child:SetPoint("TOPLEFT", content, "TOPLEFT"
                  ,anchorPoints[child_grid_position].x
                  ,anchorPoints[child_grid_position].y * -1)
    
    local childHeight = (not child.rowspan or child.rowspan == 1) and rowHeight or (rowHeight * child.rowspan)
    local childWidth = (not child.colspan or child.colspan == 1) and columnWidth or (columnWidth * child.colspan)
    child:SetWidth(childWidth)
    child:SetHeight(childHeight)
    
    if (child.DoLayout) then
      child:DoLayout()
    end
  end
end