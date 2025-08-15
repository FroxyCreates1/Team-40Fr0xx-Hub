--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- green aura with flies
local function createMatrixAura()
	for _, partName in {"HumanoidRootPart", "UpperTorso", "Torso"} do
		local part = character:FindFirstChild(partName)
		if part then
			local aura = Instance.new("ParticleEmitter")
			aura.Name = "MatrixAura"
			aura.Color = ColorSequence.new(Color3.fromRGB(0, 255, 0))
			aura.LightEmission = 0.8
			aura.Size = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 2),
				NumberSequenceKeypoint.new(1, 0.5)
			})
			aura.Texture = "rbxassetid://243660364"
			aura.Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0.1),
				NumberSequenceKeypoint.new(1, 1)
			})
			aura.Rate = 180
			aura.Lifetime = NumberRange.new(1, 2)
			aura.Speed = NumberRange.new(1, 2)
			aura.SpreadAngle = Vector2.new(60, 60)
			aura.VelocitySpread = 40
			aura.ZOffset = -1.2
			aura.LockedToPart = true
			aura.Parent = part
		end
	end
end

-- sword spawning
local function createSword()
	local model = Instance.new("Model")
	model.Name = "DarkheartSword"

	local handle = Instance.new("Part")
	handle.Name = "Handle"
	handle.Size = Vector3.new(0.2, 3.5, 0.2)
	handle.Material = Enum.Material.Neon
	handle.BrickColor = BrickColor.new("Really black")
	handle.CanCollide = false

	local blade = Instance.new("Part")
	blade.Size = Vector3.new(0.4, 2.5, 0.4)
	blade.Material = Enum.Material.ForceField
	blade.BrickColor = BrickColor.new("Really red")
	blade.Transparency = 0.3
	blade.CanCollide = false
	blade.Position = handle.Position + Vector3.new(0, 1.5, 0)

	local weld = Instance.new("WeldConstraint")
	weld.Part0 = handle
	weld.Part1 = blade
	weld.Parent = handle

	handle.Parent = model
	blade.Parent = model
	model.PrimaryPart = handle

	return model
end

-- animation tool with swords
local animator = humanoid:WaitForChild("Animator")

local function createAnimationToolWithSwords(toolName, animationId)
	local tool = Instance.new("Tool")
	tool.Name = toolName
	tool.RequiresHandle = false
	tool.CanBeDropped = false

	local equippedTrack = nil
	local swordsFolder = nil

	tool.Equipped:Connect(function()
		-- Stop current animations
		for _, track in pairs(animator:GetPlayingAnimationTracks()) do
			track:Stop()
		end

		-- play animation
		local anim = Instance.new("Animation")
		anim.AnimationId = animationId
		equippedTrack = humanoid:LoadAnimation(anim)
		equippedTrack.Looped = true
		equippedTrack:Play()

		-- spawn swords
		swordsFolder = Instance.new("Folder")
		swordsFolder.Name = "EquippedSwords"
		swordsFolder.Parent = character

		local function attachSwordToWithFolder(part)
			local sword = createSword()
			sword:SetPrimaryPartCFrame(part.CFrame * CFrame.new(0, -1.5, 0.5) * CFrame.Angles(math.rad(90), 0, 0))
			sword.Parent = swordsFolder

			local weld = Instance.new("WeldConstraint")
			weld.Part0 = part
			weld.Part1 = sword.PrimaryPart
			weld.Parent = sword.PrimaryPart
		end

		if humanoid.RigType == Enum.HumanoidRigType.R15 then
			local rightHand = character:FindFirstChild("RightHand")
			local leftHand = character:FindFirstChild("LeftHand")
			if rightHand and leftHand then
				attachSwordToWithFolder(rightHand)
				attachSwordToWithFolder(leftHand)
			end
		else
			local rightArm = character:FindFirstChild("Right Arm")
			local leftArm = character:FindFirstChild("Left Arm")
			if rightArm and leftArm then
				attachSwordToWithFolder(rightArm)
				attachSwordToWithFolder(leftArm)
			end
		end
	end)

	tool.Unequipped:Connect(function()
		-- stop animation
		if equippedTrack and equippedTrack.IsPlaying then
			equippedTrack:Stop()
		end

		-- remove swords
		if swordsFolder then
			swordsFolder:Destroy()
			swordsFolder = nil
		end
	end)

	tool.Parent = player.Backpack
end

-- spawn aura
createMatrixAura()

-- spawn the two tools
createAnimationToolWithSwords("Slash", "rbxassetid://45913583")
createAnimationToolWithSwords("Mass Infection", "rbxassetid://48146273")

-- disable default animations
if character:FindFirstChild("t4t_animateR6") then
	character.t4t_animateR6.Enabled = false
elseif character:FindFirstChild("Animate") then
	character.Animate.Enabled = false
end

-- stop all current animations
for _, track in pairs(animator:GetPlayingAnimationTracks()) do
	track:Stop()
end

-- movement animations
local jumpAnimation = Instance.new("Animation")
jumpAnimation.AnimationId = "rbxassetid://97170520"
local jumpTrack = humanoid:LoadAnimation(jumpAnimation)
jumpTrack.Looped = false

local walkAnimation = Instance.new("Animation")
walkAnimation.AnimationId = "rbxassetid://92576399"
local walkTrack = humanoid:LoadAnimation(walkAnimation)
walkTrack.Looped = true

local idleAnimation = Instance.new("Animation")
idleAnimation.AnimationId = "rbxassetid://73033590"
local idleTrack = humanoid:LoadAnimation(idleAnimation)
idleTrack.Looped = true

humanoid.StateChanged:Connect(function(_, newState)
	if newState == Enum.HumanoidStateType.Jumping then
		jumpTrack:Play()
		jumpTrack:AdjustSpeed(1)
		jumpTrack.TimePosition = 0.2
	elseif newState == Enum.HumanoidStateType.Landed then
		jumpTrack:Stop()
	end
end)

game:GetService("RunService").RenderStepped:Connect(function()
	local isMoving = humanoid.MoveDirection.Magnitude > 0
	local isOnGround = humanoid.FloorMaterial ~= Enum.Material.Air

	if isMoving and isOnGround then
		if not walkTrack.IsPlaying then
			walkTrack:Play()
		end
		if idleTrack.IsPlaying then
			idleTrack:Stop()
		end
	else
		if walkTrack.IsPlaying then
			walkTrack:Stop()
		end
		if not idleTrack.IsPlaying and not jumpTrack.IsPlaying then
			idleTrack:Play()
		end
	end
end)
