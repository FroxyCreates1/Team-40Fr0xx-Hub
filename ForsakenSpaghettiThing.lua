local killer = game.Workspace.Players.Killers:GetChildren()[1]
local localplayer = game.Players.LocalPlayer
local wsmultiplier = 1
 
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Forsaken Script", "DarkTheme")
 
local PlayerTab = Window:NewTab("Player")
local Speed = PlayerTab:NewSection("Speed")
 
local minimum = 12
local noslow = false
 
Speed:NewToggle("No Slow / Stun", "Makes you immune to being slowed down/stunned", function(state)
    if state then
        noslow = true
    else
        noslow = false
    end
end)
 
localplayer.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
    if noslow == true and localplayer.Character.Humanoid.WalkSpeed < minimum then
        localplayer.Character.Humanoid.WalkSpeed = minimum
    end
end)
 
localplayer.CharacterAdded:Connect(function()
    localplayer.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        if noslow == true and localplayer.Character.Humanoid.WalkSpeed < minimum then
            localplayer.Character.Humanoid.WalkSpeed = minimum
        end
    end)
end)
 
Speed:NewSlider("Minimum Slow", "Sets the minimum No Slow speed", 20, 12, function(s) -- 500 (MaxValue) | 0 (MinValue)
    minimum = s
end)
 
local survivorchams = false
local survivoremit = false
local killerchams = false
local killeremit = false
 
game.Workspace.Players.Killers.ChildAdded:Connect(function(child)
    if killerchams == false then return end
 
    local hl = Instance.new("Highlight")
    hl.Parent = child
    hl.DepthMode = "AlwaysOnTop"
    hl.FillColor = Color3.fromRGB(255, 0, 0)
end)
 
 
-- Handle Survivor ESP
game.Workspace.Players.Survivors.ChildAdded:Connect(function(child)
    if survivorchams == false then return end
 
    local existingHL = child:FindFirstChild("SurvivorHL")
    if existingHL then
        existingHL:Destroy()
    end
 
    local hl = Instance.new("Highlight")
    hl.Name = "SurvivorHL"
    hl.Parent = child
    hl.DepthMode = "AlwaysOnTop"
    hl.FillColor = Color3.fromRGB(0, 255, 0)
    hl.FillTransparency = 0.9
end)
 
 
local EspTab = Window:NewTab("ESP")
local Killer = EspTab:NewSection("Killer")
 
Killer:NewToggle("Killer Chams", "ToggleInfo", function(state)
    if state then
        killerchams = true
 
        killer = game.Workspace.Players.Killers:GetChildren()[1]
 
        if killer then
            local hl = Instance.new("Highlight")
            hl.Name = "Chams"
            hl.Parent = killer
            hl.DepthMode = "AlwaysOnTop"
            hl.FillColor = Color3.new(255, 0, 0)
        end
        
        print("Killer Chams On")
    else
        killerchams = false
 
        if killer then
            local highlight = killer:FindFirstChildOfClass("Highlight")
            if highlight then
                highlight:Destroy()
            end
        end
        
        print("Killer Chams Off")
    end
end)
 
local Survivors = EspTab:NewSection("Survivors")
 
-- Survivor Chams Toggle
Survivors:NewToggle("Survivor Chams", "ToggleInfo", function(state)
    survivorchams = state
 
    if state then
        for i, survivor in ipairs(game.Workspace.Players.Survivors:GetChildren()) do
            local existingHL = survivor:FindFirstChild("SurvivorHL")
            if existingHL then existingHL:Destroy() end
 
            local hl = Instance.new("Highlight")
            hl.Name = "SurvivorHL"
            hl.Parent = survivor
            hl.DepthMode = "AlwaysOnTop"
            hl.FillColor = Color3.fromRGB(0, 255, 0)
            hl.FillTransparency = 0.9
            print(i, survivor.Name)
        end
    else
        for i, survivor in ipairs(game.Workspace.Players.Survivors:GetChildren()) do
            local hl = survivor:FindFirstChild("SurvivorHL")
            if hl then
                hl:Destroy()
            end
        end
        print("Survivor Chams Off")
    end
end)
 
local Map = EspTab:NewSection("Map")
 
 
Map:NewButton("Show Generators", "ButtonInfo", function()
    for i, generator in ipairs(workspace.Map.Ingame.Map:GetChildren()) do
        if generator.Name == "Generator" then
            local hl = Instance.new("Highlight", generator)
        end
    end
end)
 
Map:NewButton("Show Items", "ButtonInfo", function()
    for i, tool in ipairs(workspace.Map.Ingame:GetChildren()) do
        if tool:IsA("Tool") then
            local hl = Instance.new("Highlight", tool)
        end
    end
end)
 
local OtherTab = Window:NewTab("Other")
local Lighting = OtherTab:NewSection("Lighting")
 
Lighting:NewToggle("No Fog", "Disables fog", function(state)
    if state then
        game.Lighting.Atmosphere.Density = 0
    else
        game.Lighting.Atmosphere.Density = .6
    end
end)
