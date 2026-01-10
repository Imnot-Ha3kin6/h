wait(1)

local Camera = workspace.CurrentCamera
local uis = game:GetService("UserInputService")
local ts = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- helper function
local function create(class, props)
    local obj = Instance.new(class)
    for k, v in pairs(props) do
        if k ~= "Parent" then
            obj[k] = v
        end
    end
    if props.Parent then
        obj.Parent = props.Parent
    end
    return obj
end

-- globals
_G.sizeof = 100
_G.AimOn = false
_G.TeamCheckOn = true
_G.Aimpart = "Head"
_G.Sensitivity = 0.03
_G.CircleSides = 64
_G.CircleColor = Color3.fromRGB(180, 120, 255)
_G.CircleVisible = true
_G.fovTransparency = 0
_G.Prediction = false
_G.RainbowEnabled = false

-- main gui
local Main = create("ScreenGui", {
    Name = "Main",
    Parent = LocalPlayer:WaitForChild("PlayerGui"),
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    ResetOnSpawn = false,
    DisplayOrder = 9999
})

-- mobile open button
local MobileButton = create("TextButton", {
    Parent = Main,
    BackgroundColor3 = Color3.fromRGB(180, 120, 255),
    BorderSizePixel = 0,
    Position = UDim2.new(0.02, 0, 0.02, 0),
    Size = UDim2.new(0.12, 0, 0.08, 0),
    Font = Enum.Font.GothamBold,
    Text = "MENU",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 14,
    ZIndex = 100
})
create("UICorner", {CornerRadius = UDim.new(0.2, 0), Parent = MobileButton})
create("UISizeConstraint", {
    Parent = MobileButton,
    MaxSize = Vector2.new(70, 70),
    MinSize = Vector2.new(50, 50)
})

-- notification
local Notification = create("TextLabel", {
    Parent = Main,
    BackgroundTransparency = 1,
    Position = UDim2.new(0.5, 0, 0.1, 0),
    AnchorPoint = Vector2.new(0.5, 0),
    Size = UDim2.new(0.6, 0, 0.05, 0),
    Font = Enum.Font.GothamBold,
    Text = "Press MENU or RIGHT SHIFT",
    TextColor3 = Color3.fromRGB(180, 120, 255),
    TextSize = 16,
    TextScaled = true,
    TextStrokeTransparency = 0.5,
    ZIndex = 10
})

-- main frame
local MainFrame = create("Frame", {
    Name = "MainFrame",
    Parent = Main,
    BackgroundColor3 = Color3.fromRGB(20, 20, 25),
    BorderSizePixel = 0,
    Position = UDim2.new(0.5, 0, 0.5, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    Size = UDim2.new(0.85, 0, 0.75, 0),
    Visible = false,
    Active = true,
    Draggable = true
})
create("UICorner", {CornerRadius = UDim.new(0.03, 0), Parent = MainFrame})
create("UISizeConstraint", {
    Parent = MainFrame,
    MaxSize = Vector2.new(500, 450),
    MinSize = Vector2.new(300, 300)
})

-- gradient background
local Gradient = create("UIGradient", {
    Parent = MainFrame,
    Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 20, 35)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 10, 25))
    },
    Rotation = 45
})

-- border glow
local Glow = create("UIStroke", {
    Parent = MainFrame,
    Color = Color3.fromRGB(180, 120, 255),
    Thickness = 2,
    Transparency = 0.3
})

-- top bar
local TopBar = create("Frame", {
    Parent = MainFrame,
    BackgroundColor3 = Color3.fromRGB(180, 120, 255),
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 0.12, 0)
})
create("UICorner", {CornerRadius = UDim.new(0.15, 0), Parent = TopBar})

local Title = create("TextLabel", {
    Parent = TopBar,
    BackgroundTransparency = 1,
    Position = UDim2.new(0.04, 0, 0, 0),
    Size = UDim2.new(0.6, 0, 1, 0),
    Font = Enum.Font.GothamBold,
    Text = "QUOTAS HUB",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 20,
    TextScaled = true,
    TextXAlignment = Enum.TextXAlignment.Left
})
create("UITextSizeConstraint", {
    Parent = Title,
    MaxTextSize = 20,
    MinTextSize = 12
})

-- close button
local CloseBtn = create("TextButton", {
    Parent = TopBar,
    BackgroundColor3 = Color3.fromRGB(255, 50, 50),
    BorderSizePixel = 0,
    Position = UDim2.new(0.92, 0, 0.15, 0),
    AnchorPoint = Vector2.new(0.5, 0),
    Size = UDim2.new(0.12, 0, 0.6, 0),
    Font = Enum.Font.GothamBold,
    Text = "X",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 16,
    TextScaled = true
})
create("UICorner", {CornerRadius = UDim.new(0.2, 0), Parent = CloseBtn})
create("UIAspectRatioConstraint", {
    Parent = CloseBtn,
    AspectRatio = 1
})

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- bottom bar
local BottomBar = create("Frame", {
    Parent = MainFrame,
    BackgroundColor3 = Color3.fromRGB(15, 10, 25),
    BorderSizePixel = 0,
    Position = UDim2.new(0, 0, 0.88, 0),
    Size = UDim2.new(1, 0, 0.12, 0)
})
create("UICorner", {CornerRadius = UDim.new(0.15, 0), Parent = BottomBar})

-- content area
local Content = create("Frame", {
    Parent = MainFrame,
    BackgroundTransparency = 1,
    Position = UDim2.new(0.025, 0, 0.14, 0),
    Size = UDim2.new(0.95, 0, 0.72, 0)
})

-- create tab buttons in bottom bar
local function createTabButton(name, icon, position)
    local btn = create("TextButton", {
        Name = name,
        Parent = BottomBar,
        BackgroundColor3 = Color3.fromRGB(30, 25, 40),
        BorderSizePixel = 0,
        Position = position,
        Size = UDim2.new(0.23, 0, 0, 32),
        Font = Enum.Font.GothamBold,
        Text = icon,
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextSize = 12
    })
    create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = btn})
    
    btn.MouseEnter:Connect(function()
        if btn.BackgroundColor3 ~= Color3.fromRGB(180, 120, 255) then
            ts:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 35, 50)}):Play()
        end
    end)
    
    btn.MouseLeave:Connect(function()
        if btn.BackgroundColor3 ~= Color3.fromRGB(180, 120, 255) then
            ts:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 25, 40)}):Play()
        end
    end)
    
    return btn
end

local CombatTab = createTabButton("Combat", "⚔️ Combat", UDim2.new(0.02, 0, 0.5, -16))
local VisualsTab = createTabButton("Visuals", "👁️ Visuals", UDim2.new(0.27, 0, 0.5, -16))
local MiscTab = createTabButton("Misc", "🔧 Misc", UDim2.new(0.52, 0, 0.5, -16))
local WeaponsTab = createTabButton("Weapons", "🔫 Guns", UDim2.new(0.77, 0, 0.5, -16))

-- create toggle switch
local function createToggle(parent, name, position, callback)
    local container = create("Frame", {
        Parent = parent,
        BackgroundColor3 = Color3.fromRGB(30, 25, 40),
        BorderSizePixel = 0,
        Position = position,
        Size = UDim2.new(1, 0, 0, 38)
    })
    create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = container})
    
    local label = create("TextLabel", {
        Parent = container,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 0),
        Size = UDim2.new(0.65, 0, 1, 0),
        Font = Enum.Font.Gotham,
        Text = name,
        TextColor3 = Color3.fromRGB(220, 220, 220),
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local toggleFrame = create("Frame", {
        Parent = container,
        BackgroundColor3 = Color3.fromRGB(40, 40, 45),
        BorderSizePixel = 0,
        Position = UDim2.new(1, -48, 0.5, -10),
        Size = UDim2.new(0, 38, 0, 20)
    })
    create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = toggleFrame})
    
    local toggleButton = create("Frame", {
        Parent = toggleFrame,
        BackgroundColor3 = Color3.fromRGB(200, 200, 200),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 2, 0.5, -8),
        Size = UDim2.new(0, 16, 0, 16)
    })
    create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = toggleButton})
    
    local toggled = false
    local clickDetector = create("TextButton", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Text = ""
    })
    
    clickDetector.MouseButton1Click:Connect(function()
        toggled = not toggled
        
        if toggled then
            ts:Create(toggleButton, TweenInfo.new(0.2), {Position = UDim2.new(1, -18, 0.5, -8)}):Play()
            ts:Create(toggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(180, 120, 255)}):Play()
            ts:Create(toggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(90, 60, 127)}):Play()
        else
            ts:Create(toggleButton, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -8)}):Play()
            ts:Create(toggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(200, 200, 200)}):Play()
            ts:Create(toggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 45)}):Play()
        end
        
        if callback then
            callback(toggled)
        end
    end)
    
    return function() return toggled end
end

-- create button (new function)
local function createButton(parent, name, position, callback)
    local container = create("Frame", {
        Parent = parent,
        BackgroundColor3 = Color3.fromRGB(30, 25, 40),
        BorderSizePixel = 0,
        Position = position,
        Size = UDim2.new(1, 0, 0, 38)
    })
    create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = container})
    
    local btn = create("TextButton", {
        Parent = container,
        BackgroundColor3 = Color3.fromRGB(180, 120, 255),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 8, 0, 6),
        Size = UDim2.new(1, -16, 1, -12),
        Font = Enum.Font.GothamBold,
        Text = name,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 13
    })
    create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = btn})
    
    btn.MouseButton1Click:Connect(function()
        ts:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(140, 90, 200)}):Play()
        wait(0.1)
        ts:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(180, 120, 255)}):Play()
        
        if callback then
            callback()
        end
    end)
    
    btn.MouseEnter:Connect(function()
        ts:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(200, 140, 255)}):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        ts:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(180, 120, 255)}):Play()
    end)
end

-- create slider
local function createSlider(parent, name, position, min, max, default, callback)
    local container = create("Frame", {
        Parent = parent,
        BackgroundColor3 = Color3.fromRGB(30, 25, 40),
        BorderSizePixel = 0,
        Position = position,
        Size = UDim2.new(1, 0, 0, 48)
    })
    create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = container})
    
    local label = create("TextLabel", {
        Parent = container,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 0),
        Size = UDim2.new(0.6, 0, 0, 22),
        Font = Enum.Font.Gotham,
        Text = name,
        TextColor3 = Color3.fromRGB(220, 220, 220),
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local valueLabel = create("TextLabel", {
        Parent = container,
        BackgroundTransparency = 1,
        Position = UDim2.new(0.6, 0, 0, 0),
        Size = UDim2.new(0.4, -12, 0, 22),
        Font = Enum.Font.GothamBold,
        Text = tostring(default),
        TextColor3 = Color3.fromRGB(180, 120, 255),
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Right
    })
    
    local sliderFrame = create("Frame", {
        Parent = container,
        BackgroundColor3 = Color3.fromRGB(40, 40, 45),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 12, 0, 28),
        Size = UDim2.new(1, -24, 0, 8)
    })
    create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = sliderFrame})
    
    local sliderFill = create("Frame", {
        Parent = sliderFrame,
        BackgroundColor3 = Color3.fromRGB(180, 120, 255),
        BorderSizePixel = 0,
        Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    })
    create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = sliderFill})
    
    local sliderButton = create("Frame", {
        Parent = sliderFrame,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Position = UDim2.new((default - min) / (max - min), -6, 0.5, -6),
        Size = UDim2.new(0, 12, 0, 12)
    })
    create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = sliderButton})
    
    local dragging = false
    local clickDetector = create("TextButton", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Text = ""
    })
    
    clickDetector.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    uis.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    RunService.RenderStepped:Connect(function()
        if dragging then
            local mousePos = uis:GetMouseLocation()
            local relativePos = mousePos.X - sliderFrame.AbsolutePosition.X
            local percentage = math.clamp(relativePos / sliderFrame.AbsoluteSize.X, 0, 1)
            local value = math.floor(min + (max - min) * percentage)
            
            sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
            sliderButton.Position = UDim2.new(percentage, -6, 0.5, -6)
            valueLabel.Text = tostring(value)
            
            if callback then
                callback(value)
            end
        end
    end)
end

-- create dropdown
local function createDropdown(parent, name, position, options, callback)
    local container = create("Frame", {
        Parent = parent,
        BackgroundColor3 = Color3.fromRGB(30, 25, 40),
        BorderSizePixel = 0,
        Position = position,
        Size = UDim2.new(1, 0, 0, 38)
    })
    create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = container})
    
    local label = create("TextLabel", {
        Parent = container,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 0),
        Size = UDim2.new(0.45, 0, 1, 0),
        Font = Enum.Font.Gotham,
        Text = name,
        TextColor3 = Color3.fromRGB(220, 220, 220),
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local currentIndex = 1
    local valueLabel = create("TextLabel", {
        Parent = container,
        BackgroundTransparency = 1,
        Position = UDim2.new(0.45, 0, 0, 0),
        Size = UDim2.new(0.55, -12, 1, 0),
        Font = Enum.Font.GothamBold,
        Text = options[currentIndex],
        TextColor3 = Color3.fromRGB(180, 120, 255),
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Right
    })
    
    local clickDetector = create("TextButton", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Text = ""
    })
    
    clickDetector.MouseButton1Click:Connect(function()
        currentIndex = currentIndex % #options + 1
        valueLabel.Text = options[currentIndex]
        if callback then
            callback(options[currentIndex])
        end
    end)
end

-- tabs content
local CombatContent = create("ScrollingFrame", {
    Parent = Content,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 1, 0),
    CanvasSize = UDim2.new(0, 0, 0, 450),
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = Color3.fromRGB(180, 120, 255),
    Visible = true
})

local VisualsContent = create("ScrollingFrame", {
    Parent = Content,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 1, 0),
    CanvasSize = UDim2.new(0, 0, 0, 450),
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = Color3.fromRGB(180, 120, 255),
    Visible = false
})

local MiscContent = create("ScrollingFrame", {
    Parent = Content,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 1, 0),
    CanvasSize = UDim2.new(0, 0, 0, 450),
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = Color3.fromRGB(180, 120, 255),
    Visible = false
})

local WeaponsContent = create("ScrollingFrame", {
    Parent = Content,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 1, 0),
    CanvasSize = UDim2.new(0, 0, 0, 450),
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = Color3.fromRGB(180, 120, 255),
    Visible = false
})

-- tab switching
local function switchTab(tab)
    CombatContent.Visible = false
    VisualsContent.Visible = false
    MiscContent.Visible = false
    WeaponsContent.Visible = false
    
    for _, btn in ipairs(BottomBar:GetChildren()) do
        if btn:IsA("TextButton") then
            btn.BackgroundColor3 = Color3.fromRGB(30, 25, 40)
            btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
    end
    
    if tab == "Combat" then
        CombatContent.Visible = true
        CombatTab.BackgroundColor3 = Color3.fromRGB(180, 120, 255)
        CombatTab.TextColor3 = Color3.fromRGB(255, 255, 255)
    elseif tab == "Visuals" then
        VisualsContent.Visible = true
        VisualsTab.BackgroundColor3 = Color3.fromRGB(180, 120, 255)
        VisualsTab.TextColor3 = Color3.fromRGB(255, 255, 255)
    elseif tab == "Misc" then
        MiscContent.Visible = true
        MiscTab.BackgroundColor3 = Color3.fromRGB(180, 120, 255)
        MiscTab.TextColor3 = Color3.fromRGB(255, 255, 255)
    elseif tab == "Weapons" then
        WeaponsContent.Visible = true
        WeaponsTab.BackgroundColor3 = Color3.fromRGB(180, 120, 255)
        WeaponsTab.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end

CombatTab.MouseButton1Click:Connect(function() switchTab("Combat") end)
VisualsTab.MouseButton1Click:Connect(function() switchTab("Visuals") end)
MiscTab.MouseButton1Click:Connect(function() switchTab("Misc") end)
WeaponsTab.MouseButton1Click:Connect(function() switchTab("Weapons") end)

-- combat tab
createToggle(CombatContent, "Aimbot", UDim2.new(0, 0, 0, 5), function(v)
    _G.AimOn = v
    _G.fovTransparency = v and 1 or 0
end)

createToggle(CombatContent, "Team Check (Aimbot)", UDim2.new(0, 0, 0, 48), function(v)
    _G.TeamCheckOn = v
end)

createToggle(CombatContent, "Silent Aim", UDim2.new(0, 0, 0, 91), function(v)
    if v then
        task.spawn(function()
            while v and wait(1) do
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character then
                        pcall(function()
                            local parts = {"RightUpperLeg", "LeftUpperLeg", "HeadHB", "HumanoidRootPart"}
                            for _, partName in pairs(parts) do
                                local part = player.Character:FindFirstChild(partName)
                                if part then
                                    part.CanCollide = false
                                    part.Transparency = 1
                                    part.Size = Vector3.new(13, 13, 13)
                                end
                            end
                        end)
                    end
                end
            end
        end)
    end
end)

createDropdown(CombatContent, "Aim Part", UDim2.new(0, 0, 0, 134), {"Head", "UpperTorso", "HumanoidRootPart"}, function(v)
    _G.Aimpart = v
end)

createSlider(CombatContent, "Smoothness", UDim2.new(0, 0, 0, 177), 1, 20, 3, function(v)
    _G.Sensitivity = v / 100
end)

createSlider(CombatContent, "FOV Size", UDim2.new(0, 0, 0, 230), 50, 300, 100, function(v)
    _G.sizeof = v
end)

createToggle(CombatContent, "Prediction", UDim2.new(0, 0, 0, 283), function(v)
    _G.Prediction = v
end)

-- visuals tab
local espToggled = createToggle(VisualsContent, "Player ESP", UDim2.new(0, 0, 0, 5))

local espTeamCheck = createToggle(VisualsContent, "ESP Team Check", UDim2.new(0, 0, 0, 48))

createToggle(VisualsContent, "Draw FOV Circle", UDim2.new(0, 0, 0, 91), function(v)
    _G.CircleVisible = v
end)

createToggle(VisualsContent, "Rainbow Mode", UDim2.new(0, 0, 0, 134), function(v)
    _G.RainbowEnabled = v
end)

local fpsEnabled = createToggle(VisualsContent, "FPS Counter", UDim2.new(0, 0, 0, 177))

local pingEnabled = createToggle(VisualsContent, "Ping Display", UDim2.new(0, 0, 0, 220))

-- misc tab
local infJumpActive = false
createToggle(MiscContent, "Infinite Jump", UDim2.new(0, 0, 0, 5), function(v)
    infJumpActive = v
end)

uis.JumpRequest:Connect(function()
    if infJumpActive and LocalPlayer.Character then
        local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local platform = create("Part", {
                Size = Vector3.new(10, 0.5, 10),
                Position = hrp.Position - Vector3.new(0, 3.5, 0),
                Anchored = true,
                Transparency = 1,
                CanCollide = true,
                Parent = workspace
            })
            task.wait(0.1)
            platform:Destroy()
        end
    end
end)

createToggle(MiscContent, "Speed Hack", UDim2.new(0, 0, 0, 48), function(v)
    if v and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChild("Humanoid")
        if hum then
            hum:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
                if v then
                    hum.WalkSpeed = 100
                end
            end)
            hum.WalkSpeed = 100
        end
    end
end)

-- wallbang
local wallbangEnabled = false
local ignoredParts = {}
createToggle(MiscContent, "Wallbang", UDim2.new(0, 0, 0, 91), function(v)
    wallbangEnabled = v
    
    if v then
        task.spawn(function()
            local map = workspace:FindFirstChild("Map")
            if map then
                local ignore = map:FindFirstChild("Ignore")
                if not ignore then
                    ignore = create("Folder", {Name = "Ignore", Parent = map})
                end
                
                for _, folder in pairs(map:GetChildren()) do
                    if folder:IsA("Folder") and folder.Name ~= "Ignore" then
                        for _, part in pairs(folder:GetDescendants()) do
                            if part:IsA("BasePart") then
                                table.insert(ignoredParts, {part = part, originalParent = part.Parent})
                                part.Parent = ignore
                            end
                        end
                    end
                end
            end
        end)
    else
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
