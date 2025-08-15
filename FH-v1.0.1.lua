local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Config
local toggleKey = Enum.KeyCode.K
local uiVisible = true
local closedPermanently = false

-- Track keys for flying
local keysDown = {}

-- Store states so they persist after respawn
local infiniteJump = false
local speedActive = false
local speedValue = 100

-- UI creation wrapped in a function
local function createUI()
	-- Destroy old copy if exists
	if playerGui:FindFirstChild("Team40Fr0xxUI") then
		playerGui:FindFirstChild("Team40Fr0xxUI"):Destroy()
	end

	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	local hrp = character:WaitForChild("HumanoidRootPart")

	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "Team40Fr0xxUI"
	screenGui.Parent = playerGui

	local mainFrame = Instance.new("Frame")
	mainFrame.Size = UDim2.new(0,0,0,0)
	mainFrame.Position = UDim2.new(0.5,0,0.5,0)
	mainFrame.AnchorPoint = Vector2.new(0.5,0.5)
	mainFrame.BackgroundColor3 = Color3.fromRGB(40,40,50)
	mainFrame.BorderSizePixel = 0
	mainFrame.ClipsDescendants = true
	mainFrame.Active = true
	mainFrame.Draggable = true
	mainFrame.Parent = screenGui

	local uICorner = Instance.new("UICorner")
	uICorner.CornerRadius = UDim.new(0,25)
	uICorner.Parent = mainFrame

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1,-20,0,60)
	title.Position = UDim2.new(0,10,0,10)
	title.BackgroundTransparency = 1
	title.Text = "TEAM 40FR0XX V1.2.6"
	title.TextScaled = true
	title.TextColor3 = Color3.fromRGB(255,255,255)
	title.Font = Enum.Font.GothamBold
	title.Parent = mainFrame

	local buttonsFolder = Instance.new("ScrollingFrame")
	buttonsFolder.Size = UDim2.new(1,-40,1,-120)
	buttonsFolder.Position = UDim2.new(0,20,0,100)
	buttonsFolder.BackgroundTransparency = 1
	buttonsFolder.ScrollBarThickness = 8
	buttonsFolder.CanvasSize = UDim2.new(0,0,0,0)
	buttonsFolder.Parent = mainFrame

	local padding = Instance.new("UIPadding")
	padding.PaddingTop = UDim.new(0,5)
	padding.PaddingBottom = UDim.new(0,5)
	padding.PaddingLeft = UDim.new(0,5)
	padding.PaddingRight = UDim.new(0,5)
	padding.Parent = buttonsFolder

	local columns = 2
	local buttonWidth = 0.5
	local buttonHeight = 50
	local buttonSpacing = 10
	local createdButtons = {}

	local function createButton(text, callback)
		local button = Instance.new("TextButton")
		button.Size = UDim2.new(buttonWidth, -buttonSpacing, 0, buttonHeight)
		button.BackgroundColor3 = Color3.fromRGB(60,60,80)
		button.TextColor3 = Color3.fromRGB(255,255,255)
		button.Text = text
		button.Font = Enum.Font.GothamBold
		button.TextScaled = true
		button.Parent = buttonsFolder
		button.MouseButton1Click:Connect(callback)

		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0,15)
		corner.Parent = button

		table.insert(createdButtons, button)

		for i, btn in ipairs(createdButtons) do
			local row = math.floor((i-1)/columns)
			local col = (i-1)%columns
			btn.Position = UDim2.new(col*buttonWidth, col*buttonSpacing, 0, row*(buttonHeight + buttonSpacing))
		end

		local totalRows = math.ceil(#createdButtons/columns)
		buttonsFolder.CanvasSize = UDim2.new(0,0,0,totalRows*(buttonHeight+buttonSpacing))
	end

	createButton("[UNIVERSAL] Toggle Speed", function()
    speedActive = not speedActive
    humanoid.WalkSpeed = speedActive and speedValue or 16
end)

createButton("[UNIVERSAL] Infinite Jump", function()
    infiniteJump = not infiniteJump
end)

createButton("[UNIVERSAL] Clear Workspace", function()
    for _, obj in pairs(workspace:GetChildren()) do
        if obj ~= character and obj.Name ~= "Baseplate" and not obj:IsA("Terrain") then
            obj:Destroy()
        end
    end
end)

createButton("[UNIVERSAL] Dex", function()
    loadstring(game:HttpGet("https://obj.wearedevs.net/2/scripts/Dex%20Explorer.lua"))()
end)

createButton("[UNIVERSAL] Inf Yield", function()
    loadstring(game:HttpGet("https://obj.wearedevs.net/2/scripts/Infinite%20Yield.lua"))()
end)

createButton("[UNIVERSAL] Saveinstance (Decompiler)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/luau/UniversalSynSaveInstance/refs/heads/main/saveinstance.luau"))()
end)

createButton("[Forsaken] OP script", function()
    loadstring(game: HttpGet("https://gist.githubusercontent.com/ScriptsForDays/7d1d59d7ee74f737661958a7ece105c1/raw/50776639545b645b7ad457aeaa60b2346ba777a0/FORSAKEN-V1"))()
end)

createButton("[UNIVERSAL] Invincible Flight", function()
    loadstring(game:HttpGet("https://obj.wearedevs.net/197198/scripts/invincible%20flight%20animation.lua"))()
end)

createButton("[UNIVERSAL] FE ChatHax", function()
    loadstring(game:HttpGet("https://obj.wearedevs.net/108324/scripts/FE%20ChatHax.lua"))()
end)

createButton("[JB] JailBreak KickAll", function()
    loadstring(game:HttpGet("https://obj.wearedevs.net/58255/scripts/JAILBREAK%20KICK%20ALL%20SCRIPT.lua"))()
end)

createButton("[GAG] Grow A Garden Spawner", function()
    loadstring(game:HttpGet("https://obj.wearedevs.net/197196/scripts/Grow%20a%20Garden%20Script%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20Pet%20Spawner%20%20Seed%20%20Spawner%20%20Egg%20Spawner%20And%20More%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20Dark%20Spawner.lua"))()
end)

createButton("[UNIVERSAL] WRD ESP", function()
    loadstring(game:HttpGet("https://obj.wearedevs.net/2/scripts/WRD%20ESP.lua"))()
end)

createButton("[UNIVERSAL] Unlock Workspace Baseparts", function()
    loadstring(game:HttpGet("https://obj.wearedevs.net/2/scripts/Unlock%20Workspace%20Baseparts.lua"))()
end)

createButton("[UNIVERSAL] UNC Checker", function()
    loadstring(game:HttpGet("https://obj.wearedevs.net/2/scripts/UNC%20Checker.lua"))()
end)

createButton("[UNIVERSAL/CLIENTSIDE] BTools", function()
    loadstring(game:HttpGet("https://obj.wearedevs.net/2/scripts/BTools.lua"))()
end)

createButton("[FORSAKEN] M1JT Pack", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/M1JTpck1"))()
end)

createButton("[BF]Blox Fruits OP Script", function()
    loadstring(game:HttpGet("https://obj.wearedevs.net/196545/scripts/Blox%20Fruits%20OP%20Script.lua"))()
end)

createButton("[FORSAKEN] Forsaken Script 2", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OhhMyGehlee/sak/refs/heads/main/for"))()
end)

createButton("[UNIVERSAL] Click TP", function()
    loadstring(game:HttpGet("https://obj.wearedevs.net/2/scripts/Click%20Teleport.lua"))()
end)

createButton("[FORSAKEN] YARHM", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/FroxyCreates1/Team-40Fr0xx-Hub/refs/heads/main/YARHM.lua"))()
end)

createButton("[UNIVERSAL]ANTI-AFK", function()
    loadstring(game:HttpGet("https://obj.wearedevs.net/2/scripts/Focus%20Anti-AFK.lua"))()
end)

createButton("[UNIVERSAL]KaterHub", function()
    loadstring(game:HttpGet("https://katerhub-inc.github.io/KaterHub/main.lua"))()
end)

createButton("[UNIVERSAL - OP] VOID", function()
   loadstring(game:HttpGet('https://raw.githubusercontent.com/gurtfella39921/void/main/actual/VoidNew.lua'))()
end)

createButton("[FORSAKEN] GOONSAKEN SCRIPT", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/NumanTF3/Goonsaken-Hub/refs/heads/main/main.lua"))()
end)

createButton("[UNIVERSAL] Punch Tool", function()
   loadstring(game:HttpGet(('https://pastebin.com/raw/1LHtJcjF')))()
end)

createButton("[FLING PEOPLE AND THINGS] FTAP", function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/BlizTBr/scripts/refs/heads/main/FTAP.lua"))()
end)

createButton("[UNIVERSAL - OP] NAMELESS ADMIN", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/Source'))()
end)

createButton("UNIVERSAL] ESP V2", function()
    loadstring(game:HttpGet"https://raw.githubusercontent.com/FroxyCreates1/Team-40Fr0xx-Hub/refs/heads/main/ESP.lua")()
end)

createButton("[UNIVERSAL (PRESS X OR Z)] FLIP", function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/FroxyCreates1/Team-40Fr0xx-Hub/refs/heads/main/Flip.lua"))()
end)

createButton("[UNIVERSAL] FRONT FLIP", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/FroxyCreates1/Team-40Fr0xx-Hub/refs/heads/main/frontflip.lua"))()
end)

createButton("[UNIVERSAL] SIMPLE LUHH", function()
    loadstring(game:HttpGet("https://gist.githubusercontent.com/MMcmarc-sudo/7222c2a092c8a63a734b0d3a313fa731/raw"))()
end)

createButton("[FORSAKEN] FORSAKEN IO CHAMS", function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/FroxyCreates1/Team-40Fr0xx-Hub/refs/heads/main/Forsakeniochams.lua"))()
end)

createButton("[UNIVERSAL] GHOST HUB", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/GhostHub'))()
end)

createButton("[ANTI-CHEAT REMOVER] ANTI-ANTI CHEAT", function()
    loadstring(game:HttpGet"https://raw.githubusercontent.com/Steve-Bloks/adonis/refs/heads/main/adonisdisabler.lua")()
end)

createButton("[UNIVERSAL] Forsakation Hub", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/CyberNinja103/brodwa/refs/heads/main/ForsakationHub"))()
end)

-- Spawn Parts (LAGGY)
local spawnPartsActive = false
createButton("[UNIVERSAL/CLIENT] Spawn Parts", function()
    spawnPartsActive = not spawnPartsActive
    spawn(function()
        while spawnPartsActive do
            local part = Instance.new("Part")
            part.Size = Vector3.new(4,4,4)
            part.Position = hrp.Position + Vector3.new(math.random(-50,50), math.random(10,50), math.random(-50,50))
            part.Anchored = false
            part.CanCollide = true
            part.Color = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
            part.Parent = workspace
            wait(0.05)
        end
    end)
end)

	createButton("[UNIVERSAL] Infinite Jump", function()
		infiniteJump = not infiniteJump
	end)

	-- Close button
	local closeButton = Instance.new("TextButton")
	closeButton.Size = UDim2.new(0,50,0,50)
	closeButton.Position = UDim2.new(1,-60,0,10)
	closeButton.BackgroundColor3 = Color3.fromRGB(200,50,50)
	closeButton.Text = "X"
	closeButton.TextColor3 = Color3.fromRGB(255,255,255)
	closeButton.Font = Enum.Font.GothamBold
	closeButton.TextScaled = true
	closeButton.Parent = mainFrame

	closeButton.MouseButton1Click:Connect(function()
		closedPermanently = true
		local tweenOut = TweenService:Create(mainFrame,TweenInfo.new(0.4,Enum.EasingStyle.Quad),{Size=UDim2.new(0,0,0,0)})
		tweenOut:Play()
		tweenOut.Completed:Connect(function()
			mainFrame.Visible = false
		end)
	end)

	-- Toggle UI
	local function toggleUI(state)
		if closedPermanently then return end
		if state == nil then state = not uiVisible end
		uiVisible = state

		if uiVisible then
			mainFrame.Visible = true
			mainFrame.Size = UDim2.new(0,0,0,0)
			local tweenIn = TweenService:Create(mainFrame,TweenInfo.new(0.5,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out),{Size=UDim2.new(0,700,0,500)})
			tweenIn:Play()
		else
			local tweenOut = TweenService:Create(mainFrame,TweenInfo.new(0.4,Enum.EasingStyle.Quad),{Size=UDim2.new(0,0,0,0)})
			tweenOut:Play()
			tweenOut.Completed:Connect(function()
				mainFrame.Visible = false
			end)
		end
	end

	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.UserInputType == Enum.UserInputType.Keyboard then
			keysDown[input.KeyCode] = true
			if input.KeyCode == toggleKey then
				toggleUI()
			end
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Keyboard then
			keysDown[input.KeyCode] = nil
		end
	end)

	UserInputService.JumpRequest:Connect(function()
		if infiniteJump then
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end)

	toggleUI(true)
end

-- Create the UI when the game starts
createUI()

-- Recreate it on respawn
player.CharacterAdded:Connect(function()
	task.wait(0.1) -- wait a moment to avoid race conditions
	createUI()
end)
