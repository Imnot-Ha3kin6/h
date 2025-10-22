-- load rayfield ui library (best for mobile)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- create window with custom theme
local Window = Rayfield:CreateWindow({
   Name = "✨ cool beanz menu v3 ✨",
   LoadingTitle = "cool beanz menu",
   LoadingSubtitle = "by cool beanz",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "cool_beanz_menu",
      FileName = "config"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = false,
   KeySettings = {
      Title = "cool beanz menu",
      Subtitle = "Key System",
      Note = "no key needed",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"beanz"}
   }
})

-- custom theme colors
Rayfield:LoadTheme({
    Background = Color3.fromRGB(73, 73, 155),
    MainColor = Color3.fromRGB(40, 95, 135),
    AccentColor = Color3.fromRGB(135, 175, 255),
    OutlineColor = Color3.fromRGB(139, 139, 139),
    FontColor = Color3.fromRGB(140, 210, 255)
})

-- create tabs
local ScriptsTab = Window:CreateTab("🔥 scripts", nil)
local GamesTab = Window:CreateTab("🎮 games", nil)
local ReskinsTab = Window:CreateTab("✨ reskins", nil)

-- scripts tab sections
local UniversalSection = ScriptsTab:CreateSection("🌐 universal scripts")

ScriptsTab:CreateButton({
   Name = "🔥 infinite yield reborn",
   Callback = function()
      loadstring(game:HttpGet(('https://raw.githubusercontent.com/mxsynry/infiniteyield-reborn/refs/heads/scriptblox/source' or 'https://mxsynry.github.io/storage/iyrbackup/legacy/scriptblox/source')))()
      Rayfield:Notify({
         Title = "infinite yield reborn",
         Content = "loaded twin 🙏",
         Duration = 3,
         Image = nil,
      })
   end,
})

ScriptsTab:CreateButton({
   Name = "🐋 orca universal",
   Callback = function()
      loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/richie0866/orca/master/public/latest.lua"))()
      Rayfield:Notify({
         Title = "orca universal",
         Content = "loaded gng 💀",
         Duration = 3,
         Image = nil,
      })
   end,
})

ScriptsTab:CreateButton({
   Name = "🌟 scriptcentral hub",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/ScriptCentral-br/SCU/refs/heads/main/sc.md",true))()
      Rayfield:Notify({
         Title = "scriptcentral",
         Content = "loaded twin 💀",
         Duration = 3,
         Image = nil,
      })
   end,
})

ScriptsTab:CreateButton({
   Name = "💙 bluered hub",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Shife2/BlueRed-Script/main/new.lua"))()
      Rayfield:Notify({
         Title = "bluered hub",
         Content = "loaded gng 100+ games 🙏",
         Duration = 3,
         Image = nil,
      })
   end,
})

local UtilitySection = ScriptsTab:CreateSection("🛠️ utility scripts")

ScriptsTab:CreateButton({
   Name = "👁️ esp players",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/xt-el/ESP-Players/refs/heads/main/ESP"))()
      Rayfield:Notify({
         Title = "esp players",
         Content = "see everyone now 😭",
         Duration = 3,
         Image = nil,
      })
   end,
})

ScriptsTab:CreateButton({
   Name = "✈️ fly script",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/JNHHGaming/Fly/refs/heads/main/Fly",true))()
      Rayfield:Notify({
         Title = "fly script",
         Content = "loaded gng 🔥",
         Duration = 3,
         Image = nil,
      })
   end,
})

ScriptsTab:CreateButton({
   Name = "💫 fling script",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/K1LAS1K/Ultimate-Fling-GUI/main/flingscript.lua"))()
      Rayfield:Notify({
         Title = "fling script",
         Content = "lets troll twin 😭",
         Duration = 3,
         Image = nil,
      })
   end,
})

-- games tab sections
local ArsenalSection = GamesTab:CreateSection("🔫 arsenal")

GamesTab:CreateButton({
   Name = "🌟 insanity.xyz",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/jaysterrz/insanity.xyz/refs/heads/main/InsanityLoader.lua"))()
      Rayfield:Notify({
         Title = "insanity.xyz",
         Content = "loaded twin 🙏",
         Duration = 3,
         Image = nil,
      })
   end,
})

GamesTab:CreateButton({
   Name = "😂 timmys hub",
   Callback = function()
      loadstring(game:HttpGet('https://raw.githubusercontent.com/WinzeTim/timmyhack2/refs/heads/main/arsenal.lua'))()
      Rayfield:Notify({
         Title = "timmys hub",
         Content = "loaded gng 💀",
         Duration = 3,
         Image = nil,
      })
   end,
})

local TSBSection = GamesTab:CreateSection("💪 tsb")

GamesTab:CreateButton({
   Name = "📊 death counter",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/louismich4el/ItsLouisPlayz-Scripts/main/TSB%20Death%20Counter%20Identifier.lua"))()
      Rayfield:Notify({
         Title = "death counter",
         Content = "loaded twin 🙏",
         Duration = 3,
         Image = nil,
      })
   end,
})

GamesTab:CreateButton({
   Name = "⚡ instant transmission",
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
      
      Rayfield:Notify({
         Title = "instant transmission",
         Content = "tool added to backpack 💀",
         Duration = 3,
         Image = nil,
      })
   end,
})

local BedwarsSection = GamesTab:CreateSection("🛏️ bedwars")

GamesTab:CreateButton({
   Name = "🌙 vape v4 voidware",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VWExtra/main/installer.lua", true))()
      Rayfield:Notify({
         Title = "vape v4",
         Content = "loaded gng 🔥",
         Duration = 3,
         Image = nil,
      })
   end,
})

local BladeBallSection = GamesTab:CreateSection("⚔️ blade ball")

GamesTab:CreateButton({
   Name = "🔮 shadow blade ball",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/ShadowBey01/SHWX-Team-Rise-Scripts/refs/heads/main/SomeStuff/HzShadow%20Lua%20Obfuscator/protected-file-1.lua"))()
      Rayfield:Notify({
         Title = "shadow blade ball",
         Content = "loaded twin 🙏",
         Duration = 3,
         Image = nil,
      })
   end,
})

-- reskins tab
local SaitamaSection = ReskinsTab:CreateSection("👊 saitama reskins")

ReskinsTab:CreateButton({
   Name = "🔴 kj reskin",
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
      Rayfield:Notify({
         Title = "kj reskin",
         Content = "you kj now twin 💀",
         Duration = 3,
         Image = nil,
      })
   end,
})

ReskinsTab:CreateButton({
   Name = "🔵 gojo reskin",
   Callback = function()
      getgenv().morph = true
      loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletfan2007/BaldyToSorcerer/refs/heads/main/LatestV2.lua"))()
      Rayfield:Notify({
         Title = "gojo reskin",
         Content = "you gojo now gng 🙏",
         Duration = 3,
         Image = nil,
      })
   end,
})

local InfoSection = ReskinsTab:CreateSection("ℹ️ info")

ReskinsTab:CreateLabel("cool beanz menu v3")
ReskinsTab:CreateLabel("made with 💜")
ReskinsTab:CreateLabel("status: undetected ✅")
ReskinsTab:CreateLabel("mobile support: yes 📱")

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

-- welcome notification
Rayfield:Notify({
   Title = "✨ cool beanz menu v3 ✨",
   Content = "loaded twin lets get it 🔥💜",
   Duration = 5,
   Image = nil,
})
