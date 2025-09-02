game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)
		
        char:WaitForChild("Head")
		char:WaitForChild("Humanoid")

		for _, part in ipairs(char:GetDescendants()) do
			if part:IsA("BasePart") then
				if part.Name == "Head" then
					part.Color = Color3.new(1, 1, 1) 
					part.Material = Enum.Material.Neon
				else
					part.Color = Color3.new(0, 0, 0) 
					part.Material = Enum.Material.SmoothPlastic
				end
			end
		end
                
		local face = char.Head:FindFirstChildOfClass("Decal")
		if face then
			face.Texture = "rbxassetid://15296361385"
		end
	end)
end)
