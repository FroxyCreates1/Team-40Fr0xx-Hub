-- Full LocalScript: Key system + full Team40Fr0xx UI (all buttons included)
-- Place this as a LocalScript (StarterPlayerScripts / PlayerGui)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")


local toggleKey = Enum.KeyCode.K
local uiVisible = true
local closedPermanently = false


local keysDown = {}


local infiniteJump = false
local speedActive = false
local speedValue = 100


local validKeys = {
    ["Froxy"] = true,
    ["Fr0xy"] = true,
    ["Fire"] = true,
    ["SubToFr0xy"] = true
}
local keyEntered = false




local function createKeySystem(callback)
    
    if keyEntered then
        callback()
        return
    end

    local keyGui = Instance.new("ScreenGui")
    keyGui.Name = "KeySystem"
    keyGui.ResetOnSpawn = false
    keyGui.IgnoreGuiInset = true
    keyGui.Parent = playerGui

    local overlay = Instance.new("Frame")
    overlay.Size = UDim2.new(1,0,1,0)
    overlay.Position = UDim2.new(0,0,0,0)
    overlay.BackgroundColor3 = Color3.fromRGB(15,15,20)
    overlay.BorderSizePixel = 0
    overlay.Parent = keyGui

    local centerFrame = Instance.new("Frame")
    centerFrame.Size = UDim2.new(0,600,0,220)
    centerFrame.AnchorPoint = Vector2.new(0.5,0.5)
    centerFrame.Position = UDim2.new(0.5,0,0.45,0)
    centerFrame.BackgroundColor3 = Color3.fromRGB(30,30,40)
    centerFrame.Parent = overlay

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,14)
    corner.Parent = centerFrame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1,-20,0,60)
    title.Position = UDim2.new(0,10,0,10)
    title.BackgroundTransparency = 1
    title.Text = "ENTER KEY TO UNLOCK"
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.Parent = centerFrame

    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(1,-40,0,30)
    subtitle.Position = UDim2.new(0,20,0,70)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "Hint: ask Froxy nicely 🍪"
    subtitle.TextScaled = true
    subtitle.Font = Enum.Font.Gotham
    subtitle.TextColor3 = Color3.fromRGB(200,200,200)
    subtitle.TextTransparency = 0.2
    subtitle.Parent = centerFrame

    local textbox = Instance.new("TextBox")
    textbox.Size = UDim2.new(0.86,0,0,50)
    textbox.Position = UDim2.new(0.07,0,0,110)
    textbox.PlaceholderText = "Enter key..."
    textbox.Text = ""
    textbox.TextScaled = true
    textbox.Font = Enum.Font.Gotham
    textbox.TextColor3 = Color3.fromRGB(0,0,0)
    textbox.BackgroundColor3 = Color3.fromRGB(240,240,240)
    textbox.ClearTextOnFocus = false
    textbox.Parent = centerFrame

    local submit = Instance.new("TextButton")
    submit.Size = UDim2.new(0.4,0,0,44)
    submit.Position = UDim2.new(0.3,0,0,170)
    submit.Text = "Submit"
    submit.TextScaled = true
    submit.Font = Enum.Font.GothamBold
    submit.TextColor3 = Color3.fromRGB(255,255,255)
    submit.BackgroundColor3 = Color3.fromRGB(0,170,0)
    submit.Parent = centerFrame

    local function tryKey(key)
        if validKeys[key] then
            keyEntered = true
            pcall(function() keyGui:Destroy() end)
            callback()
            return true
        else
            textbox.Text = ""
            textbox.PlaceholderText = "Invalid Key!"
            textbox.PlaceholderColor3 = Color3.fromRGB(255,100,100)
           
            pcall(function()
                local tw = TweenService:Create(centerFrame, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 2, true), {Position = centerFrame.Position + UDim2.new(0,6,0,0)})
                tw:Play()
            end)
            return false
        end
    end

    submit.MouseButton1Click:Connect(function()
        tryKey(textbox.Text)
    end)

    textbox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            tryKey(textbox.Text)
        end
    end)

  
    keyGui.Active = true
end




local function createUI()
    
    local old = playerGui:FindFirstChild("Team40Fr0xxUI")
    if old then old:Destroy() end

    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local hrp = character:WaitForChild("HumanoidRootPart")

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "Team40Fr0xxUI"
    screenGui.ResetOnSpawn = false
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
    title.Text = "TEAM 40FR0XX V1.2.7"
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
        pcall(function()
            loadstring(game:HttpGet("https://obj.wearedevs.net/2/scripts/Dex%20Explorer.lua"))()
        end)
    end)

    createButton("[UNIVERSAL] Infinite Yield", function()
        pcall(function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
        end)
    end)

    createButton("[UNIVERSAL] Saveinstance (Decompiler)", function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/luau/UniversalSynSaveInstance/refs/heads/main/saveinstance.luau"))()
        end)
    end)

    createButton("[Forsaken] OP script", function()
        pcall(function()
            loadstring(game:HttpGet("https://gist.githubusercontent.com/ScriptsForDays/7d1d59d7ee74f737661958a7ece105c1/raw/50776639545b645b7ad457aeaa60b2346ba777a0/FORSAKEN-V1"))()
        end)
    end)

    createButton("[UNIVERSAL] Invincible Flight", function()
        pcall(function()
            loadstring(game:HttpGet("https://obj.wearedevs.net/197198/scripts/invincible%20flight%20animation.lua"))()
        end)
    end)

    createButton("[UNIVERSAL] FE ChatHax", function()
        pcall(function()
            loadstring(game:HttpGet("https://obj.wearedevs.net/108324/scripts/FE%20ChatHax.lua"))()
        end)
    end)

    createButton("[JAILBREAK] JailBreak KickAll", function()
        pcall(function()
            loadstring(game:HttpGet("https://obj.wearedevs.net/58255/scripts/JAILBREAK%20KICK%20ALL%20SCRIPT.lua"))()
        end)
    end)

    createButton("[STEAL A BRAINROT] ChilliHub", function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()
        end)
    end)

    createButton("[UNIVERSAL] WRD ESP", function()
        pcall(function()
            loadstring(game:HttpGet("https://obj.wearedevs.net/2/scripts/WRD%20ESP.lua"))()
        end)
    end)

    createButton("[UNIVERSAL] Unlock Workspace Baseparts", function()
        pcall(function()
            loadstring(game:HttpGet("https://obj.wearedevs.net/2/scripts/Unlock%20Workspace%20Baseparts.lua"))()
        end)
    end)

    createButton("[UNIVERSAL] UNC Checker", function()
        pcall(function()
            loadstring(game:HttpGet("https://obj.wearedevs.net/2/scripts/UNC%20Checker.lua"))()
        end)
    end)

    createButton("[FORSAKEN] Fartsaken", function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/FroxyCreates1/Team-40Fr0xx-Hub/refs/heads/main/Fartsaken"))()
        end)
    end)

    createButton("[FORSAKEN] M1JT Pack", function()
        pcall(function()
            loadstring(game:HttpGet("https://pastebin.com/raw/M1JTpck1"))()
        end)
    end)

    createButton("[BF] Blox Fruits OP Script", function()
        pcall(function()
            loadstring(game:HttpGet("https://obj.wearedevs.net/196545/scripts/Blox%20Fruits%20OP%20Script.lua"))()
        end)
    end)

    createButton("[FORSAKEN] Forsaken Script 2", function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/OhhMyGehlee/sak/refs/heads/main/for"))()
        end)
    end)

    createButton("[UNIVERSAL] Click TP", function()
        pcall(function()
            loadstring(game:HttpGet("https://obj.wearedevs.net/2/scripts/Click%20Teleport.lua"))()
        end)
    end)

    createButton("[FORSAKEN] YARHM", function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/FroxyCreates1/Team-40Fr0xx-Hub/refs/heads/main/YARHM.lua"))()
        end)
    end)

    createButton("[UNIVERSAL] ANTI-AFK", function()
        pcall(function()
            loadstring(game:HttpGet("https://obj.wearedevs.net/2/scripts/Focus%20Anti-AFK.lua"))()
        end)
    end)

    createButton("[UNIVERSAL] KaterHub", function()
        pcall(function()
            loadstring(game:HttpGet("https://katerhub-inc.github.io/KaterHub/main.lua"))()
        end)
    end)

    createButton("[UNIVERSAL - OP] VOID", function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/gurtfella39921/void/main/actual/VoidNew.lua"))()
        end)
    end)

    createButton("[FORSAKEN] GOONSAKEN SCRIPT", function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/NumanTF3/Goonsaken-Hub/refs/heads/main/main.lua"))()
        end)
    end)

    createButton("[UNIVERSAL] Punch Tool", function()
        pcall(function()
            loadstring(game:HttpGet("https://pastebin.com/raw/1LHtJcjF"))()
        end)
    end)

    createButton("[FLING PEOPLE AND THINGS] FTAP", function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/BlizTBr/scripts/refs/heads/main/FTAP.lua"))()
        end)
    end)

    createButton("[UNIVERSAL - OP] NAMELESS ADMIN", function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/Source"))()
        end)
    end)

    createButton("[UNIVERSAL] ESP V2", function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/FroxyCreates1/Team-40Fr0xx-Hub/refs/heads/main/ESP.lua"))()
        end)
    end)

    createButton("[UNIVERSAL (PRESS X OR Z)] FLIP", function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/FroxyCreates1/Team-40Fr0xx-Hub/refs/heads/main/Flip.lua"))()
        end)
    end)

    createButton("[UNIVERSAL] FRONT FLIP", function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/FroxyCreates1/Team-40Fr0xx-Hub/refs/heads/main/frontflip.lua"))()
        end)
    end)

    createButton("[UNIVERSAL] SIMPLE LUHH", function()
        pcall(function()
            loadstring(game:HttpGet("https://gist.githubusercontent.com/MMcmarc-sudo/7222c2a092c8a63a734b0d3a313fa731/raw"))()
        end)
    end)

    createButton("[FORSAKEN] FORSAKEN IO CHAMS", function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/FroxyCreates1/Team-40Fr0xx-Hub/refs/heads/main/Forsakeniochams.lua"))()
        end)
    end)

    createButton("[UNIVERSAL] GHOST HUB", function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostPlayer352/Test4/main/GhostHub"))()
        end)
    end)

    createButton("[ANTI-CHEAT REMOVER] ANTI-ANTI CHEAT", function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Steve-Bloks/adonis/refs/heads/main/adonisdisabler.lua"))()
        end)
    end)

    createButton("[UNIVERSAL] Forsakation Hub", function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/CyberNinja103/brodwa/refs/heads/main/ForsakationHub"))()
        end)
    end)

    createButton("[SLAP BATTLES] Flowers Ability", function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Umbrella-Scripter/Slap-Battles/refs/heads/main/F.L.O.W.E.R.lua"))()
        end)
    end)

    createButton("[TEST] GANGNAM STYLE", function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/FroxyCreates1/Team-40Fr0xx-Hub/refs/heads/main/GangnumStyle.lua"))()
        end)
    end)

    createButton("[UNIVERSAL] C00LKIDD CLOTHING", function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/FroxyCreates1/Team-40Fr0xx-Hub/refs/heads/main/c00lkiddOutfit.lua"))()
        end)
    end)

    createButton("[UNIVERSAL] Spidermode", function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/FroxyCreates1/Team-40Fr0xx-Hub/refs/heads/main/SpiderMode.lua"))()
        end)
    end)

    createButton("[STEAL A BRAINROTT] SAB Hub thing", function()
        pcall(function()
            loadstring(game:HttpGet("https://pastefy.app/2KSAeZ3G/raw"))()
        end)
    end)

 
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
            if humanoid and humanoid.Parent then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end)

    
    toggleUI(true)
end

if not keyEntered then
    createKeySystem(function()
        createUI()
        player.CharacterAdded:Connect(function()
            task.wait(0.1)
            createUI()
        end)
    end)
else
    createUI()
    player.CharacterAdded:Connect(function()
        task.wait(0.1)
        createUI()
    end)
end
