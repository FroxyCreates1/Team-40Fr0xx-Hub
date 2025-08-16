local TweenService = game:GetService("TweenService")
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()

    -- Helper function to tween Motor6D joints
    local function tweenJoint(joint, goalC0, time)
        local tween = TweenService:Create(joint, TweenInfo.new(time, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {C0 = goalC0})
        tween:Play()
        return tween
    end

    -- Ensure R6 joints exist
    local torso = char:FindFirstChild("Torso")
    if not torso then return end
    local humanoid = char:FindFirstChild("Humanoid")
    if not humanoid then return end

    local rightHip = torso:FindFirstChild("Right Hip")
    local leftHip = torso:FindFirstChild("Left Hip")
    local rightShoulder = torso:FindFirstChild("Right Shoulder")
    local leftShoulder = torso:FindFirstChild("Left Shoulder")
    local neck = torso:FindFirstChild("Neck")

    if not (rightHip and leftHip and rightShoulder and leftShoulder and neck) then return end

    -- Freeze player in place
    humanoid:ChangeState(Enum.HumanoidStateType.Physics)

    local runAnim = true
    task.spawn(function()
        local elapsed = 0
        while runAnim and elapsed < 10 do
            -- Step 1: Arms crossed (Gangnam Style signature pose)
            tweenJoint(rightShoulder, CFrame.new(1, 0.5, 0) * CFrame.Angles(math.rad(-90), math.rad(30), math.rad(20)), 0.2)
            tweenJoint(leftShoulder, CFrame.new(-1, 0.5, 0) * CFrame.Angles(math.rad(-90), math.rad(-30), math.rad(-20)), 0.2)

            -- Step 1 legs: right forward, left back
            tweenJoint(rightHip, CFrame.new(1, -1, 0) * CFrame.Angles(math.rad(10), 0, math.rad(15)), 0.2)
            tweenJoint(leftHip, CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(-10), 0, math.rad(-15)), 0.2)

            -- Torso bounce up
            torso.CFrame = torso.CFrame * CFrame.new(0, 0.2, 0)
            task.wait(0.2)

            -- Step 2: Swap legs (like riding a horse)
            tweenJoint(rightHip, CFrame.new(1, -1, 0) * CFrame.Angles(math.rad(-10), 0, math.rad(-15)), 0.2)
            tweenJoint(leftHip, CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(10), 0, math.rad(15)), 0.2)

            -- Torso bounce down
            torso.CFrame = torso.CFrame * CFrame.new(0, -0.2, 0)
            task.wait(0.2)

            elapsed += 0.4
        end

        -- Restore control
        humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
    end)
end)
