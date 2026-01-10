for _, data in pairs(ignoredParts) do
            if data.part and data.originalParent then
                pcall(function()
                    data.part.Parent = data.originalParent
                end)
            end
        end
        ignoredParts = {}
    end
end)

-- weapons tab with buttons instead of loops
local function applyInfiniteAmmo()
    local rs = game:GetService("ReplicatedStorage")
    local weapons = rs:FindFirstChild("Weapons")
    if not weapons then 
        warn("weapons folder not found bruh 😭")
        return 
    end
    
    for _, weapon in pairs(weapons:GetDescendants()) do
        pcall(function()
            if weapon.Name == "Ammo" then
                weapon.Value = 999
            end
        end)
    end
    print("infinite ammo applied 🔥")
end

local function applyNoRecoil()
    local rs = game:GetService("ReplicatedStorage")
    local weapons = rs:FindFirstChild("Weapons")
    if not weapons then 
        warn("weapons folder not found bruh 😭")
        return 
    end
    
    for _, weapon in pairs(weapons:GetDescendants()) do
        pcall(function()
            if weapon.Name == "RecoilControl" or weapon.Name == "MaxSpread" then
                weapon.Value = 0
            end
        end)
    end
    print("no recoil applied 🔥")
end

local function applyFastFire()
    local rs = game:GetService("ReplicatedStorage")
    local weapons = rs:FindFirstChild("Weapons")
    if not weapons then 
        warn("weapons folder not found bruh 😭")
        return 
    end
    
    for _, weapon in pairs(weapons:GetDescendants()) do
        pcall(function()
            if weapon.Name == "Auto" then
                weapon.Value = true
            elseif weapon.Name == "FireRate" then
                weapon.Value = 0.02
            end
        end)
    end
    print("fast fire applied 🔥")
end

createButton(WeaponsContent, "Apply Infinite Ammo", UDim2.new(0, 0, 0, 5), function()
    applyInfiniteAmmo()
end)

createButton(WeaponsContent, "Apply No Recoil", UDim2.new(0, 0, 0, 48), function()
    applyNoRecoil()
end)

createButton(WeaponsContent, "Apply Fast Fire", UDim2.new(0, 0, 0, 91), function()
    applyFastFire()
end)

createButton(WeaponsContent, "Apply All Gun Mods", UDim2.new(0, 0, 0, 134), function()
    applyInfiniteAmmo()
    applyNoRecoil()
    applyFastFire()
end)

-- fps/ping labels
local FPSLabel = create("TextLabel", {
    Parent = Main,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 80, 0, 10),
    Size = UDim2.new(0, 100, 0, 30),
    Font = Enum.Font.GothamBold,
    Text = "FPS: 0",
    TextColor3 = Color3.fromRGB(180, 120, 255),
    TextSize = 14,
    TextStrokeTransparency = 0.5,
    TextTransparency = 1,
    TextXAlignment = Enum.TextXAlignment.Left
})

local PingLabel = create("TextLabel", {
    Parent = Main,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 80, 0, 35),
    Size = UDim2.new(0, 100, 0, 30),
    Font = Enum.Font.GothamBold,
    Text = "Ping: 0ms",
    TextColor3 = Color3.fromRGB(180, 120, 255),
    TextSize = 14,
    TextStrokeTransparency = 0.5,
    TextTransparency = 1,
    TextXAlignment = Enum.TextXAlignment.Left
})

-- fps/ping counter
local lastFrame = tick()
local frameCount = 0
local updateConnection
updateConnection = RunService.Heartbeat:Connect(function()
    frameCount = frameCount + 1
    if tick() - lastFrame >= 1 then
        FPSLabel.Text = "FPS: " .. frameCount
        frameCount = 0
        lastFrame = tick()
    end
    
    local success, ping = pcall(function()
        return game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
    end)
    if success then
        PingLabel.Text = "Ping: " .. math.floor(ping) .. "ms"
    end
    
    -- show/hide fps ping
    if fpsEnabled() then
        FPSLabel.TextTransparency = 0
    else
        FPSLabel.TextTransparency = 1
    end
    
    if pingEnabled() then
        PingLabel.TextTransparency = 0
    else
        PingLabel.TextTransparency = 1
    end
end)

-- rainbow mode
local rainbowConnection
rainbowConnection = RunService.Heartbeat:Connect(function()
    if _G.RainbowEnabled then
        local hue = tick() % 5 / 5
        local color = Color3.fromHSV(hue, 0.8, 1)
        Glow.Color = color
        TopBar.BackgroundColor3 = color
        MobileButton.BackgroundColor3 = color
        _G.CircleColor = color
    end
end)

-- esp system
local espCache = {}

local function createESPForPlayer(player)
    if player == LocalPlayer or espCache[player] then return end
    
    local function setupESP(character)
        if not character or espCache[player] then return end
        
        local head = character:WaitForChild("Head", 5)
        local hrp = character:WaitForChild("HumanoidRootPart", 5)
        
        if not head or not hrp then return end
        
        -- name esp
        local nameESP = create("BillboardGui", {
            Name = "ESP_Name",
            Parent = head,
            AlwaysOnTop = true,
            Size = UDim2.new(0, 200, 0, 30),
            StudsOffset = Vector3.new(0, 2, 0)
        })
        
        create("TextLabel", {
            Parent = nameESP,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Font = Enum.Font.GothamBold,
            Text = player.Name,
            TextColor3 = Color3.fromRGB(180, 120, 255),
            TextSize = 12,
            TextStrokeTransparency = 0,
            TextTransparency = 1
        })
        
        -- box esp
        local boxESP = create("BillboardGui", {
            Name = "ESP_Box",
            Parent = hrp,
            AlwaysOnTop = true,
            Size = UDim2.new(4, 0, 5, 0)
        })
        
        create("ImageLabel", {
            Parent = boxESP,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Image = "http://www.roblox.com/asset/?id=16946608585",
            ImageColor3 = Color3.fromRGB(180, 120, 255),
            ImageTransparency = 1
        })
        
        espCache[player] = {nameESP = nameESP, boxESP = boxESP, character = character}
    end
    
    if player.Character then
        setupESP(player.Character)
    end
    
    player.CharacterAdded:Connect(function(character)
        espCache[player] = nil
        wait(0.5)
        setupESP(character)
    end)
end

-- setup esp for existing players
for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        createESPForPlayer(player)
    end
end

Players.PlayerAdded:Connect(function(player)
    createESPForPlayer(player)
end)

Players.PlayerRemoving:Connect(function(player)
    espCache[player] = nil
end)

-- esp visibility update
local espConnection
espConnection = RunService.Heartbeat:Connect(function()
    for player, data in pairs(espCache) do
        if data.nameESP and data.boxESP and data.character then
            pcall(function()
                local nameLabel = data.nameESP:FindFirstChildOfClass("TextLabel")
                local boxImage = data.boxESP:FindFirstChildOfClass("ImageLabel")
                
                if nameLabel and boxImage then
                    local showESP = espToggled()
                    
                    -- team check
                    if espTeamCheck() and player.Team == LocalPlayer.Team then
                        showESP = false
                    end
                    
                    nameLabel.TextTransparency = showESP and 0 or 1
                    boxImage.ImageTransparency = showESP and 0.5 or 1
                end
            end)
        end
    end
end)

-- aimbot fov circle
local FovCircle = Drawing.new("Circle")
FovCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
FovCircle.Radius = _G.sizeof
FovCircle.Color = _G.CircleColor
FovCircle.Visible = _G.CircleVisible
FovCircle.NumSides = _G.CircleSides
FovCircle.Filled = false
FovCircle.Transparency = _G.fovTransparency
FovCircle.Thickness = 2

local function GetClosestPlayer()
    local target = nil
    local maxDist = _G.sizeof
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            pcall(function()
                if not _G.TeamCheckOn or player.Team ~= LocalPlayer.Team then
                    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                    local hum = player.Character:FindFirstChild("Humanoid")
                    
                    if hrp and hum and hum.Health > 0 then
                        local screenPoint = Camera:WorldToScreenPoint(hrp.Position)
                        local mousePos = Vector2.new(uis:GetMouseLocation().X, uis:GetMouseLocation().Y)
                        local dist = (mousePos - Vector2.new(screenPoint.X, screenPoint.Y)).Magnitude
                        
                        if dist < maxDist then
                            target = player
                            maxDist = dist
                        end
                    end
                end
            end)
        end
    end
    
    return target
end

local Holding = false
uis.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        Holding = true
    end
end)

uis.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 or input.UserInputType == Enum.UserInputType.Touch then
        Holding = false
    end
end)

local aimbotConnection
aimbotConnection = RunService.Heartbeat:Connect(function()
    local mousePos = uis:GetMouseLocation()
    FovCircle.Position = Vector2.new(mousePos.X, mousePos.Y)
    FovCircle.Radius = _G.sizeof
    FovCircle.Color = _G.CircleColor
    FovCircle.Visible = _G.CircleVisible
    FovCircle.Transparency = _G.fovTransparency
    
    if Holding and _G.AimOn then
        local target = GetClosestPlayer()
        if target and target.Character then
            pcall(function()
                local targetPart = target.Character:FindFirstChild(_G.Aimpart)
                if targetPart then
                    local targetPos = targetPart.Position
                    
                    if _G.Prediction then
                        local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            local velocity = hrp.AssemblyLinearVelocity
                            targetPos = targetPos + (velocity * _G.Sensitivity * 10)
                        end
                    end
                    
                    Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, targetPos), _G.Sensitivity)
                end
            end)
        end
    end
end)

-- toggle gui
local isOpen = false

local function toggleMenu()
    isOpen = not isOpen
    MainFrame.Visible = isOpen
    
    if isOpen then
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        ts:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Size = UDim2.new(0, 400, 0, 350)}):Play()
    end
end

-- keyboard toggle
uis.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        toggleMenu()
    end
end)

-- mobile button toggle
MobileButton.MouseButton1Click:Connect(function()
    toggleMenu()
end)

-- startup
wait(0.5)
switchTab("Combat")

-- show notification
ts:Create(Notification, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
wait(3)
ts:Create(Notification, TweenInfo.new(0.5), {TextTransparency = 1}):Play()

print("quotas hub loaded successfully 🔥")
