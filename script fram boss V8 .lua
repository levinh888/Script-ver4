-- ✅ WOKINGLOG UI 👹 PRO EDITION
-- Tác giả: ChatGPT x Vinh WOKINGLOG
-- Giao diện cực đẹp, Fly quanh boss, PvP, hiệu ứng + âm thanh

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HRP = Character:WaitForChild("HumanoidRootPart")

-- 📦 GUI ROOT
local screenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
screenGui.Name = "WOKINGLOG_UI"
screenGui.ResetOnSpawn = false

-- 🔊 Sound bật menu
local openSound = Instance.new("Sound", screenGui)
openSound.SoundId = "rbxassetid://9118823104" -- âm thanh bật UI
openSound.Volume = 2

-- 👹 Toggle Button
local toggleButton = Instance.new("ImageButton", screenGui)
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0, 15, 0.5, -150)
toggleButton.BackgroundTransparency = 1
toggleButton.Image = "rbxassetid://7733960981" -- icon mặt quỷ

-- 🧱 Main Frame
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 450, 0, 400)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false

local mainCorner = Instance.new("UICorner", mainFrame)
mainCorner.CornerRadius = UDim.new(0, 12)

local uiStroke = Instance.new("UIStroke", mainFrame)
uiStroke.Thickness = 2
uiStroke.Color = Color3.fromRGB(200, 0, 0)

-- 🟥 Top Bar
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, -40, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = "👹 WOKINGLOG UI PRO"
title.TextColor3 = Color3.fromRGB(255, 80, 80)
title.Font = Enum.Font.GothamBold
title.TextSize = 20

-- ❌ Close Button
local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "✖"
closeBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16

local closeCorner = Instance.new("UICorner", closeBtn)
closeCorner.CornerRadius = UDim.new(1, 0)

-- 🔁 Tab system
local tabFrame = Instance.new("Frame", mainFrame)
tabFrame.Size = UDim2.new(0, 100, 1, -40)
tabFrame.Position = UDim2.new(0, 0, 0, 40)
tabFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(1, -100, 1, -40)
contentFrame.Position = UDim2.new(0, 100, 0, 40)
contentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

local tabs = {}
local function createTab(name)
    local btn = Instance.new("TextButton", tabFrame)
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14

    local tab = Instance.new("Frame", contentFrame)
    tab.Size = UDim2.new(1, 0, 1, 0)
    tab.BackgroundTransparency = 1
    tab.Visible = false

    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    end)

    btn.MouseButton1Click:Connect(function()
        for _, v in pairs(tabs) do v.Frame.Visible = false end
        tab.Visible = true
    end)

    table.insert(tabs, {Button = btn, Frame = tab})
    return tab
end

-- 💥 Toggle visibility
local function toggleUI()
    mainFrame.Visible = not mainFrame.Visible
    if mainFrame.Visible then openSound:Play() end
end

toggleButton.MouseButton1Click:Connect(toggleUI)
closeBtn.MouseButton1Click:Connect(toggleUI)

-- 🎹 Phím L để mở/tắt
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.L then
        toggleUI()
    end
end)

-- 🔧 Create Tabs
local framTab = createTab("Fram Boss")
local pvpTab = createTab("PvP")
framTab.Visible = true

-- 📌 Add Buttons Utility
local function addButton(parent, text, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.9, 0, 0, 30)
    btn.Position = UDim2.new(0.05, 0, 0, #parent:GetChildren() * 35)
    btn.BackgroundColor3 = Color3.fromRGB(70, 0, 0)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.Text = text
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(70, 0, 0)
    end)
    btn.MouseButton1Click:Connect(callback)
end

-- 🔥 Fram Boss tab
addButton(framTab, "Bật Fram Boss", function()
    local npc
    local function getNearestNPC()
        local nearest, dist = nil, math.huge
        for _, model in pairs(workspace:GetDescendants()) do
            if model:IsA("Model") and model:FindFirstChild("HumanoidRootPart") and model:FindFirstChildOfClass("Humanoid") and model ~= Character then
                local d = (HRP.Position - model.HumanoidRootPart.Position).Magnitude
                if d < dist then
                    dist = d
                    nearest = model
                end
            end
        end
        return nearest
    end

    npc = getNearestNPC()
    if not npc then warn("Không tìm thấy NPC") return end

    local hpText = Instance.new("TextLabel", screenGui)
    hpText.Size = UDim2.new(0.3, 0, 0.03, 0)
    hpText.Position = UDim2.new(0.35, 0, 0.05, 0)
    hpText.TextColor3 = Color3.new(1,1,1)
    hpText.BackgroundTransparency = 1
    hpText.TextScaled = true
    hpText.Font = Enum.Font.GothamBold

    local angle = 0
    RunService.RenderStepped:Connect(function()
        if npc and npc:FindFirstChild("HumanoidRootPart") then
            angle += 0.05
            local radius = 23
            local target = npc.HumanoidRootPart.Position + Vector3.new(math.cos(angle)*radius, 0, math.sin(angle)*radius)
            HRP.CFrame = CFrame.new(target, npc.HumanoidRootPart.Position)

            local hum = npc:FindFirstChildOfClass("Humanoid")
            if hum then
                hpText.Text = string.format("👹 %s | HP: %.0f / %.0f", npc.Name, hum.Health, hum.MaxHealth)
            end
        end
    end)

    task.spawn(function()
        while true do
            if Humanoid and Humanoid.Health > 0 then
                Humanoid.Jump = true
                local tool = Character:FindFirstChildOfClass("Tool")
                if tool then pcall(function() tool:Activate() end) end
            end
            task.wait(1.5)
        end
    end)
end)

-- ⚔️ PvP Tab
addButton(pvpTab, "Đánh nhanh", function()
    task.spawn(function()
        while true do
            local tool = Character:FindFirstChildOfClass("Tool")
            if tool then
                for _ = 1, 8 do
                    pcall(function() tool:Activate() end)
                end
            end
            task.wait(0.1)
        end
    end)
end)

addButton(pvpTab, "Tự đánh khi cầm vũ khí", function()
    task.spawn(function()
        while true do
            local tool = Character:FindFirstChildOfClass("Tool")
            if tool then pcall(function() tool:Activate() end) end
            task.wait(0.4)
        end
    end)
end)

addButton(pvpTab, "Hiện Hitbox vũ khí", function()
    local tool = Character:FindFirstChildOfClass("Tool")
    if tool then
        local part = tool:FindFirstChildWhichIsA("BasePart")
        if part then
            local box = Instance.new("SelectionBox", part)
            box.Adornee = part
            box.LineThickness = 0.05
            box.SurfaceTransparency = 0.4
            box.Color3 = Color3.fromRGB(255, 0, 0)
        end
    end
end)

addButton(pvpTab, "Tự gửi /report", function()
    StarterGui:SetCore("ChatMakeSystemMessage", { Text = "/report"; Color = Color3.fromRGB(255,255,0); })
end)

addButton(pvpTab, "Thoát Game", function()
    LocalPlayer:Kick("WOKINGLOG: Auto logout")
end)
