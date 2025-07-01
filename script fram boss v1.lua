--// Dịch vụ Roblox
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = Character:WaitForChild("HumanoidRootPart")

--// Cấu hình quay
local radius = 23
local speed = math.rad(50) -- 50 độ/s
local angle = 0
local selectedBoss = nil

--// GUI đơn giản chọn boss
local screenGui = Instance.new("ScreenGui", game.CoreGui)
local dropdown = Instance.new("Frame", screenGui)
dropdown.Size = UDim2.new(0, 200, 0, 250)
dropdown.Position = UDim2.new(0, 10, 0, 100)
dropdown.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
dropdown.BorderSizePixel = 0

local label = Instance.new("TextLabel", dropdown)
label.Size = UDim2.new(1, 0, 0, 30)
label.Text = "🔍 Chọn Boss"
label.TextColor3 = Color3.new(1,1,1)
label.BackgroundColor3 = Color3.fromRGB(60,60,60)
label.BorderSizePixel = 0

--// Danh sách nút boss
local function updateBossList()
    for _, v in pairs(dropdown:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end

    local y = 35
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
            local btn = Instance.new("TextButton", dropdown)
            btn.Size = UDim2.new(1, 0, 0, 25)
            btn.Position = UDim2.new(0, 0, 0, y)
            btn.Text = "🎯 " .. v.Name
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            btn.BorderSizePixel = 0
            y = y + 28

            btn.MouseButton1Click:Connect(function()
                selectedBoss = v
            end)
        end
    end
end

updateBossList()

--// Hiển thị máu Boss
local bossHpLabel = Instance.new("TextLabel", screenGui)
bossHpLabel.Size = UDim2.new(0, 300, 0, 30)
bossHpLabel.Position = UDim2.new(0.5, -150, 0, 30)
bossHpLabel.BackgroundTransparency = 0.4
bossHpLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
bossHpLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
bossHpLabel.Font = Enum.Font.GothamBold
bossHpLabel.TextSize = 20
bossHpLabel.Text = "Máu Boss: ???"
bossHpLabel.BorderSizePixel = 0

--// Quay quanh + auto attack
RunService.RenderStepped:Connect(function(dt)
    if selectedBoss and selectedBoss:FindFirstChild("HumanoidRootPart") and selectedBoss:FindFirstChild("Humanoid") then
        -- Cập nhật máu boss
        local hp = math.floor(selectedBoss.Humanoid.Health)
        local max = math.floor(selectedBoss.Humanoid.MaxHealth)
        bossHpLabel.Text = "💥 Máu Boss: " .. hp .. " / " .. max

        -- Quay quanh
        angle = angle + speed * dt
        local bossPos = selectedBoss.HumanoidRootPart.Position
        local offset = Vector3.new(math.cos(angle) * radius, 0, math.sin(angle) * radius)
        local targetPos = bossPos + offset
        HRP.CFrame = CFrame.new(targetPos, bossPos)

        -- Auto click (giả lập chuột trái)
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
    else
        bossHpLabel.Text = "⚠️ Chưa chọn Boss hoặc Boss đã chết!"
    end
end)