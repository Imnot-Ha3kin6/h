-- load fluent ui library (works great on mobile)
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- create window
local Window = Fluent:CreateWindow({
    Title = "✨ cool beanz menu v3 ✨",
    SubTitle = "made with 💜",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- create tabs
local Tabs = {
    Scripts = Window:AddTab({ Title = "🔥 scripts", Icon = "code" }),
    Games = Window:AddTab({ Title = "🎮 games", Icon = "gamepad-2" }),
    Reskins = Window:AddTab({ Title = "✨ reskins", Icon = "code" }),
    Settings = Window:AddTab({ Title = "⚙️ settings", Icon = "settings" })
}

-- universal scripts section
Tabs.Scripts:AddParagraph({
    Title = "🌐 universal scripts",
    Content = "scripts that work on every game"
})

Tabs.Scripts:AddButton({
    Title = "🔥 infinite yield reborn",
    Description = "universal admin commands",
    Callback = function()
        loadstring(game:HttpGet(('https://raw.githubusercontent.com/mxsynry/infiniteyield-reborn/refs/heads/scriptblox/source' or 'https://mxsynry.github.io/storage/iyrbackup/legacy/scriptblox/source')))()
        Fluent:Notify({
            Title = "infinite yield reborn",
            Content = "loaded twin 🙏",
            Duration = 3
        })
    end
})

Tabs.Scripts:AddButton({
    Title = "🐋 orca universal",
    Description = "open-source universal script",
    Callback = function()
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/richie0866/orca/master/public/latest.lua"))()
        Fluent:Notify({
            Title = "orca universal",
            Content = "loaded gng 💀",
            Duration = 3
        })
    end
})

Tabs.Scripts:AddButton({
    Title = "🌟 scriptcentral hub",
    Description = "tons of game scripts",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ScriptCentral-br/SCU/refs/heads/main/sc.md",true))()
        Fluent:Notify({
            Title = "scriptcentral",
            Content = "loaded twin 💀",
            Duration = 3
        })
    end
})

Tabs.Scripts:AddButton({
    Title = "💙 bluered hub",
    Description = "100+ games supported",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Shife2/BlueRed-Script/main/new.lua"))()
        Fluent:Notify({
            Title = "bluered hub",
            Content = "loaded gng 🙏",
            Duration = 3
        })
    end
})

-- utility scripts section
Tabs.Scripts:AddParagraph({
    Title = "🛠️ utility scripts",
    Content = "useful tools for any game"
})

Tabs.Scripts:AddButton({
    Title = "👁️ esp players",
    Description = "see all players through walls",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/xt-el/ESP-Players/refs/heads/main/ESP"))()
        Fluent:Notify({
            Title = "esp players",
            Content = "see everyone now 😭",
            Duration = 3
        })
    end
})

Tabs.Scripts:AddButton({
    Title = "✈️ fly script",
    Description = "universal fly",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/JNHHGaming/Fly/refs/heads/main/Fly",true))()
        Fluent:Notify({
            Title = "fly script",
            Content = "loaded gng 🔥",
            Duration = 3
        })
    end
})

Tabs.Scripts:AddButton({
    Title = "💫 fling script",
    Description = "ultimate fling gui",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/K1LAS1K/Ultimate-Fling-GUI/main/flingscript.lua"))()
        Fluent:Notify({
            Title = "fling script",
            Content = "lets troll twin 😭",
            Duration = 3
        })
    end
})

-- arsenal section
Tabs.Games:AddParagraph({
    Title = "🔫 arsenal",
    Content = "arsenal game scripts"
})

Tabs.Games:AddButton({
    Title = "🌟 insanity.xyz",
    Description = "insanity arsenal script",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/jaysterrz/insanity.xyz/refs/heads/main/InsanityLoader.lua"))()
        Fluent:Notify({
            Title = "insanity.xyz",
            Content = "loaded twin 🙏",
            Duration = 3
        })
    end
})

Tabs.Games:AddButton({
    Title = "😂 timmys hub",
    Description = "timmys hub lmaoo",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/WinzeTim/timmyhack2/refs/heads/main/arsenal.lua'))()
        Fluent:Notify({
            Title = "timmys hub",
            Content = "loaded gng 💀",
            Duration = 3
        })
    end
})

-- tsb section
Tabs.Games:AddParagraph({
    Title = "💪 the strongest battlegrounds",
    Content = "tsb scripts"
})

Tabs.Games:AddButton({
    Title = "📊 death counter",
    Description = "see who struggling lmao",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/louismich4el/ItsLouisPlayz-Scripts/main/TSB%20Death%20Counter%20Identifier.lua"))()
        Fluent:Notify({
            Title = "death counter",
            Content = "loaded twin 🙏",
            Duration = 3
        })
    end
})

Tabs.Games:AddButton({
    Title = "⚡ instant transmission",
    Description = "teleport to cursor location",
    Callback = function()
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
        
        Fluent:Notify({
            Title = "instant transmission",
            Content = "tool added 💀",
            Duration = 3
        })
    end
})

-- bedwars section
Tabs.Games:AddParagraph({
    Title = "🛏️ bedwars",
    Content = "bedwars scripts"
})

Tabs.Games:AddButton({
    Title = "🌙 vape v4 voidware",
    Description = "best bedwars client",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VWExtra/main/installer.lua", true))()
        Fluent:Notify({
            Title = "vape v4",
            Content = "loaded gng 🔥",
            Duration = 3
        })
    end
})

-- blade ball section
Tabs.Games:AddParagraph({
    Title = "⚔️ blade ball",
    Content = "blade ball scripts"
})

Tabs.Games:AddButton({
    Title = "🔮 shadow blade ball",
    Description = "shadow team script",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ShadowBey01/SHWX-Team-Rise-Scripts/refs/heads/main/SomeStuff/HzShadow%20Lua%20Obfuscator/protected-file-1.lua"))()
        Fluent:Notify({
            Title = "shadow blade ball",
            Content = "loaded twin 🙏",
            Duration = 3
        })
    end
})

-- saitama reskins
Tabs.Reskins:AddParagraph({
    Title = "👊 saitama reskins",
    Content = "tsb character reskins"
})

Tabs.Reskins:AddButton({
    Title = "🔴 kj reskin",
    Description = "turn saitama into kj",
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
        Fluent:Notify({
            Title = "kj reskin",
            Content = "you kj now twin 💀",
            Duration = 3
        })
    end
})

Tabs.Reskins:AddButton({
    Title = "🔵 gojo reskin",
    Description = "turn saitama into gojo",
    Callback = function()
        getgenv().morph = true
        loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletfan2007/BaldyToSorcerer/refs/heads/main/LatestV2.lua"))()
        Fluent:Notify({
            Title = "gojo reskin",
            Content = "you gojo now gng 🙏",
            Duration = 3
        })
    end
})

-- info section
Tabs.Reskins:AddParagraph({
    Title = "ℹ️ menu info",
    Content = "cool beanz menu v3\nmade with 💜\nstatus: undetected ✅\nmobile support: yes 📱\n\nenjoy the menu twin 🙏"
})

-- setup settings tab with proper sections
local SettingsSection = Tabs.Settings:AddSection("ui settings")

Tabs.Settings:AddButton({
    Title = "🎨 change theme",
    Description = "click to cycle through themes",
    Callback = function()
        local themes = {"Dark", "Darker", "Light", "Aqua", "Amethyst", "Rose"}
        local currentIndex = 1
        
        for i, theme in ipairs(themes) do
            if Fluent.Theme == theme then
                currentIndex = i
                break
            end
        end
        
        currentIndex = currentIndex + 1
        if currentIndex > #themes then
            currentIndex = 1
        end
        
        Fluent:SetTheme(themes[currentIndex])
        Fluent:Notify({
            Title = "theme changed",
            Content = "switched to " .. themes[currentIndex] .. " theme 🎨",
            Duration = 2
        })
    end
})

Tabs.Settings:AddButton({
    Title = "💾 save config",
    Description = "save your settings",
    Callback = function()
        SaveManager:Save()
        Fluent:Notify({
            Title = "config saved",
            Content = "settings saved gng 🙏",
            Duration = 2
        })
    end
})

Tabs.Settings:AddButton({
    Title = "📂 load config",
    Description = "load saved settings",
    Callback = function()
        SaveManager:Load()
        Fluent:Notify({
            Title = "config loaded",
            Content = "settings loaded twin 💜",
            Duration = 2
        })
    end
})

Tabs.Settings:AddParagraph({
    Title = "⚙️ about settings",
    Content = "your configs are saved automatically!\nthemes available: dark, darker, light, aqua, amethyst, rose"
})

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})

InterfaceManager:SetFolder("cool_beanz_menu")
SaveManager:SetFolder("cool_beanz_menu/configs")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

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

-- select first tab
Window:SelectTab(1)

-- welcome notification
Fluent:Notify({
    Title = "✨ cool beanz menu v3 ✨",
    Content = "loaded twin lets get it 🔥💜",
    Duration = 5
})
