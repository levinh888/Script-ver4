--// Obfuscated Rotate Script by Vinh 

local A,B,C=game:GetService("Players"),game:GetService("RunService"),game:GetService("UserInputService")
local D=A.LocalPlayer
local E=D.Character or D.CharacterAdded:Wait()
local F=E:WaitForChild("HumanoidRootPart")

D.CharacterAdded:Connect(function(G)
	E=G F=G:WaitForChild("HumanoidRootPart")
end)

local G1=Instance.new("ScreenGui",game.CoreGui) G1.Name="CR_GUI"
local T=Instance.new("TextButton",G1)
T.Size=UDim2.new(0,200,0,40)
T.Position=UDim2.new(0,20,0.5,-100)
T.Text="▶️ Quay Vòng Tròn"
T.BackgroundColor3=Color3.fromRGB(50,70,120)
T.TextColor3=Color3.new(1,1,1)
T.Font=Enum.Font.GothamBold
T.TextSize=14

local SB=Instance.new("TextBox",G1)
SB.Size=UDim2.new(0,200,0,30)
SB.Position=UDim2.new(0,20,0.5,-60)
SB.Text="3"
SB.PlaceholderText="Tốc độ góc"
SB.TextColor3=Color3.new(1,1,1)
SB.BackgroundColor3=Color3.fromRGB(40,40,80)
SB.ClearTextOnFocus=false

local RB=Instance.new("TextBox",G1)
RB.Size=UDim2.new(0,200,0,30)
RB.Position=UDim2.new(0,20,0.5,-20)
RB.Text="21"
RB.PlaceholderText="Bán kính"
RB.TextColor3=Color3.new(1,1,1)
RB.BackgroundColor3=Color3.fromRGB(40,40,80)
RB.ClearTextOnFocus=false

local H=Instance.new("TextLabel",G1)
H.Size=UDim2.new(0,220,0,30)
H.Position=UDim2.new(1,-240,0,20)
H.AnchorPoint=Vector2.new(0,0)
H.Text="Máu Boss: Đang tìm..."
H.TextColor3=Color3.fromRGB(255,80,80)
H.BackgroundColor3=Color3.fromRGB(30,30,30)
H.Font=Enum.Font.GothamBold
H.TextSize=14
H.TextXAlignment=Enum.TextXAlignment.Left
H.BorderSizePixel=0

local BN="NPC2"
local R=tonumber(RB.Text) or 21
local S=tonumber(SB.Text) or 3
local L=65
local BT=nil
local ROT=false
local ANG=0
local CEN=nil
local LA=0
local CD=0.3

local function FindBoss()
	for _,X in pairs(workspace:GetDescendants()) do
		if X:IsA("Model") and X.Name==BN and X:FindFirstChild("HumanoidRootPart") then return X end
	end
	return nil
end

local BV=Instance.new("BodyVelocity")
BV.Name="BV_Mover"
BV.MaxForce=Vector3.new(1e6,0,1e6)
BV.P=1500
BV.Velocity=Vector3.zero

local function Hit()
	local TOOL=E:FindFirstChildOfClass("Tool")
	if TOOL and tick()-LA>CD then
		LA=tick()
		coroutine.wrap(function()
			pcall(function() TOOL:Activate() end)
		end)()
	end
end

local UTime=0
local UInterval=0.2

B.RenderStepped:Connect(function(dt)
	if ROT and F then
		UTime+=dt
		if UTime>=UInterval then
			UTime=0
			if BT and BT:FindFirstChild("HumanoidRootPart") then
				CEN=BT.HumanoidRootPart.Position
			end
		end
		ANG+=S*dt
		local X=math.cos(ANG)*R
		local Z=math.sin(ANG)*R
		local TP=CEN+Vector3.new(X,0,Z)
		local CUR=F.Position
		local DIR=(TP-CUR).Unit
		BV.Velocity=Vector3.new(DIR.X,0,DIR.Z)*L

		if BT and BT:FindFirstChild("HumanoidRootPart") then
			local POS=BT.HumanoidRootPart.Position+Vector3.new(0,1.5,0)
			F.CFrame=CFrame.new(F.Position,POS)
			Hit()
		end

		if BT and BT:FindFirstChild("Humanoid") then
			local H1=BT.Humanoid.Health
			local H2=BT.Humanoid.MaxHealth
			H.Text=string.format("Máu Boss: %d / %d",H1,H2)
		else
			H.Text="Máu Boss: Đang tìm..."
		end
	else
		BV.Velocity=Vector3.zero
		H.Text="Máu Boss: Đang tìm..."
	end
end)

T.MouseButton1Click:Connect(function()
	S=tonumber(SB.Text) or S
	R=tonumber(RB.Text) or R
	ROT=not ROT
	if ROT then
		BT=FindBoss()
		if BT then
			CEN=BT.HumanoidRootPart.Position
			T.Text="⏸ Đang quay quanh Boss..."
			T.BackgroundColor3=Color3.fromRGB(120,20,20)
			BV.Parent=F
		else
			T.Text="❌ Không tìm thấy "..BN
			ROT=false
		end
	else
		T.Text="▶️ Quay Vòng Tròn"
		T.BackgroundColor3=Color3.fromRGB(50,70,120)
		BV.Velocity=Vector3.zero
		BV.Parent=nil
	end
end)