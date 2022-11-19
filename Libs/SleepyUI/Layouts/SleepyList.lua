SleepyLayout = {}

	function SleepyLayout.List(content, children)
    content.rowPadding = content.rowPadding or 0

		local width = content:GetWidth() or 0
    local content_height = 0
    
		for i = 1, #children do
			local child = children[i]
      
			child:ClearAllPoints()
			if i == 1 then
				child:SetPoint("TOPLEFT", content, "TOPLEFT", content.leftPadding, -content.topPadding)
        if (content.rightPadding > 0) then
          child:SetPoint("TOPRIGHT", content, "TOPRIGHT", -content.rightPadding, -content.topPadding)
        end
			else
        local elder_sibling = children[i-1]
        if (elder_sibling:IsShown()) then
          child:SetPoint("TOPLEFT", children[i-1], "BOTTOMLEFT", 0, -content.rowPadding)
          if (content.rightPadding > 0) then
            child:SetPoint("TOPRIGHT", children[i-1], "BOTTOMRIGHT", 0, -content.rowPadding)
          end
        else
          child:SetPoint("TOPLEFT", children[i-1], "TOPLEFT", 0, 0)
          if (content.rightPadding > 0) then
            child:SetPoint("TOPRIGHT", children[i-1], "TOPRIGHT", 0, 0)
          end
        end
			end
      
      if (child:IsShown()) then
        content_height = content_height + child:GetHeight()
      end
      
    end

    local height = content_height + content.bottomPadding + content.topPadding
    content:SetHeight(height)
    
    if (content.OnLayoutFinished) then
      content:OnLayoutFinished(height)
    end
	end