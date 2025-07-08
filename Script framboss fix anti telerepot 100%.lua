local _OO0lOl1l0O = game:GetService("Players")
local l1lO0OO1Ol = game:GetService("RunService")
local lO0l0O0lOl = _OO0lOl1l0O.LocalPlayer

repeat wait() until lO0l0O0lOl.Character and lO0l0O0lOl.Character:FindFirstChild("HumanoidRootPart")
local O00l0OlOO1 = lO0l0O0lOl.Character
local OOl00l00O0 = O00l0OlOO1:WaitForChild("HumanoidRootPart")
local l01OO0O00l = O00l0OlOO1:FindFirstChildOfClass("Humanoid")

local OOO1l1O0O0 = Instance.new("ScreenGui", lO0l0O0lOl:WaitForChild("PlayerGui"))
OOO1l1O0O0.Name = "WOKINGLOG_GUI"
OOO1l1O0O0.ResetOnSpawn = false

local l1O1l0l1O1 = Instance.new("Frame", OOO1l1O0O0)
l1O1l0l1O1.Size = UDim2.new(0, 300, 0, 220)
l1O1l0l1O1.Position = UDim2.new(0.35, 0, 0.3, 0)
l1O1l0l1O1.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
l1O1l0l1O1.BorderSizePixel = 2
l1O1l0l1O1.BorderColor3 = Color3.fromRGB(255, 0, 0)

local Ol1lO10OlO = Instance.new("TextLabel", l1O1l0l1O1)
Ol1lO10OlO.Size = UDim2.new(1, 0, 0, 30)
Ol1lO10OlO.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
Ol1lO10OlO.Text = "👹 WOKINGLOG MENU 👹"
Ol1lO10OlO.TextColor3 = Color3.new(1, 0, 0)
Ol1lO10OlO.Font = Enum.Font.GothamBlack
Ol1lO10OlO.TextScaled = true

local lOO1O0O10O = Instance.new("TextButton", l1O1l0l1O1)
lOO1O0O10O.Size = UDim2.new(0, 30, 0, 30)
lOO1O0O10O.Position = UDim2.new(1, -30, 0, 0)
lOO1O0O10O.Text = "X"
lOO1O0O10O.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
lOO1O0O10O.TextColor3 = Color3.new(1, 1, 1)
lOO1O0O10O.Font = Enum.Font.GothamBlack
lOO1O0O10O.TextScaled = true

local l0Ol00OO1l = Instance.new("TextButton", OOO1l1O0O0)
l0Ol00OO1l.Size = UDim2.new(0, 60, 0, 60)
l0Ol00OO1l.Position = UDim2.new(0, 20, 0.9, -60)
l0Ol00OO1l.Text = "👹"
l0Ol00OO1l.Visible = false
l0Ol00OO1l.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
l0Ol00OO1l.TextColor3 = Color3.new(1, 1, 1)
l0Ol00OO1l.Font = Enum.Font.GothamBold
l0Ol00OO1l.TextScaled = true

lOO1O0O10O.MouseButton1Click:Connect(function()
	l1O1l0l1O1.Visible = false
	l0Ol00OO1l.Visible = true
end)

l0Ol00OO1l.MouseButton1Click:Connect(function()
	l1O1l0l1O1.Visible = true
	l0Ol00OO1l.Visible = false
end)

local l1O00lOl01 = Instance.new("TextButton", l1O1l0l1O1)
l1O00lOl01.Position = UDim2.new(0.1, 0, 0, 50)
l1O00lOl01.Size = UDim2.new(0.8, 0, 0, 50)
l1O00lOl01.Text = "🔥 Bật Fram Boss"
l1O00lOl01.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
l1O00lOl01.TextColor3 = Color3.new(1, 1, 1)
l1O00lOl01.Font = Enum.Font.GothamBold
l1O00lOl01.TextScaled = true

local O01O0Ol11l = Instance.new("TextLabel", l1O1l0l1O1)
O01O0Ol11l.Size = UDim2.new(1, 0, 0, 30)
O01O0Ol11l.Position = UDim2.new(0, 0, 1, -30)
O01O0Ol11l.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
O01O0Ol11l.Text = "© WOKINGLOG 👹"
O01O0Ol11l.TextColor3 = Color3.new(1, 1, 1)
O01O0Ol11l.Font = Enum.Font.Gotham
O01O0Ol11l.TextScaled = true

local l00O0O01Ol = Instance.new("Frame", OOO1l1O0O0)
l00O0O01Ol.Position = UDim2.new(0.7, 0, 0.05, 0)
l00O0O01Ol.Size = UDim2.new(0, 180, 0, 50)
l00O0O01Ol.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
l00O0O01Ol.BorderSizePixel = 2
l00O0O01Ol.BorderColor3 = Color3.fromRGB(255, 0, 0)
l00O0O01Ol.Visible = false

local O0O0OlOl1O = Instance.new("TextLabel", l00O0O01Ol)
O0O0OlOl1O.Size = UDim2.new(1, 0, 1, 0)
O0O0OlOl1O.Text = "HP: ..."
O0O0OlOl1O.Font = Enum.Font.GothamBlack
O0O0OlOl1O.TextScaled = true
O0O0OlOl1O.TextColor3 = Color3.new(1, 1, 1)
O0O0OlOl1O.BackgroundTransparency = 1

local O0lOlOO10O = false
l1O00lOl01.MouseButton1Click:Connect(function()
	O0lOlOO10O = not O0lOlOO10O
	l00O0O01Ol.Visible = O0lOlOO10O
	l1O00lOl01.Text = O0lOlOO10O and "🛑 Dừng Fram Boss" or "🔥 Bật Fram Boss"
end)

function lOOO1l1O0O()
	local OlOOll0O01, lOO0OlOll1 = nil, math.huge
	for _, O01OlOO1l1 in pairs(workspace:GetDescendants()) do
		if O01OlOO1l1:IsA("Model") and O01OlOO1l1:FindFirstChild("HumanoidRootPart") and O01OlOO1l1 ~= O00l0OlOO1 then
			local O01llO0l01 = (OOl00l00O0.Position - O01OlOO1l1.HumanoidRootPart.Position).Magnitude
			if O01llO0l01 < lOO0OlOll1 and O01llO0l01 < 120 then
				lOO0OlOll1 = O01llO0l01
				OlOOll0O01 = O01OlOO1l1
			end
		end
	end
	return OlOOll0O01
end

function O00OO0O1O1(center)
	local O1Ol0l1O0l = {}
	for i = 0, 2 do
		local angle = math.rad(i * 120)
		local x = math.cos(angle) * 30
		local z = math.sin(angle) * 30
		table.insert(O1Ol0l1O0l, center + Vector3.new(x, 0.5, z))
	end
	return O1Ol0l1O0l
end

function lO0OlO0lO0()
	local tool = O00l0OlOO1:FindFirstChildOfClass("Tool")
	if tool then pcall(function() tool:Activate() end) end
end

spawn(function()
	while true do
		if O0lOlOO10O and l01OO0O00l then
			l01OO0O00l.PlatformStand = false
			l01OO0O00l.Sit = false
			l01OO0O00l.Jump = true
			task.delay(0.08, function() l01OO0O00l.Jump = false end)
		end
		wait(0.25)
	end
end)

spawn(function()
	local idx = 1
	while true do
		if O0lOlOO10O then
			local boss = lOOO1l1O0O()
			if boss and boss:FindFirstChild("HumanoidRootPart") then
				local triangle = O00OO0O1O1(boss.HumanoidRootPart.Position)
				local tgt = triangle[idx]
				local dir = (tgt - OOl00l00O0.Position).Unit * 130
				OOl00l00O0.Velocity = dir
				OOl00l00O0.CFrame = CFrame.new(OOl00l00O0.Position, boss.HumanoidRootPart.Position)

				if (OOl00l00O0.Position - tgt).Magnitude < 5 then
					idx = (idx % #triangle) + 1
				end

				lO0OlO0lO0()

				local H = boss:FindFirstChildOfClass("Humanoid")
				if H then
					O0O0OlOl1O.Text = "HP: " .. math.floor(H.Health) .. "/" .. math.floor(H.MaxHealth)
				end
			else
				O0O0OlOl1O.Text = "HP: ..."
			end
		else
			OOl00l00O0.Velocity = Vector3.zero
		end
		l1lO0OO1Ol.Stepped:Wait()
	end
end)
