    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local humanoid = char:WaitForChild("Humanoid")

    local spidermanActive = true

    local rayParams = RaycastParams.new()
    rayParams.FilterDescendantsInstances = {char}
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist

    -- Loop to stick to walls
    task.spawn(function()
        while spidermanActive do
            local rayOrigin = hrp.Position
            local rayDir = hrp.CFrame.LookVector * 4 -- Check in front
            local result = workspace:Raycast(rayOrigin, rayDir, rayParams)

            if result and result.Instance and humanoid.MoveDirection.Magnitude > 0 then
                local normal = result.Normal
                -- Align HRP "up" with wall normal
                local forward = hrp.CFrame.LookVector
                local right = forward:Cross(normal).Unit
                forward = normal:Cross(right).Unit
                local newCFrame = CFrame.fromMatrix(result.Position + normal * 2, right, normal)
                hrp.CFrame = hrp.CFrame:Lerp(newCFrame, 0.25)
            end

            task.wait(0.05)
        end
    end)

    -- Turn off after 15 seconds (safety)
    task.delay(15, function()
        spidermanActive = false
    end)
end)
