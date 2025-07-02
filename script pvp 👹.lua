-- WOKINGLOG 👹 V2 - FULL PVP HUB (Kéo thả + Icon + Nút đóng menu)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")

local remoteName = "Attack"
local moveSpeed = 40
local attackSpeed = 0.1

local config = {
    Spin = false,
    Speed = false,
    AutoAttack = false,
    Aim = false,
    KillAura = false,
    Hitbox = false,
    AutoDodge = false,
    AntiKB = false,
    AutoSkill = false
}

-- GUI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 300, 0, 400)
main.Position = UDim2.new(0, 10, 0, 10)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BackgroundTransparency = 0.1
main.BorderSizePixel = 0
main.Name = "WOKINGLOG"
main.Active = true
main.Draggable = true

-- Icon 👹
local icon = Instance.new("TextLabel", main)
icon.Size = UDim2.new(0, 40, 0, 40)
icon.Position = UDim2.new(0, 5, 0, 5)
icon.BackgroundTransparency = 1
icon.Text = "👹"
icon.Font = Enum.Font.GothamBlack
icon.TextScaled = true
icon.TextColor3 = Color3.fromRGB(255, 0, 0)
icon.Name = "Icon"

-- Nút đóng ❌
local close = Instance.new("TextButton", main)
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -35, 0, 5)
close.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
close.Text = "✖"
close.Font = Enum.Font.GothamBold
close.TextColor3 = Color3.new(1, 0.5, 0.5)
close.TextScaled = true
close.BorderSizePixel = 0
close.MouseButton1Click:Connect(function()
    main.Visible = false
end)

-- Tiêu đề
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, -80, 0, 40)
title.Position = UDim2.new(0, 45, 0, 0)
title.Text = "WOKINGLOG PVP HUB"
title.Font = Enum.Font.GothamBlack
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(255, 80, 80)
title.BackgroundTransparency = 1

-- Nút chức năng
local y = 50
for name, _ in pairs(config) do
    local btn = Instance.new("TextButton", main)
    btn.Size = UDim2.new(1, -20, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.Text = name .. " [OFF]"
    btn.MouseButton1Click:Connect(function()
        config[name] = not config[name]
        btn.Text = name .. (config[name] and " [ON]" or " [OFF]")
        btn.BackgroundColor3 = config[name] and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(50, 50, 50)
    end)
    y = y + 35
end

-- Di chuyển
local moveDir = Vector3.new()
UIS.InputBegan:Connect(function(i,g)
    if g then return end
    if i.KeyCode == Enum.KeyCode.W then moveDir = Vector3.new(0,0,-1) end
    if i.KeyCode == Enum.KeyCode.S then moveDir = Vector3.new(0,0,1) end
    if i.KeyCode == Enum.KeyCode.A then moveDir = Vector3.new(-1,0,0) end
    if i.KeyCode == Enum.KeyCode.D then moveDir = Vector3.new(1,0,0) end
end)
UIS.InputEnded:Connect(function(i,g)
    if g then return end
    moveDir = Vector3.new()
end)

local function isToolEquipped()
    return char:FindFirstChildOfClass("Tool") ~= nil
end

local function getClosestPlayer()
    local closest, dist = nil, math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local d = (p.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
            if d < dist then
                closest, dist = p, d
            end
        end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    if config.Spin then
        hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(35), 0)
    end

    if config.Speed and moveDir.Magnitude > 0 then
        local dir = (hrp.CFrame.RightVector * moveDir.X + hrp.CFrame.LookVector * moveDir.Z).Unit
        hrp.CFrame = hrp.CFrame + dir * moveSpeed * RunService.RenderStepped:Wait()
    end

    if config.AutoAttack and isToolEquipped() then
        local remote = ReplicatedStorage:FindFirstChild(remoteName)
        if remote and remote:IsA("RemoteEvent") then
            remote:FireServer("Attack", true)
        end
    end

    if config.Aim then
        local target = getClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local tPos = target.Character.HumanoidRootPart.Position
            hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(tPos.X, hrp.Position.Y, tPos.Z))
        end
    end

    if config.KillAura then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local d = (p.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
                if d < 15 and isToolEquipped() then
                    local remote = ReplicatedStorage:FindFirstChild(remoteName)
                    if remote then
                        remote:FireServer("Attack", true)
                    end
                end
            end
        end
    end

    if config.Hitbox then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                p.Character.HumanoidRootPart.Size = Vector3.new(12,12,12)
                p.Character.HumanoidRootPart.Transparency = 0.4
            end
        end
    end

    if config.AutoDodge then
        if isToolEquipped() then
            local offset = Vector3.new(math.random(-1,1)*5, 0, math.random(-1,1)*5)
            hrp.CFrame = hrp.CFrame + offset
            wait(0.5)
        end
    end

    if config.AntiKB then
        hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        hum.PlatformStand = false
    end

    if config.AutoSkill then
        local tool = char:FindFirstChildOfClass("Tool")
        if tool and tool:FindFirstChild("RemoteEvent") then
            tool.RemoteEvent:FireServer()
        end
    end
end)

print("✅ WOKINGLOG 👹 PvP Tool Loaded!")
