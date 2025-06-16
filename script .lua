-- SCRIPT VER4 CDVN 💥
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.Position = UDim2.new(0.3, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 450, 0, 300)
Frame.Active = true
Frame.Draggable = true

local TopBar = Instance.new("TextLabel", Frame)
TopBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.Font = Enum.Font.GothamBold
TopBar.Text = "SCRIPT VER4 CDVN 💥"
TopBar.TextColor3 = Color3.fromRGB(255, 255, 255)
TopBar.TextSize = 20

local CloseButton = Instance.new("TextButton", Frame)
CloseButton.Text = "X"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.Font = Enum.Font.Gotham
CloseButton.TextSize = 18
CloseButton.TextColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
CloseButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Panel Setup
local LeftPanel = Instance.new("Frame", Frame)
LeftPanel.Position = UDim2.new(0, 0, 0, 40)
LeftPanel.Size = UDim2.new(0, 150, 1, -40)
LeftPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

local BossButton = Instance.new("TextButton", LeftPanel)
BossButton.Size = UDim2.new(1, 0, 0, 50)
BossButton.Text = "CHỨC NĂNG ĐÁNH BOSS"
BossButton.Font = Enum.Font.Gotham
BossButton.TextSize = 13
BossButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BossButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local PvPButton = Instance.new("TextButton", LeftPanel)
PvPButton.Position = UDim2.new(0, 0, 0, 60)
PvPButton.Size = UDim2.new(1, 0, 0, 50)
PvPButton.Text = "PVP CDVN"
PvPButton.Font = Enum.Font.Gotham
PvPButton.TextSize = 13
PvPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
PvPButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local RightPanel = Instance.new("Frame", Frame)
RightPanel.Position = UDim2.new(0, 150, 0, 40)
RightPanel.Size = UDim2.new(1, -150, 1, -40)
RightPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

-- Right Buttons
local FramBossBtn = Instance.new("TextButton", RightPanel)
FramBossBtn.Size = UDim2.new(1, -20, 0, 40)
FramBossBtn.Position = UDim2.new(0, 10, 0, 10)
FramBossBtn.Text = "FRAM BOSS CDVN"
FramBossBtn.Font = Enum.Font.GothamBold
FramBossBtn.TextSize = 13
FramBossBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FramBossBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
FramBossBtn.Visible = false

local AutoHit = Instance.new("TextButton", RightPanel)
AutoHit.Size = UDim2.new(1, -20, 0, 40)
AutoHit.Position = UDim2.new(0, 10, 0, 60)
AutoHit.Text = "TỰ ĐỘNG ĐÁNH KHI CẦM VŨ KHÍ"
AutoHit.Font = Enum.Font.Gotham
AutoHit.TextSize = 12
AutoHit.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoHit.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
AutoHit.Visible = false

local SpeedHit = Instance.new("TextButton", RightPanel)
SpeedHit.Size = UDim2.new(1, -20, 0, 40)
SpeedHit.Position = UDim2.new(0, 10, 0, 110)
SpeedHit.Text = "[ĐÁNH NHANH - SPEED TAY]"
SpeedHit.Font = Enum.Font.Gotham
SpeedHit.TextSize = 12
SpeedHit.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedHit.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
SpeedHit.Visible = false

local HitboxBtn = Instance.new("TextButton", RightPanel)
HitboxBtn.Size = UDim2.new(1, -20, 0, 40)
HitboxBtn.Position = UDim2.new(0, 10, 0, 160)
HitboxBtn.Text = "BẬT HITBOX"
HitboxBtn.Font = Enum.Font.Gotham
HitboxBtn.TextSize = 12
HitboxBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HitboxBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
HitboxBtn.Visible = false

-- Switch menu
BossButton.MouseButton1Click:Connect(function()
    FramBossBtn.Visible = true
    AutoHit.Visible = false
    SpeedHit.Visible = false
    HitboxBtn.Visible = false
end)

PvPButton.MouseButton1Click:Connect(function()
    FramBossBtn.Visible = false
    AutoHit.Visible = true
    SpeedHit.Visible = true
    HitboxBtn.Visible = true
end)

-- Functional Scripts
FramBossBtn.MouseButton1Click:Connect(function()
    local speed = 30
    while FramBossBtn.Text == "FRAM BOSS CDVN" do
        task.wait()
        for _, npc in pairs(workspace:GetDescendants()) do
            if npc:FindFirstChild("Humanoid") and npc ~= Character then
                Character:MoveTo(npc.Position + Vector3.new(3,0,0))
            end
        end
    end
end)

AutoHit.MouseButton1Click:Connect(function()
    local tool = Character:FindFirstChildOfClass("Tool")
    if tool then
        local humanoid = Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:EquipTool(tool)
            while AutoHit.Text == "TỰ ĐỘNG ĐÁNH KHI CẦM VŨ KHÍ" do
                task.wait(0.3)
                tool:Activate()
            end
        end
    end
end)

SpeedHit.MouseButton1Click:Connect(function()
    local humanoid = Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = 100
    end
end)

HitboxBtn.MouseButton1Click:Connect(function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            for _, part in pairs(plr.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Size = Vector3.new(5, 5, 5)
                    part.Transparency = 0.6
                    part.Material = Enum.Material.ForceField
                end
            end
        end
    end
end)