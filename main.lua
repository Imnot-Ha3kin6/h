-- cool beanz menu v2 (rayfield version) 🫘

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua"))()

local Window = Rayfield:CreateWindow({
    Name = "Cool Beanz Menu V2",
    LoadingTitle = "Loading Cool Beanz...",
    LoadingSubtitle = "v2",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "CoolBeanzConfig"
    },
    Discord = {
        Enabled = false,
    },
    KeySystem = false,
})

-- Tabs
local ScriptsTab = Window:CreateTab("Scripts")
local ReskinsTab = Window:CreateTab("Reskins")
local GamesTab = Window:CreateTab("Games")

-- Scripts Tab
ScriptsTab:CreateSection("Universal")

ScriptsTab:CreateButton({
    Name = "Infinite Yield",
    Description = "admin go brrrr",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end,
})

ScriptsTab:CreateButton({
    Name = "Quotas Hub",
    Description = "Script hub by Insertl",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Insertl/QuotasHub/main/BETAv1.3"))()
    end,
})

-- Games Tab
GamesTab:CreateSection("Arsenal")

GamesTab:CreateButton({
    Name = "Arsenal Script",
    Description = "aimbot + esp + more",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/j0SWm1nr"))()
    end,
})

GamesTab:CreateSection("TSB")

GamesTab:CreateButton({
    Name = "Death Counter Identifier",
    Description = "Check your death counter (TSB)",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/louismich4el/ItsLouisPlayz-Scripts/main/TSB%20Death%20Counter%20Identifier.lua"))()
    end,
})

GamesTab:CreateButton({
    Name = "Instant Transmission",
    Description = "Teleport behind enemies (TSB)",
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
    end,
})

GamesTab:CreateSection("Troll / Cursing")

GamesTab:CreateButton({
    Name = "Better Bypasser",
    Description = "Bypasses chat filter",
    Callback = function()
        loadstring(game:HttpGet("https://github.com/Synergy-Networks/products/raw/main/BetterBypasser/loader.lua"))()
    end,
})

GamesTab:CreateSection("Bedwars")

GamesTab:CreateButton({
    Name = "Vape V4 Voidware",
    Description = "OP Bedwars script",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VWExtra/main/installer.lua", true))()
    end,
})

-- Reskins Tab
ReskinsTab:CreateSection("Saitama Reskins")

ReskinsTab:CreateButton({
    Name = "KJ Reskin",
    Description = "Reskins Saitama to KJ",
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
    end,
})

ReskinsTab:CreateButton({
    Name = "Gojo Reskin",
    Description = "Morph Saitama into Gojo",
    Callback = function()
        getgenv().morph = true
        loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletfan2007/BaldyToSorcerer/refs/heads/main/LatestV2.lua"))()
    end,
})
