--Team 40FR0XX Decal Spam (CLIENT SIDED)

decalID = 139149089226313
function exPro(root)
	for _, v in pairs(root:GetChildren()) do
		if v:IsA("Decal") and v.Texture ~= "http://www.roblox.com/asset/?id="..decalID then
			v.Parent = nil
		elseif v:IsA("BasePart") then
			v.Material = "Plastic"
			v.Transparency = 0

			local faces = {"Front", "Back", "Right", "Left", "Top", "Bottom"}
			for _, face in ipairs(faces) do
				local decal = Instance.new("Decal", v)
				decal.Texture = "http://www.roblox.com/asset/?id="..decalID
				decal.Face = face
			end
		end
		exPro(v)
	end
end

function asdf(root)
	for _, v in pairs(root:GetChildren()) do
		asdf(v)
	end
end

exPro(game.Workspace)
asdf(game.Workspace)

local s = Instance.new("Sky")
s.Name = "Sky"
s.Parent = game.Lighting
local skyboxID = 139149089226313
s.SkyboxBk = "http://www.roblox.com/asset/?id="..skyboxID
s.SkyboxDn = "http://www.roblox.com/asset/?id="..skyboxID
s.SkyboxFt = "http://www.roblox.com/asset/?id="..skyboxID
s.SkyboxLf = "http://www.roblox.com/asset/?id="..skyboxID
s.SkyboxRt = "http://www.roblox.com/asset/?id="..skyboxID
s.SkyboxUp = "http://www.roblox.com/asset/?id="..skyboxID
game.Lighting.TimeOfDay = 12	

for _, v in pairs(game.Players:GetChildren()) do
	if v.Character and v.Character:FindFirstChild("Torso") then
		for _ = 1, 3 do
			local emit = Instance.new("ParticleEmitter")
			emit.Parent = v.Character.Torso
			emit.Texture = "http://www.roblox.com/asset/?id=128386244995708"
			emit.VelocitySpread = 20
		end
	end
end
