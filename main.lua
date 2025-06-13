local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Cool Beanz Menu V2", "DarkTheme")

-- Tabs
local TabScripts = Window:NewTab("Scripts")
local TabReskins = Window:NewTab("Reskins")
local TabGames = Window:NewTab("Games")

-- Scripts Tab
local UniversalSection = TabScripts:NewSection("Universal")
UniversalSection:NewButton("Infinite Yield", "admin go brrrr", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

-- Games Tab
local ArsenalSection = TabGames:NewSection("Arsenal")
ArsenalSection:NewButton("Arsenal Script", "aimbot + esp + more", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/j0SWm1nr"))()
end)

local TSBSection = TabGames:NewSection("TSB")
TSBSection:NewButton("Instant Transmission", "Teleport behind enemies (TSB)", function()
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
end)

local TrollSection = TabGames:NewSection("Troll / Cursing")
TrollSection:NewButton("Better Bypasser", "Bypasses chat filter", function()
    loadstring(game:HttpGet("https://github.com/Synergy-Networks/products/raw/main/BetterBypasser/loader.lua"))()
end)

local BedwarsSection = TabGames:NewSection("Bedwars")
BedwarsSection:NewButton("Vape V4 Voidware", "OP Bedwars script", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VWExtra/main/installer.lua", true))()
end)

-- Reskins Tab
local ReskinSection = TabReskins:NewSection("Saitama Reskins")

ReskinSection:NewButton("KJ Reskin", "Reskins Saitama to KJ", function()
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
end)

ReskinSection:NewButton("Gojo Reskin", "Morph Saitama into Gojo", function()
    getgenv().morph = true
    loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletfan2007/BaldyToSorcerer/refs/heads/main/LatestV2.lua"))()
end)
