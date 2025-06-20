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

-- TAB 2: Boss Hunter 👹
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

-- Đánh nhanh thật sự
AddToggle(Tab3, {
    Name = "💥 Đánh Nhanh Tay Thật",
    Callback = function(state)
        _G.realFastAttack = state
        if state then
            task.spawn(function()
                while _G.realFastAttack do
                    local tool = Character:FindFirstChildOfClass("Tool")
                    if tool then
                        for i = 1, 5 do
                            pcall(function()
                                tool:Activate()
                            end)
                        end
                    end
                    wait(0.05)
                end
            end)
        end
    end
})

-- Tự đánh khi cầm vũ khí
AddToggle(Tab3, {
    Name = "🡜 Tự đánh khi cầm vũ khí",
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

-- Hitbox rực rỡ
AddToggle(Tab3, {
    Name = "🌟 Hitbox Rực Rỡ",
    Callback = function(state)
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                local char = p.Character
                if char then
                    for _, partName in ipairs({"Head", "HumanoidRootPart", "Torso"}) do
                        local part = char:FindFirstChild(partName)
                        if part and part:IsA("BasePart") then
                            if state then
                                part.Size = Vector3.new(15, 15, 15)
                                part.Material = Enum.Material.Neon
                                part.Color = Color3.fromRGB(255, 0, 0)
                                part.Transparency = 0.1
                                part.Anchored = false
                                part.CanCollide = false
                            else
                                part.Size = Vector3.new(2, 2, 1)
                                part.Material = Enum.Material.Plastic
                                part.Color = Color3.fromRGB(163, 162, 165)
                                part.Transparency = 0
                            end
                        end
                    end
                end
            end
        end
    end
})

-- Hiển thị FPS chuẩn
AddToggle(Tab3, {
    Name = "📊 FPS Counter Chuẩn",
    Callback = function(state)
        if state then
            if not _G.fpsLabel then
                local fpsLabel = Instance.new("TextLabel")
                fpsLabel.Size = UDim2.new(0, 120, 0, 30)
                fpsLabel.Position = UDim2.new(0, 10, 0, 10)
                fpsLabel.BackgroundColor3 = Color3.new(0, 0, 0)
                fpsLabel.BackgroundTransparency = 0.3
                fpsLabel.TextColor3 = Color3.new(0, 1, 0)
                fpsLabel.Font = Enum.Font.GothamBold
                fpsLabel.TextScaled = true
                fpsLabel.Name = "FPSLabel"
                fpsLabel.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
                _G.fpsLabel = fpsLabel
            end
            _G.runningFPS = true
            task.spawn(function()
                local last = tick()
                local frames = 0
                while _G.runningFPS do
                    frames += 1
                    if tick() - last >= 1 then
                        _G.fpsLabel.Text = "FPS: " .. frames
                        frames = 0
                        last = tick()
                    end
                    RunService.RenderStepped:Wait()
                end
            end)
        else
            _G.runningFPS = false
            if _G.fpsLabel then
                _G.fpsLabel.Text = ""
            end
        end
    end
})

-- Tối ưu hóa game mạnh mẽ
AddButton(Tab3, {
    Name = "💻 Tối Ưu FPS MAX",
    Callback = function()
        local function disableEffects()
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Fire") or obj:IsA("Smoke") then
                    obj.Enabled = false
                end
            end
        end

        disableEffects()

        for _, v in ipairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") then
                v.Enabled = false
            end
        end

        Lighting.GlobalShadows = false
        Lighting.FogEnd = 1e10
        Lighting.Brightness = 0
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)

        local Terrain = workspace:FindFirstChildOfClass("Terrain")
        if Terrain then
            Terrain.WaterWaveSize = 0
            Terrain.WaterWaveSpeed = 0
            Terrain.WaterReflectance = 0
            Terrain.WaterTransparency = 1
        end

        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    end
})

-- PvP Pro Mode
AddButton(Tab3, {
    Name = "🔥 PvP Pro Mode",
    Description = "Kích hoạt chế độ PvP nâng cao 👹",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/levinh888/Script-ver4/main/script%20(1).lua"))()
    end
})
