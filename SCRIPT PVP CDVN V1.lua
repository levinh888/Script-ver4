-- WOKINGLOG 👹 FULL SCRIPT HUB V1.0 – TẠO THEO Ý ĐẠI CA
-- BẢN GỒM: MENU ĐẸP, TAB FARM BOSS, PVP, FIX LAG, FPS, FULL CHỨC NĂNG ĐÃ GỢI Ý

--// SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

--// GUI SETUP
local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "WOKINGLOG_GUI"

--// BLUR BACKGROUND
local blur = Instance.new("BlurEffect", Lighting)
blur.Size = 0
local function blurToggle(state)
    TweenService:Create(blur, TweenInfo.new(0.3), {Size = state and 10 or 0}):Play()
end

--// ICON MENU
local openBtn = Instance.new("TextButton", gui)
openBtn.Size = UDim2.new(0, 40, 0, 40)
openBtn.Position = UDim2.new(0, 10, 0, 10)
openBtn.Text = "👹"
openBtn.BackgroundColor3 = Color3.fromRGB(90, 0, 130)
openBtn.TextColor3 = Color3.new(1, 1, 1)
openBtn.Font = Enum.Font.GothamBold
openBtn.TextSize = 24

--// MAIN FRAME
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 500, 0, 350)
main.Position = UDim2.new(0.5, -250, 0.5, -175)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
main.BackgroundTransparency = 0.15
main.Visible = false
main.Active = true
main.Draggable = true

--// LOGO
local title = Instance.new("TextLabel", main)
title.Text = "⚡ WOKINGLOG 👹 SCRIPT HUB"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 0, 120)
title.Font = Enum.Font.Fantasy
title.TextSize = 24

--// TABS
local tabNames = {"Fram Boss", "PvP", "Fix Lag", "FPS"}
local tabFrames = {}
local tabBtnFrame = Instance.new("Frame", main)
tabBtnFrame.Size = UDim2.new(1, 0, 0, 30)
tabBtnFrame.Position = UDim2.new(0, 0, 0, 30)
tabBtnFrame.BackgroundTransparency = 1

for i, name in ipairs(tabNames) do
    local btn = Instance.new("TextButton", tabBtnFrame)
    btn.Size = UDim2.new(0, 120, 0, 30)
    btn.Position = UDim2.new(0, (i - 1) * 125, 0, 0)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14

    local page = Instance.new("Frame", main)
    page.Size = UDim2.new(1, -20, 1, -80)
    page.Position = UDim2.new(0, 10, 0, 70)
    page.BackgroundTransparency = 1
    page.Visible = false
    tabFrames[name] = page

    btn.MouseButton1Click:Connect(function()
        for _, f in pairs(tabFrames) do f.Visible = false end
        page.Visible = true
    end)
end

--// TOGGLE GUI
openBtn.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
    blurToggle(main.Visible)
end)

----------------------------
-- 1️⃣ TAB: Fram Boss 👹
----------------------------
local farmTab = tabFrames["Fram Boss"]

local farmOn = false
local farmBtn = Instance.new("TextButton", farmTab)
farmBtn.Text = "Fram Boss: OFF"
farmBtn.Size = UDim2.new(0, 200, 0, 30)
farmBtn.Position = UDim2.new(0, 10, 0, 10)
farmBtn.BackgroundColor3 = Color3.fromRGB(100, 150, 100)
farmBtn.MouseButton1Click:Connect(function()
    farmOn = not farmOn
    farmBtn.Text = farmOn and "Fram Boss: ON" or "Fram Boss: OFF"
end)

local function getHumanBoss()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v.Name:lower():find("human") and v:FindFirstChild("HumanoidRootPart") then
            return v
        end
    end
end

local function spinAround(target, radius, speed)
    local t = 0
    RunService.RenderStepped:Connect(function()
        if farmOn and LocalPlayer.Character and target then
            local x = math.cos(t) * radius
            local z = math.sin(t) * radius
            t += speed / 100
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(target.Position + Vector3.new(x, 3, z))
        end
    end)
end

RunService.Heartbeat:Connect(function()
    if farmOn and LocalPlayer.Character then
        local boss = getHumanBoss()
        if boss then
            local dist = (boss.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if dist > 23 then
                LocalPlayer.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
            else
                spinAround(boss.HumanoidRootPart.Position, 23, 40)
            end
        end
    end
end)

----------------------------
-- 2️⃣ TAB: PvP 👹
----------------------------
local pvpTab = tabFrames["PvP"]

-- Auto Attack
local attack = false
local atkBtn = Instance.new("TextButton", pvpTab)
atkBtn.Text = "Tự đánh: OFF"
atkBtn.Size = UDim2.new(0, 200, 0, 30)
atkBtn.Position = UDim2.new(0, 10, 0, 10)
atkBtn.BackgroundColor3 = Color3.fromRGB(150, 80, 80)
atkBtn.MouseButton1Click:Connect(function()
    attack = not attack
    atkBtn.Text = attack and "Tự đánh: ON" or "Tự đánh: OFF"
end)

-- Spin
local spinning = false
local spinBtn = Instance.new("TextButton", pvpTab)
spinBtn.Text = "Spin: OFF"
spinBtn.Size = UDim2.new(0, 200, 0, 30)
spinBtn.Position = UDim2.new(0, 10, 0, 50)
spinBtn.MouseButton1Click:Connect(function()
    spinning = not spinning
    spinBtn.Text = spinning and "Spin: ON" or "Spin: OFF"
end)

-- Auto Look at Enemy
local rotate = false
local rotBtn = Instance.new("TextButton", pvpTab)
rotBtn.Text = "Auto Quay: OFF"
rotBtn.Size = UDim2.new(0, 200, 0, 30)
rotBtn.Position = UDim2.new(0, 10, 0, 90)
rotBtn.MouseButton1Click:Connect(function()
    rotate = not rotate
    rotBtn.Text = rotate and "Auto Quay: ON" or "Auto Quay: OFF"
end)

-- Crosshair
local cross = Instance.new("Frame", gui)
cross.Size = UDim2.new(0, 4, 0, 4)
cross.Position = UDim2.new(0.5, -2, 0.5, -2)
cross.BackgroundColor3 = Color3.new(1, 0, 0)
cross.ZIndex = 1000

-- Rotation
local function getClosestEnemy()
    local closest, dist = nil, math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            local d = (p.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if d < dist then
                dist = d
                closest = p
            end
        end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    if attack and LocalPlayer.Character then
        local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if tool then tool:Activate() end
    end
    if spinning and LocalPlayer.Character then
        LocalPlayer.Character.HumanoidRootPart.CFrame *= CFrame.Angles(0, math.rad(44), 0)
    end
    if rotate and LocalPlayer.Character then
        local enemy = getClosestEnemy()
        if enemy then
            local dir = (enemy.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Unit
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.Position, LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(dir.X, 0, dir.Z))
        end
    end
end)

----------------------------
-- 3️⃣ TAB: Fix Lag
----------------------------
local fixTab = tabFrames["Fix Lag"]

local lagLevels = {
    {"Giảm lag 30%", 1},
    {"Giảm lag 50%", 2},
    {"Giảm lag 80%", 3},
}

for i, cfg in ipairs(lagLevels) do
    local btn = Instance.new("TextButton", fixTab)
    btn.Text = cfg[1]
    btn.Size = UDim2.new(0, 200, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, (i - 1) * 40 + 10)
    btn.BackgroundColor3 = Color3.fromRGB(80 + i * 40, 80, 80)
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(workspace:GetDescendants()) do
            if p:IsA("BasePart") then
                if cfg[2] == 1 then p.Material = Enum.Material.Plastic end
                if cfg[2] == 2 then p.Material = Enum.Material.SmoothPlastic p.Reflectance = 0 end
                if cfg[2] == 3 then p:Destroy() end
            end
        end
    end)
end

----------------------------
-- 4️⃣ TAB: FPS
----------------------------
local fpsTab = tabFrames["FPS"]
local fpsBtn = Instance.new("TextButton", fpsTab)
fpsBtn.Text = "Tối ưu FPS"
fpsBtn.Size = UDim2.new(0, 200, 0, 30)
fpsBtn.Position = UDim2.new(0, 10, 0, 10)
fpsBtn.BackgroundColor3 = Color3.fromRGB(100, 120, 200)
fpsBtn.MouseButton1Click:Connect(function()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
end)

print("✅ WOKINGLOG 👹 SCRIPT HUB đã khởi động hoàn tất!")
