-- ## ESP Functions Starting ## --
Tracers = false
Boxes = false
TracerColor = Color3.fromRGB(255, 255, 255)
BoxesColor = Color3.fromRGB(255, 255, 255)
SelectedPart = "Head"

local tracing = {}
local tracer = {
	create = function()
		local esptracer = Drawing.new("Line")
		esptracer.Visible = true
		esptracer.Transparency = .5
		esptracer.Thickness = 2
		esptracer.From = Vector2.new(game:GetService("Workspace").CurrentCamera.ViewportSize.X / 2, game:GetService("Workspace").CurrentCamera.ViewportSize.Y)
		return esptracer
	end
}


local box = {
	create = function()
		local espbox = Drawing.new("Square")
		espbox.Transparency = .9
		espbox.Thickness = 1
		espbox.Visible = true
		return espbox
	end
}

game:GetService("RunService").Stepped:Connect(function()
	spawn(function()
		for i, v in pairs((game:GetService("Players")):GetChildren()) do
			if v.Name ~= game:GetService("Players").LocalPlayer.Name and v.Character and v.Character:FindFirstChild(SelectedPart) and v.Character and Tracers then
				if not tracing[v.Name] then
					tracing[v.Name] = { v.Character }
				end
				local camPos, isVis = game:GetService("Workspace").CurrentCamera:WorldToScreenPoint(v.Character[SelectedPart].Position)
				if Tracers then
					if tracing[v.Name][2] then
						tracing[v.Name][2].Visible = isVis and Tracers
						tracing[v.Name][2].Color = TracerColor
                        tracing[v.Name][2].To = Vector2.new(camPos.X, camPos.Y + (game:GetService("GuiService")):GetGuiInset().Y)
                        tracing[v.Name][2].From = Vector2.new(game:GetService("Players").LocalPlayer:GetMouse().X, game:GetService("Players").LocalPlayer:GetMouse().Y + (game:GetService("GuiService")):GetGuiInset().Y)
					else
						tracing[v.Name][2] = tracer.create()
						tracing[v.Name][2].Visible = isVis and Tracers
                        tracing[v.Name][2].To = Vector2.new(camPos.X, camPos.Y + (game:GetService("GuiService")):GetGuiInset().Y)
                        tracing[v.Name][2].From = Vector2.new(game:GetService("Players").LocalPlayer:GetMouse().X, game:GetService("Players").LocalPlayer:GetMouse().Y + (game:GetService("GuiService")):GetGuiInset().Y)
						tracing[v.Name][2].Color = TracerColor
					end
				end
				if Boxes then
					if tracing[v.Name][3] then
						tracing[v.Name][3].Visible = isVis and Boxes
						tracing[v.Name][3].Size = Vector2.new(2000 / camPos.Z, 4500 / camPos.Z)
						tracing[v.Name][3].Color = BoxesColor
						tracing[v.Name][3].Position = Vector2.new(camPos.X - tracing[v.Name][3].Size.X / 2, camPos.Y + game:GetService("GuiService"):GetGuiInset().Y - tracing[v.Name][3].Size.Y / 2)
                    else
                        tracing[v.Name][3] = box.create()
                        tracing[v.Name][3].Visible = isVis and Boxes
						tracing[v.Name][3].Size = Vector2.new(2000 / camPos.Z, 4500 / camPos.Z)
						tracing[v.Name][3].Color = BoxesColor
						tracing[v.Name][3].Position = Vector2.new(camPos.X - tracing[v.Name][3].Size.X / 2, camPos.Y + game:GetService("GuiService"):GetGuiInset().Y - tracing[v.Name][3].Size.Y / 2)
					end
				end
			else
				if tracing[v.Name] then
					if tracing[v.Name][2] then
						tracing[v.Name][2]:Remove()
						tracing[v.Name][2] = nil
					end
					if tracing[v.Name][3] then
						tracing[v.Name][3]:Remove()
						tracing[v.Name][3] = nil
					end
				end
			end
		end
	end)
end)
game:GetService("Players").PlayerRemoving:Connect(function(remove_player)
	if tracing[remove_player.Name] then
		if tracing[remove_player.Name][2] then
			tracing[remove_player.Name][2]:Remove()
			tracing[remove_player.Name][2] = nil
		end
		if tracing[remove_player.Name][3] then
			tracing[remove_player.Name][3]:Remove()
			tracing[remove_player.Name][3] = nil
		end
		tracing[remove_player.Name] = nil
	end
end)
-- ## ESP Functions Finished ## --

OpenSourceESP = {}
function OpenSourceESP:Tracers(bool, color)
	if bool == true and not Tracers then
        Tracers = true
        TracerColor = color
	elseif Tracers and bool == false then
		Tracers = false
	end
end
function OpenSourceESP:Boxes(bool, color)
	if bool == true and not Boxes then
        Boxes = true
        BoxesColor = color
	elseif Boxes and bool == false then
		Boxes = false
	end
end

return OpenSourceESP
