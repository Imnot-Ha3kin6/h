-- load linoria ui library (works on mobile)
local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

-- create window with custom styling
local Window = Library:CreateWindow({
    Title = '✨ cool beanz menu v3 ✨',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.3
})

-- custom theme setup
Library:SetWatermarkVisibility(false)

-- add watermark with custom text
Library:SetWatermark('cool beanz menu v3 💜 | ' .. os.date('%H:%M:%S'))

-- update watermark every second
task.spawn(function()
    while true do
        wait(1)
        Library:SetWatermark('cool beanz menu v3 💜 | ' .. os.date('%H:%M:%S'))
    end
end)

-- create tabs with icons
local Tabs = {
    Scripts = Window:AddTab('🔥 scripts'),
    Games = Window:AddTab('🎮 games'),
    Reskins = Window:AddTab('✨ reskins'),
    ['UI Settings'] = Window:AddTab('⚙️ settings'),
}

-- add welcome message
Library:Notify('welcome to cool beanz menu v3 💜', 3)

-- scripts tab
local ScriptsGroupBox = Tabs.Scripts:AddLeftGroupbox('🌐 universal scripts')

ScriptsGroupBox:AddButton({
    Text = '🔥 infinite yield reborn',
    Func = function()
        loadstring(game:HttpGet(('https://raw.githubusercontent.com/mxsynry/infiniteyield-reborn/refs/heads/scriptblox/source' or 'https://mxsynry.github.io/storage/iyrbackup/legacy/scriptblox/source')))()
        Library:Notify('infinite yield reborn loaded twin 🙏', 3)
    end,
    DoubleClick = false,
    Tooltip = 'universal admin commands reborn'
})

ScriptsGroupBox:AddButton({
    Text = '🐋 orca universal',
    Func = function()
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/richie0866/orca/master/public/latest.lua"))()
        Library:Notify('orca universal loaded gng 💀', 3)
    end,
    DoubleClick = false,
    Tooltip = 'free and open-source universal script'
})

ScriptsGroupBox:AddButton({
    Text = '🌟 scriptcentral hub',
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ScriptCentral-br/SCU/refs/heads/main/sc.md",true))()
        Library:Notify('scriptcentral loaded twin 💀', 3)
    end,
    DoubleClick = false,
    Tooltip = 'tons of game scripts in one hub'
})

ScriptsGroupBox:AddButton({
    Text = '💙 bluered hub',
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Shife2/BlueRed-Script/main/new.lua"))()
        Library:Notify('bluered hub loaded gng 100+ games 🙏', 3)
    end,
    DoubleClick = false,
    Tooltip = '100+ games supported'
})

local ScriptsGroupBox2 = Tabs.Scripts:AddRightGroupbox('🛠️ utility scripts')

ScriptsGroupBox2:AddButton({
    Text = '👁️ esp players',
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/xt-el/ESP-Players/refs/heads/main/ESP"))()
        Library:Notify('esp loaded twin see everyone now 😭', 3)
    end,
    DoubleClick = false,
    Tooltip = 'see all players through walls'
})

ScriptsGroupBox2:AddButton({
    Text = '✈️ fly script',
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/JNHHGaming/Fly/refs/heads/main/Fly",true))()
        Library:Notify('fly script loaded gng 🔥', 3)
    end,
    DoubleClick = false,
    Tooltip = 'universal fly script'
})

ScriptsGroupBox2:AddButton({
    Text = '💫 fling script',
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/K1LAS1K/Ultimate-Fling-GUI/main/flingscript.lua"))()
        Library:Notify('fling script loaded twin lets troll 😭', 3)
    end,
    DoubleClick = false,
    Tooltip = 'ultimate fling gui'
})

-- add divider
ScriptsGroupBox2:AddDivider()

ScriptsGroupBox2:AddLabel('more scripts coming soon 💜')

-- games tab
local ArsenalBox = Tabs.Games:AddLeftGroupbox('🔫 arsenal')

ArsenalBox:AddButton({
    Text = '🌟 insanity.xyz',
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/jaysterrz/insanity.xyz/refs/heads/main/InsanityLoader.lua"))()
        Library:Notify('insanity.xyz loaded twin 🙏', 3)
    end,
    DoubleClick = false,
    Tooltip = 'insanity arsenal script'
})

ArsenalBox:AddButton({
    Text = '😂 timmys hub',
    Func = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/WinzeTim/timmyhack2/refs/heads/main/arsenal.lua'))()
        Library:Notify('timmys hub loaded gng 💀', 3)
    end,
    DoubleClick = false,
    Tooltip = 'timmys hub lmaoo'
})

local TSBBox = Tabs.Games:AddRightGroupbox('💪 tsb')

TSBBox:AddButton({
    Text = '📊 death counter',
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/louismich4el/ItsLouisPlayz-Scripts/main/TSB%20Death%20Counter%20Identifier.lua"))()
        Library:Notify('death counter loaded twin 🙏', 3)
    end,
    DoubleClick = false,
    Tooltip = 'see who struggling lmao'
})

TSBBox:AddButton({
    Text = '⚡ instant transmission',
    Func = function()
        local mouse = game.Players.LocalPlayer:GetMouse()
        local tool = Instance.new("Tool")
        tool.RequiresHandle = false
        tool.Name = "instant transmission"

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
        
        Library:Notify('tool added to backpack 💀', 3)
    end,
    DoubleClick = false,
    Tooltip = 'teleport to cursor location'
})

local BedwarsBox = Tabs.Games:AddLeftGroupbox('🛏️ bedwars')

BedwarsBox:AddButton({
    Text = '🌙 vape v4 voidware',
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VWExtra/main/installer.lua", true))()
        Library:Notify('vape v4 loaded gng 🔥', 3)
    end,
    DoubleClick = false,
    Tooltip = 'best bedwars client ngl'
})

local BladeBallBox = Tabs.Games:AddRightGroupbox('⚔️ blade ball')

BladeBallBox:AddButton({
    Text = '🔮 shadow blade ball',
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ShadowBey01/SHWX-Team-Rise-Scripts/refs/heads/main/SomeStuff/HzShadow%20Lua%20Obfuscator/protected-file-1.lua"))()
        Library:Notify('shadow blade ball loaded twin 🙏', 3)
    end,
    DoubleClick = false,
    Tooltip = 'shadow team blade ball script'
})

-- add spacing
BladeBallBox:AddDivider()
BladeBallBox:AddLabel('more game scripts coming soon 💜')

-- reskins tab
local SaitamaBox = Tabs.Reskins:AddLeftGroupbox('👊 saitama reskins')

SaitamaBox:AddButton({
    Text = '🔴 kj reskin',
    Func = function()
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
            ["UltNames"] = { "20 series", },
            ["MoveNames"] = {
                ["Normal Punch"] = "ravaging kick",
                ["Consecutive Punches"] = "fist fusillade",
                ["Shove"] = "swift sweep",
                ["Uppercut"] = "collateral storm",
                ["Death Counter"] = "sudden strike",
                ["Table Flip"] = "stoic bomb",
                ["Serious Punch"] = "limited flex works",
                ["Omni Directional Punch"] = "omni directional fists"
            }
        }
        loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletfan2007/BaldyToKJ/refs/heads/main/Latest.lua"))()
        Library:Notify('kj reskin loaded twin you kj now 💀', 3)
    end,
    DoubleClick = false,
    Tooltip = 'turn saitama into kj'
})

SaitamaBox:AddButton({
    Text = '🔵 gojo reskin',
    Func = function()
        getgenv().morph = true
        loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletfan2007/BaldyToSorcerer/refs/heads/main/LatestV2.lua"))()
        Library:Notify('gojo reskin loaded gng you gojo now 🙏', 3)
    end,
    DoubleClick = false,
    Tooltip = 'turn saitama into gojo'
})

-- add info section
local InfoBox = Tabs.Reskins:AddRightGroupbox('ℹ️ info')

InfoBox:AddLabel('cool beanz menu v3')
InfoBox:AddLabel('made with 💜')
InfoBox:AddDivider()
InfoBox:AddLabel('status: undetected ✅')
InfoBox:AddLabel('mobile support: yes 📱')
InfoBox:AddDivider()
InfoBox:AddLabel('enjoy the menu twin 🙏')

-- animation lock script
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function onCharacterAdded(character)
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")

    local ANIM_ID_TO_LOCK = 16431491215

    local originalCFrame = nil
    local isLocked = false

    game:GetService("RunService").Heartbeat:Connect(function()
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

if LocalPlayer.Character then
    onCharacterAdded(LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

-- ui settings
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})

ThemeManager:SetFolder('cool_beanz_menu')
SaveManager:SetFolder('cool_beanz_menu/configs')

-- add cool beanz custom theme to built-in themes
local httpService = game:GetService('HttpService')
ThemeManager.BuiltInThemes['Cool Beanz'] = { 
    9, 
    httpService:JSONDecode('{"FontColor":"8cd2ff","MainColor":"285f87","AccentColor":"87afff","BackgroundColor":"49499b","OutlineColor":"8b8b8b"}') 
}

SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])

-- apply cool beanz theme by default
ThemeManager:ApplyTheme('Cool Beanz')

-- load auto config
SaveManager:LoadAutoloadConfig()

-- final notification
task.wait(1)
Library:Notify('✨ cool beanz menu v3 loaded ✨', 5)
Library:Notify('lets get it twin 🔥💜', 4)
