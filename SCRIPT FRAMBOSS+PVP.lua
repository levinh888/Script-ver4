-- Tải giao diện UI Redz V2
loadstring(game:HttpGet("https://raw.githubusercontent.com/daucobonhi/Ui-Redz-V2/main/UiREDzV2.lua"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- Giao diện chính
local Window = MakeWindow({
    Hub = {
        Title = "WOKINGLOG 👹",
        Animation = "Youtube: WOKINGLOG 👹"
    },
    Key = {
        KeySystem = false,
        Title = "Key System",
        Description = "",
        KeyLink = "",
        Keys = {"1234"},
        Notifi = {
            Notifications = true,
            CorrectKey = "Running the Script...",
            Incorrectkey = "The key is incorrect",
            CopyKeyLink = "Copied to Clipboard"
        }
    }
})

-- Nút minimize
MinimizeButton({
    Image = "rbxassetid://12550760234",
    Size = {60, 60},
    Color = Color3.fromRGB(10, 10, 10),
    Corner = true,
    Stroke = false,
    StrokeColor = Color3.fromRGB(255, 0, 0)
})

-- TAB 1: Script Farm
local Tab1 = MakeTab({ Name = "Script Farm" })
AddButton(Tab1, {
    Name = "Redz Hub",
    Callback = function()
        local Settings = {
            JoinTeam = "Pirates",
            Translator = true
        }
        loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/main/Source.lua"))(Settings)
    end
})

-- TAB 2: Boss Hunter 👹 (đã thay bằng bản bá đạo)
local Tab2 = MakeTab({ Name = "Boss Hunter 👹" })
AddButton(Tab2, {
    Name = "🔥 Bật Script OutFram Boss Bá Đạo",
    Description = "Phiên bản mạnh hơn, bá đạo hơn 👹",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/levinh888/Script-ver4/main/script%20framboss%20b%C3%A1%20.lua"))()
    end
})

-- TAB 3: PvP
local Tab3 = MakeTab({ Name = "PvP" })

AddToggle(Tab3, {
    Name = "⚡ Tăng tốc đánh",
    Callback = function(state)
        if state then
            _G.atkSpeedConn = RunService.Heartbeat:Connect(function()
                local h = Character:FindFirstChildOfClass("Humanoid")
                if h then
                    for _, a in pairs(h:GetPlayingAnimationTracks()) do
                        pcall(function() a:AdjustSpeed(5) end)
                    end
                end
            end)
        else
            if _G.atkSpeedConn then _G.atkSpeedConn:Disconnect() end
        end
    end
})

AddToggle(Tab3, {
    Name = "🤜 Tự đánh khi cầm vũ khí",
    Callback = function(state)
        _G.autoAtk = state
        if state then
            task.spawn(function()
                while _G.autoAtk do
                    local tool = Character:FindFirstChildOfClass("Tool")
                    if tool then pcall(function() tool:Activate() end) end
                    wait(0.2)
                end
            end)
        end
    end
})

AddToggle(Tab3, {
    Name = "🎯 Hitbox mở rộng",
    Callback = function(state)
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                local char = p.Character
                if char then
                    for _, part in ipairs({"Head", "HumanoidRootPart", "Torso"}) do
                        local bodyPart = char:FindFirstChild(part)
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
        end
    end
})

AddToggle(Tab3, {
    Name = "📊 Hiển thị FPS",
    Callback = function(state)
        if not _G.fpsLabel then
            _G.fpsLabel = Instance.new("TextLabel")
            _G.fpsLabel.Size = UDim2.new(0, 120, 0, 30)
            _G.fpsLabel.Position = UDim2.new(0, 10, 0, 10)
            _G.fpsLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            _G.fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            _G.fpsLabel.TextScaled = true
            _G.fpsLabel.Font = Enum.Font.GothamBold
            _G.fpsLabel.Text = ""
            _G.fpsLabel.Parent = game.CoreGui
        end
        if state then
            _G.fpsLabel.Visible = true
            _G.fpsRunning = true
            task.spawn(function()
                local lastTime = tick()
                local frameCount = 0
                while _G.fpsRunning do
                    frameCount += 1
                    if tick() - lastTime >= 1 then
                        _G.fpsLabel.Text = "FPS: " .. frameCount
                        frameCount = 0
                        lastTime = tick()
                    end
                    RunService.RenderStepped:Wait()
                end
            end)
        else
            _G.fpsRunning = false
            if _G.fpsLabel then _G.fpsLabel.Visible = false end
        end
    end
})

AddButton(Tab3, {
    Name = "💻 Giảm đồ hoạ (30%)",
    Description = "Xoá hiệu ứng + làm nhẹ game",
    Callback = function()
        local function clear(class)
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA(class) then pcall(function() obj:Destroy() end) end
            end
        end
        clear("ParticleEmitter")
        clear("Trail")
        clear("Smoke")
        clear("Fire")
        clear("Decal")
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") then v.Enabled = false end
        end
        Lighting.FogEnd = 100000
        Lighting.Brightness = 0
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
    end
})

AddButton(Tab3, {
    Name = "🔥 PvP Pro Mode",
    Description = "Kích hoạt chế độ PvP nâng cao 👹",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/levinh888/Script-ver4/main/script%20(1).lua"))()
    end
})