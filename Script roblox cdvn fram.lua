-- 📌 Script by Vinh | Quay quanh NPC2 + hướng mặt về mục tiêu (CÓ LƯU QUỸ ĐẠO + TỐC ĐỘ NHANH HƠN)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = Character:WaitForChild("HumanoidRootPart")

LocalPlayer.CharacterAdded:Connect(function(char)
	Character = char
	HRP = char:WaitForChild("HumanoidRootPart")
end)

-- GUI nhập key
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "KeyGUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 160)
frame.Position = UDim2.new(0.5, -150, 0.5, -80)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
frame.BorderSizePixel = 0

local label = Instance.new("TextLabel", frame)
label.Size = UDim2.new(1, 0, 0, 30)
label.Text = "🔐 Nhập Key để mở GUI"
label.TextColor3 = Color3.new(1,1,1)
label.BackgroundTransparency = 1
label.Font = Enum.Font.GothamBold
label.TextSize = 16

local textbox = Instance.new("TextBox", frame)
textbox.Size = UDim2.new(1, -40, 0, 30)
textbox.Position = UDim2.new(0, 20, 0, 50)
textbox.PlaceholderText = "Nhập key tại đây..."
textbox.TextColor3 = Color3.new(1,1,1)
textbox.BackgroundColor3 = Color3.fromRGB(45, 45, 70)
textbox.Font = Enum.Font.Gotham
textbox.TextSize = 14

local confirm = Instance.new("TextButton", frame)
confirm.Size = UDim2.new(1, -40, 0, 30)
confirm.Position = UDim2.new(0, 20, 0, 100)
confirm.Text = "✅ Xác nhận"
confirm.BackgroundColor3 = Color3.fromRGB(60, 120, 60)
confirm.TextColor3 = Color3.new(1,1,1)
confirm.Font = Enum.Font.GothamBold
confirm.TextSize = 14

-- GUI quay quanh boss
local gui2 = Instance.new("ScreenGui")
gui2.Name = "CircleRotateGUI"
gui2.Enabled = false

local startBtn = Instance.new("TextButton", gui2)
startBtn.Size = UDim2.new(0, 200, 0, 40)
startBtn.Position = UDim2.new(0, 20, 0.5, -100)
startBtn.Text = "▶️ Quay Vòng Tròn"
startBtn.BackgroundColor3 = Color3.fromRGB(50, 70, 120)
startBtn.TextColor3 = Color3.new(1, 1, 1)
startBtn.Font = Enum.Font.GothamBold
startBtn.TextSize = 14

local speedInput = Instance.new("TextBox", gui2)
speedInput.Size = UDim2.new(0, 200, 0, 30)
speedInput.Position = UDim2.new(0, 20, 0.5, -60)
speedInput.Text = "6"
speedInput.PlaceholderText = "Tốc độ góc (rad/s)"
speedInput.TextColor3 = Color3.new(1, 1, 1)
speedInput.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
speedInput.ClearTextOnFocus = false

local radiusInput = Instance.new("TextBox", gui2)
radiusInput.Size = UDim2.new(0, 200, 0, 30)
radiusInput.Position = UDim2.new(0, 20, 0.5, -20)
radiusInput.Text = "18"
radiusInput.PlaceholderText = "Bán kính quay"
radiusInput.TextColor3 = Color3.new(1, 1, 1)
radiusInput.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
radiusInput.ClearTextOnFocus = false

local hpLabel = Instance.new("TextLabel", gui2)
hpLabel.Size = UDim2.new(0, 220, 0, 30)
hpLabel.Position = UDim2.new(1, -240, 0, 20)
hpLabel.AnchorPoint = Vector2.new(0, 0)
hpLabel.Text = "Máu Boss: Đang tìm..."
hpLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
hpLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
hpLabel.Font = Enum.Font.GothamBold
hpLabel.TextSize = 14
hpLabel.TextXAlignment = Enum.TextXAlignment.Left
hpLabel.BorderSizePixel = 0

-- Quay quanh boss
local BossName = "NPC2"
local pathPoints = {}
local pathIndex = 1
local isOrbiting = false
local lastSwing = 0
local swingDelay = 0.3

local function getBoss()
	for _, v in pairs(workspace:GetDescendants()) do
		if v:IsA("Model") and v.Name == BossName and v:FindFirstChild("HumanoidRootPart") then
			return v
		end
	end
	return nil
end

local function autoAttack()
	local tool = Character:FindFirstChildOfClass("Tool")
	if tool and tick() - lastSwing > swingDelay then
		lastSwing = tick()
		pcall(function() tool:Activate() end)
	end
end

RunService.Heartbeat:Connect(function(dt)
	if not isOrbiting or not HRP then return end

	local boss = getBoss()
	if boss and boss:FindFirstChild("HumanoidRootPart") then
		local bossHRP = boss.HumanoidRootPart
		local radius = tonumber(radiusInput.Text) or 18
		local speed = tonumber(speedInput.Text) or 6

		if #pathPoints == 0 then
			for i = 1, 360 do
				local theta = math.rad(i)
				local pos = bossHRP.Position + Vector3.new(math.cos(theta) * radius, 0, math.sin(theta) * radius)
				table.insert(pathPoints, pos)
			end
		end

		local target = pathPoints[pathIndex]
		HRP.CFrame = CFrame.new(target, bossHRP.Position)
		pathIndex = pathIndex + math.clamp(math.floor(speed), 1, 10)
		if pathIndex > #pathPoints then pathIndex = 1 end

		autoAttack()

		local humanoid = boss:FindFirstChildOfClass("Humanoid")
		if humanoid then
			hpLabel.Text = string.format("Máu Boss: %d / %d", humanoid.Health, humanoid.MaxHealth)
		end
	end
end)

startBtn.MouseButton1Click:Connect(function()
	isOrbiting = not isOrbiting
	if isOrbiting then
		startBtn.Text = "⏸ Dừng lại"
		startBtn.BackgroundColor3 = Color3.fromRGB(120, 20, 20)
	else
		startBtn.Text = "▶️ Quay Vòng Tròn"
		startBtn.BackgroundColor3 = Color3.fromRGB(50, 70, 120)
	end
end)

confirm.MouseButton1Click:Connect(function()
	if textbox.Text == "freefram" then
		gui:Destroy()
		gui2.Parent = game.CoreGui
		gui2.Enabled = true
	else
		label.Text = "❌ Sai key! Vui lòng thử lại."
		label.TextColor3 = Color3.fromRGB(255, 80, 80)
	end
end)
