-- Welcome to Team 40Fr0xx Hub! This is my first ever script hub i've made!
--Enjoy!
--Also, if this UI is removed apon death, re-execute it. Thanks!

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "ExploitAdminUI"

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 350)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.BorderSizePixel = 0
Title.Text = "TEAM 40FR0XX HUB"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24

local CloseButton = Instance.new("TextButton", MainFrame)
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -45, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200,50,50)
CloseButton.TextColor3 = Color3.new(1,1,1)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 24
CloseButton.Text = "X"
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local function createButton(name, yPos, callback)
    local Button = Instance.new("TextButton", MainFrame)
    Button.Size = UDim2.new(0, 180, 0, 40)
    Button.Position = UDim2.new(0, 10, 0, yPos)
    Button.BackgroundColor3 = Color3.fromRGB(45,45,45)
    Button.TextColor3 = Color3.new(1,1,1)
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 20
    Button.Text = name
    Button.MouseButton1Click:Connect(callback)
end

-- Feature variables
local flyEnabled = false
local speedEnabled = false
local jumpEnabled = false
local espEnabled = false
local flySpeed = 50
local speedMultiplier = 2

-- Character references
local Humanoid
local RootPart
local flyForce
local flyConnection

-- Assign character references
local function assignCharacter(char)
    Humanoid = char:WaitForChild("Humanoid")
    RootPart = char:WaitForChild("HumanoidRootPart")

    -- Reapply features if they were enabled before death
    if flyEnabled then toggleFly(true) end
    if speedEnabled then Humanoid.WalkSpeed = 60 else Humanoid.WalkSpeed = 16 end
    if espEnabled then toggleESP() end
end

-- Initial assignment
assignCharacter(Player.Character or Player.CharacterAdded:Wait())

-- Reassign on respawn
Player.CharacterAdded:Connect(assignCharacter)

-- Fly toggle
	function toggleFly(forceEnable)
    flyEnabled = forceEnable ~= nil and forceEnable or not flyEnabled

    if flyForce then flyForce:Destroy() end
    if flyConnection then flyConnection:Disconnect() end
    if not Humanoid or not RootPart then return end

    if flyEnabled then
        Humanoid.PlatformStand = true

        flyForce = Instance.new("BodyVelocity")
        flyForce.MaxForce = Vector3.new(1e5,1e5,1e5)
        flyForce.Velocity = Vector3.new(0,0,0)
        flyForce.P = 1000
        flyForce.Parent = RootPart

        flyConnection = RunService.Heartbeat:Connect(function()
            if not flyEnabled then return end
            local cam = workspace.CurrentCamera
            local dir = Vector3.new()
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir = dir - Vector3.new(0,1,0) end

            if dir.Magnitude > 0 then
                flyForce.Velocity = dir.Unit * flySpeed
            else
                flyForce.Velocity = Vector3.new(0,0,0)
            end
        end)
    else
        Humanoid.PlatformStand = false
        if flyForce then flyForce:Destroy() end
        if flyConnection then flyConnection:Disconnect() end
    end
	end

-- Speed toggle
	local function toggleSpeed()
    speedEnabled = not speedEnabled
    if Humanoid then
        Humanoid.WalkSpeed = speedEnabled and 60 or 16
    end
	end

-- Infinite jump
	local function toggleJump()
    jumpEnabled = not jumpEnabled
	end

-- Infinite Yeild
	local iyButtonY = 210  -- adjust to where you want it

	-- Infinite Yield
	local function loadInfiniteYield()
    local url = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if not success then
        warn("Failed to load Infinite Yield script:", result)
    end
	end

	-- Create the button using the same style as your other buttons
	local Button = Instance.new("TextButton", MainFrame)
	Button.Size = UDim2.new(0, 180, 0, 40)
	Button.Position = UDim2.new(0, 10, 0, iyButtonY)
	Button.BackgroundColor3 = Color3.fromRGB(45,45,45)
	Button.TextColor3 = Color3.new(1,1,1)
	Button.Font = Enum.Font.GothamBold
	Button.TextSize = 20
	Button.Text = "Infinite Yield (Not mines)"
	Button.MouseButton1Click:Connect(loadInfiniteYield)

-- Add Fire (LAG WARNING)
	local fireButtonY = 260  -- adjust as needed

	-- Function to add Fire to all BaseParts
	local function fireAllParts()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            -- Only add Fire if it doesn't already exist
            if not obj:FindFirstChildOfClass("Fire") then
                local fire = Instance.new("Fire")
                fire.Size = 5       -- default size
                fire.Heat = 10      -- default heat
                fire.Parent = obj
            end
        end
    end
	end

	-- Create the button
	local Button = Instance.new("TextButton", MainFrame)
	Button.Size = UDim2.new(0, 180, 0, 40)
	Button.Position = UDim2.new(0, 10, 0, fireButtonY)
	Button.BackgroundColor3 = Color3.fromRGB(45,45,45)
	Button.TextColor3 = Color3.new(1,1,1)
	Button.Font = Enum.Font.GothamBold
	Button.TextSize = 20
	Button.Text = "Add fire (LAG)"
	Button.MouseButton1Click:Connect(fireAllParts)

-- Toggle variables
	local flingEnabled = false
	local flingSpin
	local flingGyro

	local flingEnabled = false
	local flingSpin
	local flingGyro

	local flingButtonY = 308  -- adjust as needed

	local function toggleFling()
    if not RootPart then return end
    flingEnabled = not flingEnabled

    if flingEnabled then
        -- Spin yourself
        flingSpin = Instance.new("BodyAngularVelocity")
        flingSpin.Name = "FlingSpin"
        flingSpin.MaxTorque = Vector3.new(0,1e6,0)  -- only spin around Y
        flingSpin.AngularVelocity = Vector3.new(0, 50, 0)  -- fast spin
        flingSpin.P = 1e5
        flingSpin.Parent = RootPart

        -- Keep upright without blocking Y rotation
        flingGyro = Instance.new("BodyGyro")
        flingGyro.Name = "FlingGyro"
        flingGyro.MaxTorque = Vector3.new(1e6,0,1e6)  -- lock X/Z only
        flingGyro.CFrame = CFrame.new(RootPart.Position)
        flingGyro.P = 1e5
        flingGyro.Parent = RootPart
    else
        if flingSpin then flingSpin:Destroy() flingSpin = nil end
        if flingGyro then flingGyro:Destroy() flingGyro = nil end
    end
	end

	-- Create toggle button
	local Button = Instance.new("TextButton", MainFrame)
	Button.Size = UDim2.new(0, 180, 0, 40)
	Button.Position = UDim2.new(0, 10, 0, flingButtonY)
	Button.BackgroundColor3 = Color3.fromRGB(45,45,45)
	Button.TextColor3 = Color3.new(1,1,1)
	Button.Font = Enum.Font.GothamBold
	Button.TextSize = 20
	Button.Text = "Toggle Fling"
	Button.MouseButton1Click:Connect(toggleFling)


-- BillBoard
	local invisButtonY = 110
	local invisButtonX = 200

	-- Billboard button position (above invisibility button)
	local billboardButtonY = invisButtonY - 50  -- puts it directly above
	local billboardButtonX = invisButtonX

	-- Function to add BillboardGui above player's head
	local function addBillboardAbovePlayer()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local head = character:FindFirstChild("Head")

    if head and not head:FindFirstChild("Team40Fr0xxBillboard") then
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "Team40Fr0xxBillboard"
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 2, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = head

        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = "TEAM 40FR0XX"
        textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        textLabel.TextScaled = true
        textLabel.Font = Enum.Font.Fantasy
        textLabel.Parent = billboard
    end
	end

	-- Create the Billboard button
	local billboardButton = Instance.new("TextButton", MainFrame)
	billboardButton.Size = UDim2.new(0, 180, 0, 40)
	billboardButton.Position = UDim2.new(0, billboardButtonX, 0, billboardButtonY)
	billboardButton.BackgroundColor3 = Color3.fromRGB(45,45,45)
	billboardButton.TextColor3 = Color3.new(1,1,1)
	billboardButton.Font = Enum.Font.GothamBold
	billboardButton.TextSize = 20
	billboardButton.Text = "40FR0XX BILLBOARD"
	billboardButton.MouseButton1Click:Connect(addBillboardAbovePlayer)

-- Function to toggle invisibility
	local function toggleInvisibility()
    if not Player.Character then return end
    invisibleEnabled = not invisibleEnabled

    for _, part in pairs(Player.Character:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("MeshPart") then
            if invisibleEnabled then
                originalTransparency[part] = part.Transparency
                part.Transparency = 1
            else
                if originalTransparency[part] ~= nil then
                    part.Transparency = originalTransparency[part]
                else
                    part.Transparency = 0
                end
            end
        elseif part:IsA("Decal") or part:IsA("Texture") then
            if invisibleEnabled then
                originalTransparency[part] = part.Transparency
                part.Transparency = 1
            else
                if originalTransparency[part] ~= nil then
                    part.Transparency = originalTransparency[part]
                else
                    part.Transparency = 0
                end
            end
        elseif part:IsA("BillboardGui") or part:IsA("SurfaceGui") then
            part.Enabled = not invisibleEnabled
        end
    end

    -- Hide name display
    local humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.NameDisplayDistance = invisibleEnabled and 0 or 100
    end
	end

	-- Create the invisibility button
	local invisButton = Instance.new("TextButton", MainFrame)
	invisButton.Size = UDim2.new(0, 180, 0, 40)
	invisButton.Position = UDim2.new(0, invisButtonX, 0, invisButtonY)
	invisButton.BackgroundColor3 = Color3.fromRGB(45,45,45)
	invisButton.TextColor3 = Color3.new(1,1,1)
	invisButton.Font = Enum.Font.GothamBold
	invisButton.TextSize = 20
	invisButton.Text = "Toggle Invisibility"
	invisButton.MouseButton1Click:Connect(toggleInvisibility)

-- Immortal toggle 
	local immortalEnabled = false
	local immortalConn -- HealthChanged connection
	local savedMaxHealth -- to restore when turning off

	local function applyImmortal(hum)
    if not hum then return end
    -- remember original MaxHealth so we can restore later
    savedMaxHealth = hum.MaxHealth
    hum.MaxHealth = 1e9       -- big but sane
    hum.Health = hum.MaxHealth

    -- keep health maxed while enabled
    if immortalConn then immortalConn:Disconnect() end
    immortalConn = hum.HealthChanged:Connect(function()
        if immortalEnabled then
            hum.MaxHealth = 1e9
            hum.Health = hum.MaxHealth
        end
    end)
	end

	local function removeImmortal(hum)
    if immortalConn then immortalConn:Disconnect() immortalConn = nil end
    if hum then
        hum.MaxHealth = (savedMaxHealth and savedMaxHealth > 0) and savedMaxHealth or 100
        hum.Health = hum.MaxHealth
    end
	end

	local function toggleImmortal()
    immortalEnabled = not immortalEnabled
    local char = Player.Character or Player.CharacterAdded:Wait()
    local hum = char:FindFirstChildOfClass("Humanoid")
    if immortalEnabled then
        applyImmortal(hum)
    else
        removeImmortal(hum)
    end
	end

	-- reapply on respawn if still enabled
	Player.CharacterAdded:Connect(function(char)
    if immortalEnabled then
        local hum = char:WaitForChild("Humanoid")
        applyImmortal(hum)
    end
	end)

	-- Button
	local immortalButtonY = 160   -- place under your invis at 110
	local immortalButtonX = 200   -- right column

	local immortalButton = Instance.new("TextButton", MainFrame)
	immortalButton.Size = UDim2.new(0, 180, 0, 40)
	immortalButton.Position = UDim2.new(0, immortalButtonX, 0, immortalButtonY)
	immortalButton.BackgroundColor3 = Color3.fromRGB(45,45,45)
	immortalButton.TextColor3 = Color3.new(1,1,1)
	immortalButton.Font = Enum.Font.GothamBold
	immortalButton.TextSize = 20
	immortalButton.Text = "Toggle Immortal"
	immortalButton.MouseButton1Click:Connect(toggleImmortal)


-- Buttons
createButton("Fly Mode", 60, toggleFly)
createButton("Speed Hack", 110, toggleSpeed)
createButton("Infinite Jump", 160, toggleJump)