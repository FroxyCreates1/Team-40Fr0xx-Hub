local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local function applyShitStamina()
    local sprintingModule = require(game:GetService("ReplicatedStorage").Systems.Character.Game.Sprinting)
    if not sprintingModule.DefaultsSet then
        sprintingModule.Init()
    end
    sprintingModule.StaminaLoss = 10
    sprintingModule.StaminaGain = 20
    sprintingModule.MinStamina = 0
    sprintingModule.MaxStamina = 100
    sprintingModule.Stamina = 100
    sprintingModule.StaminaLossDisabled = false
    if sprintingModule.__staminaChangedEvent then
        sprintingModule.__staminaChangedEvent:Fire()
    end
end

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    applyShitStamina()
end)

RunService.RenderStepped:Wait()
applyShitStamina()
