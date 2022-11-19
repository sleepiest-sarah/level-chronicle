
--similar to the Grid layout but doesn't try to use the full available height and won't resize children
function SleepyLayout.Table (content, children)
  local num_cols = content.num_columns
  
  local col_width = (content:GetWidth() - content.leftPadding - content.rightPadding) / num_cols
  
  local row_heights = {}
  local height = 0
  local max_y = 0
  for i,child in ipairs(children) do
    child:ClearAllPoints()
    child:Show()
    
    max_y = child.y
    
    --child width has to be set before measuring height in case it changes the height e.g. fontstring word wrap
    local childWidth = (not child.colspan or child.colspan == 1) and col_width or (col_width * child.colspan)
    child:SetWidth(childWidth)
    
    --if it's a new row then increment height by the tallest widget in the previous row
    if (child.y > 0 and not row_heights[child.y]) then
      height = height + row_heights[child.y-1]
      
      height = height + (child.y > 1 and content.rowPadding or 0) + (child.y == 1 and content.topPadding or 0)
    end
    
    --use the tallest widget in the row as the row height
    local child_height = child:GetHeight()
    row_heights[child.y] = (not row_heights[child.y] and child_height) or (child_height > row_heights[child.y] and child_height) or row_heights[child.y]
    
    if (child.y == 0) then
      child:SetPoint("TOPLEFT", content, "TOPLEFT", (child.x * col_width) + content.leftPadding, -content.topPadding)
    else
      child:SetPoint("TOPLEFT", content, "TOPLEFT"
                    ,(child.x * col_width) + content.leftPadding
                    ,-(height + content.rowPadding))
    end
    
    if (child.DoLayout) then
      child:DoLayout()
    end
  end
  
  height = height + row_heights[max_y] + content.bottomPadding
  
  if (content.OnLayoutFinished) then
    content:OnLayoutFinished(height)
  end
end