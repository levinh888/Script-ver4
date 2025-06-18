local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- GUI
local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "VinhToolMenu"
gui.ResetOnSpawn = false

-- 🗿 NÚT MỞ MENU
local openBtn = Instance.new("TextButton", gui)
openBtn.Name = "OpenMenuButton"
openBtn.Size = UDim2.new(0, 55, 0, 55)
openBtn.Position = UDim2.new(0, 12, 0.5, -28)
openBtn.Text = "🗿"
openBtn.TextScaled = true
openBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 120)
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openBtn.BorderSizePixel = 0
openBtn.Font = Enum.Font.FredokaOne
Instance.new("UICorner", openBtn)

openBtn.MouseEnter:Connect(function()
	openBtn.BackgroundColor3 = Color3.fromRGB(100, 60, 160)
end)
openBtn.MouseLeave:Connect(function()
	openBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 120)
end)

-- MENU CHÍNH
local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 280, 0, 420)
mainFrame.Position = UDim2.new(0, 80, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 50)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame)

-- TIÊU ĐỀ
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 38)
title.Text = "🌀 VINH TOOL MENU"
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(60, 30, 100)
title.BorderSizePixel = 0
Instance.new("UICorner", title)

-- NÚT ĐÓNG ✖
local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0, 35, 0, 30)
closeBtn.Position = UDim2.new(1, -40, 0, 4)
closeBtn.Text = "✖"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextScaled = true
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 40)
closeBtn.BorderSizePixel = 0
Instance.new("UICorner", closeBtn)

-- MỞ / ĐÓNG MENU
openBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)
closeBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
end)

-- DANH SÁCH NÚT
local y = 45
local function addToggle(name, callback)
	local btn = Instance.new("TextButton", mainFrame)
	btn.Size = UDim2.new(0.9, 0, 0, 30)
	btn.Position = UDim2.new(0.05, 0, 0, y)
	y += 35
	btn.Text = "OFF - " .. name
	btn.Font = Enum.Font.Gotham
	btn.TextScaled = true
	btn.TextColor3 = Color3.new(1,1,1)
	btn.BackgroundColor3 = Color3.fromRGB(70, 70, 130)
	btn.BorderSizePixel = 0
	Instance.new("UICorner", btn)

	local state = false  
	btn.MouseButton1Click:Connect(function()  
		state = not state  
		btn.Text = (state and "ON  - " or "OFF - ") .. name  
		btn.BackgroundColor3 = state and Color3.fromRGB(40, 200, 100) or Color3.fromRGB(70, 70, 130)  
		callback(state)  
	end)
end

-- ░ CHỨC NĂNG ░ --

-- Tăng tốc đánh
local atkSpeedConn
addToggle("Tăng tốc đánh", function(state)
	if state then
		atkSpeedConn = RunService.Heartbeat:Connect(function()
			local h = Character:FindFirstChildOfClass("Humanoid")
			if h then
				for _, a in pairs(h:GetPlayingAnimationTracks()) do
					pcall(function() a:AdjustSpeed(5) end)
				end
			end
		end)
	else
		if atkSpeedConn then atkSpeedConn:Disconnect() end
	end
end)

-- Tự đánh
local autoAtk
addToggle("Tự đánh khi cầm vũ khí", function(state)
	autoAtk = state
	if state then
		task.spawn(function()
			while autoAtk do
				local tool = Character:FindFirstChildOfClass("Tool")
				if tool then pcall(function() tool:Activate() end) end
				wait(0.2)
			end
		end)
	end
end)

-- Hiển thị FPS
local fpsConn
local fpsLabel = Instance.new("TextLabel", gui)
fpsLabel.Size = UDim2.new(0, 100, 0, 30)
fpsLabel.Position = UDim2.new(1, -110, 0, 10)
fpsLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
fpsLabel.TextColor3 = Color3.new(0,1,0)
fpsLabel.TextScaled = true
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.Text = ""
fpsLabel.Visible = false
Instance.new("UICorner", fpsLabel)

addToggle("Hiển thị FPS", function(state)
	if state then
		fpsLabel.Visible = true
		local lastTime = tick()
		local frameCount = 0
		fpsConn = RunService.RenderStepped:Connect(function()
			frameCount += 1
			if tick() - lastTime >= 1 then
				fpsLabel.Text = "FPS: " .. frameCount
				frameCount = 0
				lastTime = tick()
			end
		end)
	else
		if fpsConn then fpsConn:Disconnect() end
		fpsLabel.Visible = false
	end
end)

-- Hitbox mở rộng
addToggle("Hitbox mở rộng", function(state)
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Character then
			for _, part in ipairs({"Head", "HumanoidRootPart", "Torso"}) do
				local bodyPart = p.Character:FindFirstChild(part)
				if bodyPart and bodyPart:IsA("BasePart") then
					if state then
						bodyPart.Size = Vector3.new(10, 10, 10)
						bodyPart.Transparency = 0.5
						bodyPart.Material = Enum.Material.Neon
						bodyPart.BrickColor = BrickColor.new("Really red")
					else
						bodyPart.Size = Vector3.new(2, 2, 1)
						bodyPart.Transparency = 0
						bodyPart.Material = Enum.Material.Plastic
						bodyPart.BrickColor = BrickColor.new("Medium stone grey")
					end
				end
			end
		end
	end
end)

-- GIẢM ĐỒ HOẠ
local function applyLowGraphics(percent)
	local function clearChildren(class)
		for _, obj in pairs(workspace:GetDescendants()) do
			if obj:IsA(class) then
				pcall(function() obj:Destroy() end)
			end
		end
	end

	clearChildren("ParticleEmitter")  
	clearChildren("Trail")  
	clearChildren("Smoke")  
	clearChildren("Fire")  
	clearChildren("Decal")  

	if workspace:FindFirstChildOfClass("Terrain") then  
		local terrain = workspace:FindFirstChildOfClass("Terrain")  
		terrain.WaterTransparency = 1  
		terrain.WaterWaveSize = 0  
		terrain.WaterReflectance = 0  
	end  

	Lighting.GlobalShadows = percent >= 70  
	Lighting.FogEnd = percent == 70 and 1000 or (percent == 50 and 50000 or 100000)  
	Lighting.FogStart = 0  
	Lighting.Brightness = percent == 70 and 2 or 0  
	Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)  
	Lighting.ClockTime = 14  
	Lighting.ExposureCompensation = 0  
	Lighting.ShadowSoftness = percent == 70 and 0.2 or 0  

	for _, v in pairs(Lighting:GetChildren()) do  
		if v:IsA("BloomEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BlurEffect") then  
			pcall(function() v.Enabled = false end)  
		end  
	end  

	if percent == 30 then  
		for _, obj in ipairs(workspace:GetDescendants()) do  
			if obj:IsA("Texture") or obj:IsA("SurfaceAppearance") then  
				pcall(function() obj:Destroy() end)  
			end  
		end  
	end
end

-- Nút giảm đồ hoạ
local graphicLabel = Instance.new("TextLabel", mainFrame)
graphicLabel.Size = UDim2.new(0.9, 0, 0, 25)
graphicLabel.Position = UDim2.new(0.05, 0, 0, y + 5)
graphicLabel.Text = "Giảm đồ hoạ:"
graphicLabel.TextColor3 = Color3.new(1,1,1)
graphicLabel.BackgroundTransparency = 1
graphicLabel.Font = Enum.Font.GothamBold
graphicLabel.TextScaled = true
y += 30

local options = {30, 50, 70}
for i, level in ipairs(options) do
	local b = Instance.new("TextButton", mainFrame)
	b.Size = UDim2.new(0.27, 0, 0, 25)
	b.Position = UDim2.new(0.05 + (i-1)*0.31, 0, 0, y)
	b.Text = level.."%"
	b.TextScaled = true
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
	b.Font = Enum.Font.Gotham
	b.BorderSizePixel = 0
	Instance.new("UICorner", b)
	b.MouseButton1Click:Connect(function()
		applyLowGraphics(level)
	end)
end