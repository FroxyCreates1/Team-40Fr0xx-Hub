local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()

    -- CHANGE THESE TO YOUR SHIRT + PANTS IDs IF U WANT
    local shirtId = "rbxassetid://16012481458" 
    local pantsId = "rbxassetid://107896578601954" 
    -- ==============================================

    -- Turn character red
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Color = Color3.fromRGB(255, 0, 0)
        end
    end

    -- Remove old clothing if it exists
    if char:FindFirstChildOfClass("Shirt") then
        char:FindFirstChildOfClass("Shirt"):Destroy()
    end
    if char:FindFirstChildOfClass("Pants") then
        char:FindFirstChildOfClass("Pants"):Destroy()
    end

    -- Add new clothing
    local shirt = Instance.new("Shirt")
    shirt.ShirtTemplate = shirtId
    shirt.Parent = char

    local pants = Instance.new("Pants")
    pants.PantsTemplate = pantsId
    pants.Parent = char
end)
