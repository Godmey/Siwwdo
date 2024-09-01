getgenv().Config1 = {
  ["Distance From Mob"] = 4
}

function UpStats(stat)
    game:GetService("ReplicatedStorage").Events.UpgradeStat:FireServer(stat)
end

local NameMap = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

function GetName(Folder, Class)
    local names = {}
    for _, v in pairs(Folder:GetChildren()) do
        if v:IsA(Class) then
            table.insert(names, v.Name)
        end
    end
    return names
end

function __AttackMon()
game:GetService('VirtualUser'):CaptureController()
game:GetService('VirtualUser'):ClickButton1(Vector2.new(9999999, 99999999), game:GetService("Workspace").Camera.CFrame)
end

function TP(cframe)
    pcall(function()
        local character = game.Players.LocalPlayer.Character
        if character and character.PrimaryPart then
            character:SetPrimaryPartCFrame(cframe)
        end
    end)
end

local Map = GetName(workspace.Map.SpawnLocation, "Part")
local Wea = GetName(game.Players.LocalPlayer.Backpack, "Tool")
local NameBoss = GetName(game.ReplicatedStorage.BossCharacters, "Model")

local NPC = {}
for _, v in pairs(workspace.Map.NPC:GetChildren()) do
    if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then
        table.insert(NPC, v.Name)
    end
end

function __Equip()
    pcall(function()
      game.Players.LocalPlayer.Character.Humanoid:EquipTool(game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(getgenv().Weapon))
    end)
end

function __RedeemCode()
  for _, v in pairs(game.Players.LocalPlayer["LevelFolder"]:GetChildren()) do
        if v:IsA("BoolValue") and v.Name:find("Code") then
            local Code = v.Name:gsub("Code", "")
            game:GetService("ReplicatedStorage").Events.RedeemCodes:FireServer(Code)
            wait(0.3)
        end
    end
end

local CFSPBOSS = workspace.Map.NPC.BossSpawnerNPC.HumanoidRootPart.CFrame

local Mon = {}
local Names = {}
local NoCheckX = {
    "nil"
}

for _, v in pairs(workspace.Npcs:GetChildren()) do
    if v:IsA("Model") then
        if not Names[v.Name] and not table.find(NoCheckX, v.Name) then
            Names[v.Name] = true
            table.insert(Mon, v.Name)
        end
    end
end

local Dismee = 2

local KillUi = loadstring(game:HttpGet("https://raw.githubusercontent.com/Godmey/KillHubUi.lua/main/UI.lua"))()
local Window = KillUi:Window("Free | "..NameMap)

local M1 = Window:Tab("Boss","rbxassetid://15712717270")
local M6 = Window:Tab("Mon","rbxassetid://15712717270")
local M2 = Window:Tab("Stats","rbxassetid://15712717270")
local M3 = Window:Tab("Teleport","rbxassetid://15712717270")
local M4 = Window:Tab("Item","rbxassetid://15712717270")
local M5 = Window:Tab("Misc","rbxassetid://15712717270")


M1:Seperator("Select Boss")
M1:Dropdown("Select Spawn", {"Currency","Item"}, function(SW)
    getgenv().SelSpawn = SW
end)

M1:Dropdown("Select Boss", NameBoss, function(SW2)
    getgenv().SelSpawn2 = SW2
end)

M1:Seperator("Auto Boss")

local MMMM = M1:Label("")
_G.Check = true

M1:Toggle("Auto Farm Boss and Spawn", false, function(Fm)
    getgenv().Farm = Fm
end)

M1:Toggle("Auto Farm Boss", false, function(FM2)
    getgenv().Farm2 = Fm2
end)
M6:Seperator("Auto Farm Monster")
M6:Dropdown("Select Monster", Mon, function(FMo)
    getgenv().Monster = FMo
end)
M6:Toggle("Auto Monster", false, function(MON)
    getgenv().MoS = MON
end)

M6:Seperator("SeaBeast")
local abcHee = M6:Label("")
M6:Toggle("Auto SeaBeast", false, function(Se)
    getgenv().Sea = Se
end)

M2:Seperator("Up-Stats")
M2:Toggle("Strength", false, function(Strength)
    getgenv().Strength = Strength
    while getgenv().Strength do wait()
      UpStats("Strength")
    end
end)
M2:Toggle("Durability", false, function(Durability)
    getgenv().Durability = Durability
    while getgenv().Durability do wait()
      UpStats("Durability")
    end
end)
M2:Toggle("Sword", false, function(Sword)
    getgenv().Sword = Sword
    while getgenv().Sword do wait()
      UpStats("Sword")
    end
end)
M2:Toggle("Devilfruit", false, function(Devilfruit)
    getgenv().Devilfruit = Devilfruit
    while getgenv().Devilfruit do wait()
      UpStats("Devilfruit")
    end
end)
M2:Toggle("Special", false, function(Special)
    getgenv().Special = Special
    while getgenv().Special do wait()
      UpStats("Special")
    end
end)


M3:Seperator("Teleport Island")
M3:Dropdown("Select Island", Map, function(Val)
    getgenv().SeeMap = Val
end)
M3:Button("Teleport Island", function()
   TP(game.workspace.Map.SpawnLocation[getgenv().SeeMap].CFrame * CFrame.new(0,10,0))
end)

M3:Seperator("Teleport NPC")
M3:Dropdown("Select Island", NPC, function(Valu)
    getgenv().SeeNPC = Valu
end)
M3:Button("Teleport Island", function()
    for _, v in pairs(workspace.Map.NPC:GetChildren()) do
        if v.Name == getgenv().SeeNPC then
            TP(v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3))
        end
    end
end)

M4:Button("Redeem all Code", function()
    __RedeemCode()
end)


M4:Seperator("Random")
M4:Toggle("Auto Random Item", false, function(Ran)
    getgenv().Auto = Ran
end)
M4:Toggle("Auto Random Family", false, function(Fmm)
    getgenv().Family = Fmm
     while getgenv().Family do wait()
game:GetService("ReplicatedStorage").Events.SpinFamily:FireServer("Normal")
    end
end)
M4:Toggle("Auto Random Traits", false, function(Race)
    getgenv().Racc = Race
     while getgenv().Racc do wait()
game:GetService("ReplicatedStorage").Events.SpinTrait:FireServer("Normal")
    end
end)




M4:Toggle("Auto Collect Chest", false, function(Ch)
    getgenv().Chest = Ch
end)

M5:Seperator("Select Weapon")

M5:Dropdown("Select Weapon", Wea, function(vbm)
    getgenv().Weapon = vbm
end)

M5:Seperator("One Shot")
M5:Toggle("One Shot Boss", false, function(Ki)
    getgenv().Kill = Ki
end)
M5:Toggle("One Shot Monster", false, function(Ki2)
    getgenv().Kill2 = Ki2
end)





spawn(function()
    while wait(0.3) do
        if getgenv().Chest then
            pcall(function()
                for _, v in pairs(game:GetService("Workspace").ChestLoc:GetDescendants()) do
                    if v:IsA("Model") and v:FindFirstChild("Hinge") then
                        TP(v.Hinge.CFrame * CFrame.new(0, 5, 0))
                        for _, y in pairs(v:GetDescendants()) do
                            if y:IsA("ProximityPrompt") then
                                fireproximityprompt(y, 30)
                                break
                            end
                        end
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Farm then
            pcall(function()
                local ModelABC = false
                for _, mob in pairs(workspace.BossSpawns.BossSpawn:GetChildren()) do
                    if mob:IsA("Model") and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") then
                        ModelABC = true
                        local humanoid = mob:FindFirstChild("Humanoid")
                        humanoid.WalkSpeed = 0
                        humanoid.JumpPower = 0
                        repeat
                            wait()
                            __Equip()
                            __AttackMon()
                            if humanoid.Health > 1 then
                                TP(mob.HumanoidRootPart.CFrame * CFrame.new(0, Dismee, getgenv().Config1["Distance From Mob"]))
                            end
                        until not getgenv().Farm or humanoid.Health <= 0
                    end
                end
                if not ModelABC then
                    if getgenv().SelSpawn == "Currency" then
                      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFSPBOSS * CFrame.new(0,5,0)
                      wait(0.1)
                        local args = {getgenv().SelSpawn2, "Currency"}
                        game:GetService("ReplicatedStorage").Events.BossSpawner:FireServer(unpack(args))
                    elseif getgenv().SelSpawn == "Item" then
                      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFSPBOSS * CFrame.new(0,5,0)
                      wait(0.1)
                        local args = {getgenv().SelSpawn2, "Item"}
                        game:GetService("ReplicatedStorage").Events.BossSpawner:FireServer(unpack(args))
                    end
                end
            end)
        end
    end
end)

spawn(function()
    while wait() do
        if getgenv().Farm2 then
            pcall(function()
                for _, mob in pairs(workspace.BossSpawns.BossSpawn:GetChildren()) do
                    if mob:IsA("Model") and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") then
                        local humanoid = mob:FindFirstChild("Humanoid")
                        humanoid.WalkSpeed = 0
                        humanoid.JumpPower = 0
                        repeat
                            wait()
                            __Equip()
                            __AttackMon()
                            TP(mob.HumanoidRootPart.CFrame * CFrame.new(0, Dismee, getgenv().Config1["Distance From Mob"]))
                        until not getgenv().Farm2
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().MoS then
            pcall(function()
                for _, v in pairs(workspace.Npcs:GetChildren()) do
                    if v:IsA("Model") and v.Name == getgenv().Monster and v:FindFirstChildOfClass("Humanoid") and v.Humanoid.Health > 0 then
                        v.Humanoid.WalkSpeed = 0
                        v.Humanoid.JumpPower = 0
                        repeat
                            wait()
                            __Equip()
                            __AttackMon()
                            TP(mob.HumanoidRootPart.CFrame * CFrame.new(0, Dismee, getgenv().Config1["Distance From Mob"]))
                        until not getgenv().MoS or v.Humanoid.Health <= 0
                    end
                end
            end)
        end
    end
end)

spawn(function()
    while wait() do
        if getgenv().Sea then
            pcall(function()
                for _, v in pairs(workspace:GetChildren()) do
                    if v.Name == "SeaBeast" and v:FindFirstChildOfClass("Humanoid") and v.Humanoid.Health > 0 then
                        v.Humanoid.WalkSpeed = 0
                        v.Humanoid.JumpPower = 0
                        repeat
                            wait()
                            __Equip()
                            __AttackMon()
                            TP(v.HumanoidRootPart.CFrame * CFrame.new(0,0,5))
                        until not getgenv().Sea or v.Humanoid.Health <= 0
                    end
                end
            end)
        end
    end
end)

spawn(function()
    while wait() do
        pcall(function()
            if getgenv().Auto then
                for _, v in pairs(workspace.Map.NPC.Random5X:GetDescendants()) do
                    if v:FindFirstChildOfClass("ProximityPrompt") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =  workspace.Map.NPC.Random5X.HumanoidRootPart.CFrame * CFrame.new(0,0,3)
                        fireproximityprompt(v:FindFirstChildOfClass("ProximityPrompt"), 30)
                    end
                end
            end
        end)
    end
end)

local radius = 15
spawn(function()
    while wait(0.2) do
        pcall(function()
            if getgenv().Kill then
              local player = game.Players.LocalPlayer
              local character = player.Character or player.CharacterAdded:Wait()
                sethiddenproperty(player, "SimulationRadius", 112412400000)
                sethiddenproperty(player, "MaxSimulationRadius", 112412400000)
                for _, v in pairs(workspace.BossSpawns.BossSpawn:GetDescendants()) do
                    if v:IsA("Humanoid") and v.Parent and v.Parent:IsA("Model") then
                        local npcPosition = v.Parent:FindFirstChild("HumanoidRootPart") and v.Parent.HumanoidRootPart.Position
                        local playerPosition = character:FindFirstChild("HumanoidRootPart") and character.HumanoidRootPart.Position
                        if npcPosition and playerPosition and (npcPosition - playerPosition).Magnitude <= 15 then
                            if v.Health < v.MaxHealth then
                              wait(.1)
                                v.Health = 0
                            end
                        end
                    end
                end
            end
        end)
    end
end)
local radius = 15
spawn(function()
    while wait(0.2) do
        pcall(function()
            if getgenv().Kill2 then
              local player = game.Players.LocalPlayer
              local character = player.Character or player.CharacterAdded:Wait()
                sethiddenproperty(player, "SimulationRadius", 112412400000)
                sethiddenproperty(player, "MaxSimulationRadius", 112412400000)
                for _, v in pairs(workspace.Npcs:GetDescendants()) do
                    if v:IsA("Humanoid") and v.Parent and v.Parent:IsA("Model") then
                        local npcPosition = v.Parent:FindFirstChild("HumanoidRootPart") and v.Parent.HumanoidRootPart.Position
                        local playerPosition = character:FindFirstChild("HumanoidRootPart") and character.HumanoidRootPart.Position
                        if npcPosition and playerPosition and (npcPosition - playerPosition).Magnitude <= 15 then
                            if v.Health < v.MaxHealth then
                              wait(.1)
                                v.Health = 0
                            end
                        end
                    end
                end
            end
        end)
    end
end)
local radius = 15
spawn(function()
    while wait(0.2) do
        pcall(function()
            if getgenv().Sea then
                local player = game.Players.LocalPlayer
                local character = player.Character or player.CharacterAdded:Wait()
                
                sethiddenproperty(player, "SimulationRadius", 112412400000)
                sethiddenproperty(player, "MaxSimulationRadius", 112412400000)
                
                local seaBeast = workspace:FindFirstChild("SeaBeast")
                if seaBeast then
                    for _, v in pairs(seaBeast:GetChildren()) do
                        if v:IsA("Humanoid") and v.Parent and v.Parent:IsA("Model") then
                            local npcPosition = v.Parent:FindFirstChild("HumanoidRootPart") and v.Parent.HumanoidRootPart.Position
                            local playerPosition = character:FindFirstChild("HumanoidRootPart") and character.HumanoidRootPart.Position
                            if npcPosition and playerPosition and (npcPosition - playerPosition).Magnitude <= 15 then
                                if v.Health < v.MaxHealth then
                                    wait(0.1)
                                    v.Health = 0
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)
spawn(function()
    while wait() do
        pcall(function()
            if _G.Check then
                local BossFound = false
                for _, v in pairs(workspace.BossSpawns.BossSpawn:GetChildren()) do
                    if v:IsA("Model") then
                      local NameB = v.Name
                        BossFound = true
                        if MMMM then
                            MMMM:Set("✅ |Boss : "..NameB)
                        end
                    end
                end
                if not BossFound then
                    if MMMM then
                        MMMM:Set("❌ |Boss")
                    end
                end
            end
        end)
    end
end)
spawn(function()
    while wait() do
        pcall(function()
            if _G.Check then
                local SeaBeast = false
                for _, v in pairs(workspace:GetChildren()) do
                    if v:FindFirstChild("SeaBeast") then
                        SeaBeast = true
                        if abcHee then
                            abcHee:Set("✅ |SeaBeast")
                        end
                        break
                    end
                end
                if not SeaBeast and abcHee then
                    abcHee:Set("❌ |SeaBeast")
                end
            end
        end)
    end
end)

spawn(function()
    pcall(function()
        game:GetService("RunService").Stepped:Connect(function()
            if getgenv().Farm2 and getgenv().Farm and getgenv().MoS then
                if not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
                    local Noclip = Instance.new("BodyVelocity")
                    Noclip.Name = "BodyClip"
                    Noclip.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
                    Noclip.MaxForce = Vector3.new(100000, 100000, 100000)
                    Noclip.Velocity = Vector3.new(0, 0, 0)
                end
            else    
                if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()
                end
            end
        end)
    end)
end)



