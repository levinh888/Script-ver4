-- // Cấu hình cơ bản
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Tự cập nhật khi nhân vật respawn
LocalPlayer.CharacterAdded:Connect(function(char)
	Character = char
	HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
end)

-- // Tạo ScreenGui
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "AutoCombatUI"

-- // Nút mở menu
local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 100, 0, 30)
OpenBtn.Position = UDim2.new(0, 20, 0.5, -100)
OpenBtn.Text = "🛠 MỞ MENU"
OpenBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
OpenBtn.TextColor3 = Color3.new(1, 1, 1)
OpenBtn.Font = Enum.Font.Gotham
OpenBtn.TextSize = 14

-- // Khung chính menu
local Frame = Instance.new("Frame", ScreenGui)
Frame.Position = UDim2.new(0.7, 0, 0.4, 0)
Frame.Size = UDim2.new(0, 220, 0, 160)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
Frame.BorderSizePixel = 0
Frame.BackgroundTransparency = 0.1
Frame.Visible = false

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", Frame)
title.Text = "✨ MENU AUTO ✨"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 0)
title.Font = Enum.Font.GothamBlack
title.TextSize = 20

local ToggleAutoAttack = Instance.new("TextButton", Frame)
ToggleAutoAttack.Text = "Tự đánh khi cầm vũ khí"
ToggleAutoAttack.Size = UDim2.new(1, -20, 0, 30)
ToggleAutoAttack.Position = UDim2.new(0, 10, 0, 40)
ToggleAutoAttack.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
ToggleAutoAttack.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleAutoAttack.Font = Enum.Font.Gotham
ToggleAutoAttack.TextSize = 14

local ToggleBossAttack = Instance.new("TextButton", Frame)
ToggleBossAttack.Text = "Quay vòng quanh NPC gần"
ToggleBossAttack.Size = UDim2.new(1, -20, 0, 30)
ToggleBossAttack.Position = UDim2.new(0, 10, 0, 80)
ToggleBossAttack.BackgroundColor3 = Color3.fromRGB(70, 50, 80)
ToggleBossAttack.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBossAttack.Font = Enum.Font.Gotham
ToggleBossAttack.TextSize = 14

local CloseBtn = Instance.new("TextButton", Frame)
CloseBtn.Text = "X"
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16

-- // Biến điều khiển
local rotating = false
local attacking = false
local bossTarget = nil

-- // Tìm NPC gần nhất
local function getNearestNPC(radius)
	local closest, distance = nil, radius
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") and obj ~= Character then
			local dist = (HumanoidRootPart.Position - obj.HumanoidRootPart.Position).Magnitude
			if dist < distance then
				closest = obj
				distance = dist
			end
		end
	end
	return closest
end

-- // Quay vòng quanh NPC với speed 50 và radius 23
local speed = 50
local radius = 23

RunService.RenderStepped:Connect(function(dt)
	if rotating and bossTarget and bossTarget:FindFirstChild("HumanoidRootPart") then
		local npcPos = bossTarget.HumanoidRootPart.Position
		local time = tick() * speed

		local x = math.cos(time) * radius
		local z = math.sin(time) * radius
		local targetPos = npcPos + Vector3.new(x, 0, z)

		HumanoidRootPart.CFrame = CFrame.new(targetPos, npcPos)
	end
end)

-- // Auto attack nếu cầm tool
task.spawn(function()
	while true do
		wait(0.2)
		if attacking then
			local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
			if tool then
				pcall(function()
					tool:Activate()
				end)
			end
		end
	end
end)

-- // Nút bật/tắt quay quanh NPC
ToggleBossAttack.MouseButton1Click:Connect(function()
	rotating = not rotating
	if rotating then
		bossTarget = getNearestNPC(100)
		if bossTarget then
			ToggleBossAttack.Text = "Đang quay quanh NPC..."
		else
			ToggleBossAttack.Text = "Không tìm thấy NPC"
			rotating = false
		end
	else
		ToggleBossAttack.Text = "Quay vòng quanh NPC gần"
		bossTarget = nil
	end
end)

-- // Nút bật/tắt auto attack
ToggleAutoAttack.MouseButton1Click:Connect(function()
	attacking = not attacking
	ToggleAutoAttack.Text = attacking and "Đang tự đánh..." or "Tự đánh khi cầm vũ khí"
end)

-- // Nút đóng menu
CloseBtn.MouseButton1Click:Connect(function()
	Frame.Visible = false
end)

-- // Nút mở menu
OpenBtn.MouseButton1Click:Connect(function()
	Frame.Visible = not Frame.Visible
end)