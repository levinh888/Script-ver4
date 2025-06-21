-- Load giao diện Redz UI V2
loadstring(game:HttpGet("https://raw.githubusercontent.com/daucobonhi/Ui-Redz-V2/main/UiREDzV2.lua"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

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

-- Tabs
local TabFarm = MakeTab({ Name = "Script Farm" })
local TabBoss = MakeTab({ Name = "Boss Hunter 👹" })
local TabPvP = MakeTab({ Name = "PvP" })
local TabSpeed = MakeTab({ Name = "Speed 🚀" })

-- Farm Script
AddButton(TabFarm, {
    Name = "Redz Hub",
    Callback = function()
        local Settings = { JoinTeam = "Pirates", Translator = true }
        loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/main/Source.lua"))(Settings)
    end
})

-- Boss Script
AddButton(TabBoss, {
    Name = "🔥 Bật Script OutFram Boss Bá Đạo",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/levinh888/Script-ver4/main/script%20framboss%20b%C3%A1%20.lua"))()
    end
})

-- PvP Features
AddToggle(TabPvP, {
    Name = "💥 Đánh Nhanh Tay Thật (Times Pro)",
    Callback = function(state)
        _G.realFastAttack = state
        if state then
            task.spawn(function()
                while _G.realFastAttack do
                    local tool = Character:FindFirstChildOfClass("Tool")
                    if tool then
                        for _ = 1, 12 do pcall(function() tool:Activate() end) end
                    end
                    wait(0.01)
                end
            end)
        end
    end
})

AddToggle(TabPvP, {
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

AddToggle(TabPvP, {
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

AddToggle(TabPvP, {
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
                fpsLabel.Parent = LocalPlayer:WaitForChild("PlayerGui")
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
            if _G.fpsLabel then _G.fpsLabel.Text = "" end
        end
    end
})

-- FPS Boost Preset
AddButton(TabPvP, {
    Name = "⚙️ Chế độ 60Hz FPS Boost",
    Callback = function()
        settings().Rendering.FrameRateManager = Enum.FrameRateManagerMode.Efficient
    end
})

AddButton(TabPvP, {
    Name = "⚙️ Chế độ 120Hz FPS Boost",
    Callback = function()
        settings().Rendering.FrameRateManager = Enum.FrameRateManagerMode.On
    end
})

-- Auto PvP Attack
AddToggle(TabPvP, {
    Name = "⚔️ PvP Thật Sự (Auto Attack)",
    Callback = function(state)
        _G.autoRealPvP = state
        if state then
            task.spawn(function()
                while _G.autoRealPvP do
                    for _, p in pairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                            local tool = Character:FindFirstChildOfClass("Tool")
                            if (Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude < 25 then
                                Character.HumanoidRootPart.CFrame = CFrame.lookAt(Character.HumanoidRootPart.Position, p.Character.HumanoidRootPart.Position)
                                pcall(function() tool:Activate() end)
                            end
                        end
                    end
                    wait(0.1)
                end
            end)
        end
    end
})

-- Hiện máu kẻ địch
AddToggle(TabPvP, {
    Name = "🩸 Hiện Máu Kẻ Địch",
    Callback = function(state)
        _G.enemyHealthBar = state
        if state then
            task.spawn(function()
                while _G.enemyHealthBar do
                    for _, enemy in pairs(Players:GetPlayers()) do
                        if enemy ~= LocalPlayer and enemy.Character and enemy.Character:FindFirstChild("Humanoid") then
                            local head = enemy.Character:FindFirstChild("Head")
                            if head and not head:FindFirstChild("EnemyHP") then
                                local hpBar = Instance.new("BillboardGui", head)
                                hpBar.Name = "EnemyHP"
                                hpBar.Size = UDim2.new(4, 0, 0.4, 0)
                                hpBar.StudsOffset = Vector3.new(0, 2.5, 0)
                                hpBar.AlwaysOnTop = true
                                local bar = Instance.new("Frame", hpBar)
                                bar.Name = "Bar"
                                bar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                                bar.BorderSizePixel = 0
                                bar.Size = UDim2.new(1, 0, 1, 0)
                                Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 6)
                            end
                            local gui = head:FindFirstChild("EnemyHP")
                            if gui then
                                local percent = math.clamp(enemy.Character.Humanoid.Health / enemy.Character.Humanoid.MaxHealth, 0, 1)
                                gui.Bar.Size = UDim2.new(percent, 0, 1, 0)
                            end
                        end
                    end
                    wait(0.2)
                end
                for _, p in pairs(Players:GetPlayers()) do
                    if p.Character and p.Character:FindFirstChild("Head") then
                        local gui = p.Character.Head:FindFirstChild("EnemyHP")
                        if gui then gui:Destroy() end
                    end
                end
            end)
        end
    end
})

-- Speed Tab
local currentSpeed = 16
local speedEnabled = false
local slider

AddToggle(TabSpeed, {
    Name = "⚡ Bật Speed Nhanh",
    Callback = function(state)
        speedEnabled = state
        local humanoid = Character:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid.WalkSpeed = state and currentSpeed or 16 end
        if slider and slider.Object then slider.Object.Visible = state end
    end
})

slider = AddSlider(TabSpeed, {
    Name = "🎚️ Tùy Chỉnh Speed",
    Min = 16,
    Max = 200,
    Default = 16,
    Callback = function(value)
        currentSpeed = value
        local humanoid = Character:FindFirstChildOfClass("Humanoid")
        if humanoid and speedEnabled then humanoid.WalkSpeed = value end
    end
})

if slider and slider.Object then slider.Object.Visible = false end

AddButton(TabSpeed, {
    Name = "↩️ Reset Tốc Độ Về 16",
    Callback = function()
        currentSpeed = 16
        local humanoid = Character:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid.WalkSpeed = speedEnabled and 16 or 16 end
        if slider and slider.Object then slider:Set(16) end
    end
})
