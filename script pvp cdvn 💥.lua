-- WOKINGLOG HUB V8 – ImpactUI + Speed Tay THẬT + Hitbox THẬT

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Load ImpactUI
local ImpactUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/NeverJar/ImpactUI/main/ImpactUI.lua"))()
local Window = ImpactUI:Create("👹 WOKINGLOG HUB", "by WOKINGLOG")

-- Tabs
local Main = Window:Tab("⚙ Main", true)
local Combat = Window:Tab("🗡 Combat")
local Visual = Window:Tab("🎨 Visual")
local Aimbot = Window:Tab("🎯 Aimbot")

-- MAIN
Main:Label("👤 Người chơi: " .. Player.Name)
Main:Label("🆔 ID: " .. Player.UserId)

-- COMBAT
local speedAnimation = false
Combat:Toggle("⚡ Speed Tay (Tăng Animation)", function(v)
    speedAnimation = v
end)

RunService.Heartbeat:Connect(function()
    if speedAnimation then
        local char = Player.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            local animator = humanoid:FindFirstChildWhichIsA("Animator")
            if animator then
                for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
                    track:AdjustSpeed(100) -- Tốc độ animation x100
                end
            end
        end
    end
end)

-- AUTO EQUIP
Combat:Button("🧠 Auto Equip Tool", function()
    local tool = Player.Backpack:FindFirstChildOfClass("Tool")
    if tool then tool.Parent = Player.Character end
end)

-- HITBOX THẬT
local hitboxReal = false
Combat:Toggle("📏 Hitbox THẬT (13,13,13)", function(v)
    hitboxReal = v
end)

RunService.RenderStepped:Connect(function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local part = plr.Character.HumanoidRootPart
            if hitboxReal then
                part.Size = Vector3.new(13, 13, 13)
                part.Transparency = 0.85
                part.Material = Enum.Material.ForceField
                part.CanCollide = false
            else
                part.Size = Vector3.new(2, 2, 1)
                part.Transparency = 1
                part.Material = Enum.Material.Plastic
            end
        end
    end
end)

-- VISUAL
Visual:Button("🪫 Giảm 30% Đồ Hoạ", function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.Plastic
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v.Transparency = 0.1
        end
    end
end)

-- AIMBOT
local aim = false
Aimbot:Toggle("🎯 Aim Nhẹ (Camera)", function(v)
    aim = v
end)

RunService.RenderStepped:Connect(function()
    if aim then
        local cam = workspace.CurrentCamera
        local closest, dist = nil, math.huge
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= Player and plr.Character and plr.Character:FindFirstChild("Head") then
                local pos, onScreen = cam:WorldToScreenPoint(plr.Character.Head.Position)
                if onScreen then
                    local mag = (Vector2.new(pos.X, pos.Y) - UserInputService:GetMouseLocation()).Magnitude
                    if mag < dist and mag < 150 then
                        closest = plr.Character.Head
                        dist = mag
                    end
                end
            end
        end
        if closest then
            cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, closest.Position), 0.1)
        end
    end
end)

-- ICON 👹 BẤM MỞ HUB
local icon = Instance.new("ScreenGui")
local btn = Instance.new("TextButton")
icon.Name = "WOK_Icon"
icon.Parent = game.CoreGui
btn.Parent = icon
btn.Size = UDim2.new(0, 45, 0, 45)
btn.Position = UDim2.new(0, 10, 0.5, -20)
btn.Text = "👹"
btn.TextSize = 30
btn.Font = Enum.Font.GothamBold
btn.TextColor3 = Color3.fromRGB(255, 0, 0)
btn.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
btn.BorderSizePixel = 0
btn.AutoButtonColor = true
Instance.new("UICorner", btn)

btn.MouseButton1Click:Connect(function()
    ImpactUI:Toggle()
end)

print("✅ WOKINGLOG HUB V8 – Speed tay thật + Hitbox thật")
