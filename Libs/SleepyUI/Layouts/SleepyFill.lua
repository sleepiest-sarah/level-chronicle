local agui = LibStub("AceGUI-3.0", true)

--same ace Fill but uses the first visible child instead of the first child
agui:RegisterLayout("SleepyFill",
	function(content, children)
		for i,c in ipairs(children) do
      if (c.frame:IsVisible()) then
        c:SetWidth(content:GetWidth() or 0)
        c:SetHeight(content:GetHeight() or 0)
        c.frame:ClearAllPoints()
        c.frame:SetAllPoints(content)
        c.frame:Show()
        
        if (content.obj.LayoutFinished) then
          content.obj.LayoutFinished(content.obj,nil,c.frame:GetHeight())
        end
        
        break
      end
		end
	end)