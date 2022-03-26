--// SexHub WalkSpeed Bypass \\--
local out = rconsoleprint or function() end

local mt = getrawmetatable(game)
local oldindex = mt.__index
local oldnewindex = mt.__newindex
setreadonly(mt, false)

local hum = game:service'Players'.LocalPlayer.Character.Humanoid
local oldws = hum.WalkSpeed
local oldjp = hum.JumpPower

mt.__newindex = newcclosure(function(t, k, v)
    if checkcaller() then
        return oldnewindex(t,k,v)
    elseif (t:IsA'Humanoid' and k == "WalkSpeed") then
        v = tonumber(v)
        if not v then v = 0 end
        oldws = v
    elseif (t:IsA'Humanoid' and k == "JumpPower") then
        v = tonumber(v)
        if not v then v = 0 end
        oldjp = v
    else
        return oldnewindex(t,k,v)
    end
end)

mt.__index = newcclosure(function(t, k)
    if checkcaller() then
        return oldindex(t,k)
    elseif (t:IsA'Humanoid' and k == "WalkSpeed") then
        return oldws
    elseif (t:IsA'Humanoid' and k == "JumpPower") then
        return oldjp
    else
        return oldindex(t,k)
    end
end)

setreadonly(mt, true)

--Var
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/HyperNIt3/Backups/main/SexHubV2/ESPO.lua "))()

-- Synapse Compatibilities
if syn then
    queue_on_teleport = syn.queue_on_teleport
    request = syn.request
end

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("SexHub V2")

--//Tabs\\--
local WelcomeTab = Window:NewTab("Welcome")
local Main = Window:NewTab("Local Player")
local Combat = Window:NewTab("Combat")
local Map = Window:NewTab("Map")
local Visual = Window:NewTab("Visual")
local Dupe = Window:NewTab("Dupe")
local Server = Window:NewTab("Server")
local Credits = Window:NewTab("Credits")

--// Sections \\--
local WelcomeSection = WelcomeTab:NewSection("Welcome")
local MainSection = Main:NewSection("Player")
local CombatSection = Combat:NewSection("Combat")
local AntiSection = Combat:NewSection("Anti Die Pat")
local MapSecation = Map:NewSection("Map")
local VisualSection = Visual:NewSection("Visual")
local DupeSection = Dupe:NewSection("Dupe Part")
local ServerSection = Server:NewSection("Server")
local CreditsSection = Credits:NewSection("Credits")

--//Weclome\\--
WelcomeSection:NewButton("Player Name: "..game.Players.LocalPlayer.Name, "Player Name")
WelcomeSection:NewButton("Player Id: "..game.Players.LocalPlayer.UserId, "Player Id")
WelcomeSection:NewButton("Account Age: "..game.Players.LocalPlayer.AccountAge.." Days", "Account Age Days")
WelcomeSection:NewButton("Game: "..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name.." |  Game Id: "..game.PlaceId, "Game Name & Game Id")
local players = game.Players:GetChildren()
local player_count = 0

    for i, player in pairs(players) do
        player_count = player_count + 1
        
    end
WelcomeSection:NewButton("Players In game: "..player_count.." |  Max Players: "..game.Players.MaxPlayers, "Show You How Many Players On Server You Play in")
WelcomeSection:NewButton("Timezone: " .. os.date("%Z"), "Show your current Timezone")

_G.EXPLOIT = ''..identifyexecutor();
WelcomeSection:NewButton("Exploit: ".._G.EXPLOIT, "EXPLOIT Name")
WelcomeSection:NewKeybind("UI Key Bind", "PutAnyKeybind", Enum.KeyCode.RightShift, function()
	Library:ToggleUI()
end)

--// Targets \\--
local AntiDie1_Speed = 0.1
local AntiDie2_Speed = 0.1

--//Main\\--
MainSection:NewTextBox("Wins", "Change Wins Value", function(txt)
    game:GetService("Players").LocalPlayer.leaderstats.Wins.Value = txt
end)

MainSection:NewTextBox("Levels", "500 = 1 Level", function(txt)
    game:GetService("Players").LocalPlayer.leaderstats.Rank.Value = txt
end)

MainSection:NewButton("Vip", "", function()
    game:GetService("Players").LocalPlayer.settings.vip.Value = true
end)

MainSection:NewToggle("Anti Afk", "Anti Afk", function(state)
    if state then
        getgenv().Afk = true
        repeat wait()
        if getgenv().Afk == true then
            local vu = game:GetService("VirtualUser")
            game:GetService("Players").LocalPlayer.Idled:connect(function()
            vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)end)
    end
    until getgenv().Afk == false
    else
        getgenv().Afk = false
    end
end)

MainSection:NewToggle("Fly", "Fly", function(state)
    if state then
        loadstring(game:HttpGet(('https://pastebin.com/raw/WxmvCLLH'),true))()
        _G.Speed = 1 
    else
        for i,v in pairs(game.Workspace:GetChildren()) do
            if v:IsA("Part") then
                if v:FindFirstChild("BodyVelocity") then
                    v:Destroy()
                end
            end
        end
    end
end)

MainSection:NewSlider("WalkSpeed", "WalkSpeed", 100, 16, function(v)
    getgenv().WS = true 
    getgenv().WSSpeed = v


    local RunService = game:GetService("RunService")

    RunService.Stepped:Connect(function()

        if getgenv().WS == true then
           if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").WalkSpeed = getgenv().WSSpeed
        end
        end
    end)
end)

MainSection:NewSlider("JumpPower", "JumpPower", 100, 50, function(v)
    getgenv().JP = true
    getgenv().JumpPower = v


    local RunService = game:GetService("RunService")

    RunService.Stepped:Connect(function()

        if getgenv().JP == true then
            if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").JumpPower = getgenv().JumpPower
        end
        end
    end)
end)

MainSection:NewToggle("Infinite Jump","Fly Jump",function(state)
    if state then
        InfiniteJumpEnabled = true
        game:GetService("UserInputService").JumpRequest:connect(function()
            if InfiniteJumpEnabled then
                game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
            end
        end)
    else
        InfiniteJumpEnabled = false
    end
end)

MainSection:NewToggle("Fish", "", function(state)
    if state then
getgenv().Fish1 = true
repeat wait()
if getgenv().Fish1 == true then
    game.Players.LocalPlayer.Character.Torso.Anchored = true
    game.Players.LocalPlayer.Character.Humanoid.Jump = true
    wait(0.1)
    game.Players.LocalPlayer.Character.Torso.Anchored = false
    game.Players.LocalPlayer.Character.Humanoid.Sit = true
    wait(0.1)
end
until getgenv().Fish1 == false
else
    getgenv().Fish1 = false
end
end)

MainSection:NewButton("Fix movements", "", function()
end)

MainSection:NewToggle("Noclip", "Go Through Objects", function(state)
    if state then
        getgenv().noclip = true
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        local mouse = player:GetMouse()

        mouse.KeyDown:Connect(function(key)
            if key == "" then
                getgenv().noclip = not getgenv().noclip

                if not StealthMode then
                    Indicator.Text = "Noclip: " .. (getgenv().noclip and "Enabled" or "Disabled")
                end
            end
        end)

        while true do
            player = game.Players.LocalPlayer
            character = player.Character

            if getgenv().noclip then
                for _, v in pairs(character:GetDescendants()) do
                    pcall(function()
                        if v:IsA("BasePart") then
                            v.CanCollide = false
                        end
                    end)
                end
            end

            game:GetService("RunService").Stepped:wait()
        end
    else
        getgenv().noclip = false
        --v.CanCollide = true
    end
end)

MainSection:NewToggle("Bhop Hob", " Auto Jump", function(state)
if state then
    getgenv().Bhop = true
    repeat wait()
    if getgenv().Bhop == true then
        game.Players.LocalPlayer.Character.Humanoid.Jump = true
        end
    until getgenv().Bhop == false
else
    getgenv().Bhop = false
end
end)

MainSection:NewSlider("Player Fov","Player Fov", 120, 70, function(v)
    game:GetService'Workspace'.Camera.FieldOfView = v
end)

MainSection:NewToggle("Fake lag", nil, function(state)
if state then
    getgenv().Fakelag = true
    repeat wait()
    if getgenv().Fakelag == true then
game.Players.LocalPlayer.Character.Torso.Anchored = true
game.Players.LocalPlayer.Character.Humanoid.Jump = true
wait(0.1)
game.Players.LocalPlayer.Character.Torso.Anchored = false
game.Players.LocalPlayer.Character.Humanoid.Sit = true
wait(0.1)
end
until getgenv().Fakelag == false
else
    getgenv().Fakelag = false
end
end)

MainSection:NewSlider("Fake lag amount", 0, 25, 0, function(value)
game.Players.LocalPlayer.Character.Torso.Anchored = true
game.Players.LocalPlayer.Character.Humanoid.Jump = true
wait(value)
game.Players.LocalPlayer.Character.Torso.Anchored = false
game.Players.LocalPlayer.Character.Humanoid.Sit = true
wait(value)
end)

--//Combat\\--
CombatSection:NewToggle("Silent Aim", "Patched", function()
end)

CombatSection:NewToggle("Hitbox expander", "Semi working", function(state)
end)

CombatSection:NewSlider("Hitbox size", 1, 10, 1, function(s)
_G.HeadSize = s
_G.Disabled = true

game:GetService('RunService').RenderStepped:connect(function()
if _G.Disabled then
for i,v in next, game:GetService('Players'):GetPlayers() do
if v.Name ~= game:GetService('Players').LocalPlayer.Name then
pcall(function()
v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
v.Character.HumanoidRootPart.Transparency = 0.7
v.Character.HumanoidRootPart.BrickColor = BrickColor.new("White")
v.Character.HumanoidRootPart.Material = "Neon"
v.Character.HumanoidRootPart.CanCollide = false
end)
end
end
end
end)
end)

CombatSection:NewSlider("Hitbox Transparency", 1, 10, 1, function(n)
    v.Character.HumanoidRootPart.Transparency = n
end)

CombatSection:NewToggle("Auto Throw", "", function(state)
    if state then
        getgenv().AutoShoot = true
        if getgenv().AutoShoot == true then
        local plrs = game:service "Players"
        local lp = plrs.LocalPlayer
        local bind = lp.PlayerScripts.Event
        local ThrowKnifeFunc
        local KillFunc
        local MsgBox
        function GetSkid()
            for _, plr in pairs(plrs:GetPlayers()) do
                if plr ~= lp and plr.Character and plr.Character:FindFirstChild("Blade") and plr.Character.Humanoid.Health > 0 then
                    return plr
                end
            end
            return nil
        end
        
        function GetKillFunc()
            for i, v in pairs(getgc(false)) do
                if type(v) == "function" and tostring(getfenv(v).script) == game.Players.LocalPlayer.PlayerScripts:GetChildren()[1].Name then
                    local constants = debug.getconstants(v)
                    for _, b in pairs(constants) do
                        if tostring(b) == "IIlIla" then
                            KillFunc = v
                        end
                    end
                end
            end
        end
        
        function GetThrowKnifeFunc()
            for i, v in pairs(getgc(true)) do
                if type(v) == "function" and debug.getinfo(v).name == "throw" then
                    ThrowKnifeFunc = v
                end
            end
        end
        
        function GetMsgBoxFunc()
            for i, v in pairs(getgc(true)) do
                if type(v) == "function" and debug.getinfo(v).name == "fancymsgbox" then
                    MsgBox = v
                end
            end
        end
        
        GetKillFunc()
        GetThrowKnifeFunc()
        GetMsgBoxFunc()
        
        debug.setconstant(ThrowKnifeFunc, 46, 1)
        
        repeat wait()
            local ptr = GetSkid()
            if ptr ~= nil and lp.Character:FindFirstChild("Blade") then
                bind:Fire("t", ptr.Character.HumanoidRootPart.CFrame)
                KillFunc(ptr.Character.HumanoidRootPart, true, ptr.Character.HumanoidRootPart.Position)
                ThrowKnifeFunc(ptr.Character.HumanoidRootPart.CFrame)
            end
    until getgenv().AutoShoot == false
end
        else
            getgenv().AutoShoot = false
    end
end)

CombatSection:NewToggle("Kill Aura", "", function(state)
    if state then
        getgenv().KillAura = true
        repeat wait()
        if getgenv().KillAura == true then
            for i,v in pairs(game.Players:GetPlayers()) do
            if v.Name ~= game.Players.LocalPlayer.name then
                if game.Workspace:FindFirstChild(v.Name) then
                    if game.Workspace[v.Name].Humanoid.Sit ~= true then
                        if game.Workspace[v.Name]:FindFirstChild("Blade") then
                            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(37, CFrame.new(Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)), Vector3.new(v.Character.HumanoidRootPart.CFrame.x, 4, v.Character.HumanoidRootPart.CFrame.z), Vector3.new(0, 0, 0))
                            wait(.1)
                            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(43, v.Character.HumanoidRootPart, v, "IIlIla", true)
            else
                if v.Backpack:FindFirstChild("Blade") then
            local args = {
            [1] = "kni",
            [2] = game:GetService("Players")[v.Name].Character.Head,
            [3] = game:GetService("Players")[v.Name],
            [5] = false
            }
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
            end end end end end end
        end
        until getgenv().KillAura == false
    else
        getgenv().KillAura = false
    end
end)

CombatSection:NewToggle("Aimbot knife", "", function(state)
       if state then
local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Holding = false
 
_G.AimbotEnabled = true
_G.TeamCheck = false 
_G.AimPart = "Head" 
_G.Sensitivity = 0
 
_G.CircleSides = 64 
_G.CircleColor = Color3.fromRGB(255, 255, 255)
_G.CircleTransparency = 0.7 
_G.CircleRadius = 0 
_G.CircleFilled = false
_G.CircleVisible = false
_G.CircleThickness = 0 
 
local FOVCircle = Drawing.new("Circle")
FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
FOVCircle.Radius = _G.CircleRadius
FOVCircle.Filled = _G.CircleFilled
FOVCircle.Color = _G.CircleColor
FOVCircle.Visible = _G.CircleVisible
FOVCircle.Radius = _G.CircleRadius
FOVCircle.Transparency = _G.CircleTransparency
FOVCircle.NumSides = _G.CircleSides
FOVCircle.Thickness = _G.CircleThickness
 
local function GetClosestPlayer()
    local MaximumDistance = _G.CircleRadius
    local Target
 
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Name ~= LocalPlayer.Name then
            if _G.TeamCheck == true then 
                if v.Team ~= LocalPlayer.Team then
                    if workspace:FindFirstChild(v.Name) ~= nil then
                        if workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil then
                            if workspace[v.Name]:FindFirstChild("Humanoid") ~= nil and workspace[v.Name]:FindFirstChild("Humanoid").Health ~= 0 then
                                local ScreenPoint = Camera:WorldToScreenPoint(workspace[v.Name]:WaitForChild("HumanoidRootPart", math.huge).Position)
                                local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
                                
                                if VectorDistance < MaximumDistance then
                                    Target = v
                                end
                            end
                        end
                    end
                end
            else
                if workspace:FindFirstChild(v.Name) ~= nil then
                    if workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil then
                        if workspace[v.Name]:FindFirstChild("Humanoid") ~= nil and workspace[v.Name]:FindFirstChild("Humanoid").Health ~= 0 then
                            local ScreenPoint = Camera:WorldToScreenPoint(workspace[v.Name]:WaitForChild("HumanoidRootPart", math.huge).Position)
                            local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
                            
                            if VectorDistance < MaximumDistance then
                                Target = v
                            end
                        end
                    end
                end
            end
        end
    end
 
    return Target
end
 
UserInputService.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        Holding = true
    end
end)
 
UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        Holding = false
        Locked = false
    end
end)
 
RunService.RenderStepped:Connect(function()
    FOVCircle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
    FOVCircle.Radius = _G.CircleRadius
    FOVCircle.Filled = _G.CircleFilled
    FOVCircle.Color = _G.CircleColor
    FOVCircle.Visible = _G.CircleVisible
    FOVCircle.Radius = _G.CircleRadius
    FOVCircle.Transparency = _G.CircleTransparency
    FOVCircle.NumSides = _G.CircleSides
    FOVCircle.Thickness = _G.CircleThickness
    if Holding == true and _G.AimbotEnabled == true then
        TweenService:Create(Camera, TweenInfo.new(_G.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, GetClosestPlayer().Character[_G.AimPart].Position)}):Play()
        Locked = true
    end
end)
    else
        _G.AimbotEnabled = false
    end
end)

CombatSection:NewToggle("Fov toggle", "Toggles fov on and off", function(state)
    if state then
        _G.CircleVisible = true
    else
        _G.CircleVisible = false
    end
end)

CombatSection:NewToggle("Fill fov", "Makes the fov completely colored", function(state)
    if state then
        _G.CircleFilled = true
    else
        _G.CircleFilled = false
    end
end)

CombatSection:NewSlider("Fov size", "sizes the fov", 500, 0, function(c)
	_G.CircleRadius = c
end)

AntiSection:NewToggle("Anti Die", "Make players hard to kill you", function(state)
    if state then
        getgenv().Diee = true
		repeat wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-47.532779693604, 3.0, -188.43943786621)
        wait(AntiDie1_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-29.94979095459, 6.5734910964966, -211.22297668457)
        wait(AntiDie1_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-46.231246948242, 3.0, -182.2142578125)
        wait(AntiDie1_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-30.0, 3.0, -181.0)
        wait(AntiDie1_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13.35943031311, 3.0, -182.44982910156)
        wait(AntiDie1_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-37.562549591064, 6.4678139686584, -226.47694396973)
        wait(AntiDie1_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-33.365234375, 6.4678139686584, -195.48100280762)
        wait(AntiDie1_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-20.857997894287, 6.5923500061035, -202.79592895508)
        wait(AntiDie1_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-29.912626266479, 3.0214474201202, -228.10636901855)
        wait(AntiDie1_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-24.716865539551, 3.0, -231.61094665527)
        wait(AntiDie1_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-29.0, 3.0, -215.85543823242)
        wait(AntiDie1_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-43.339576721191, 3.0, -236.16175842285)
        wait(AntiDie1_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13.669812202454, 3.0, -242.0)
        wait(AntiDie1_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-28.788187026978, 2.9999992847443, -248.42706298828)
        wait(AntiDie1_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-50.115543365479, 3.0, -222.92395019531)game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-47.532779693604, 3.0, -188.43943786621)
        wait(AntiDie1_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-29.94979095459, 6.5734910964966, -211.22297668457)
        wait(AntiDie1_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-46.231246948242, 3.0, -182.2142578125)
        wait(AntiDie1_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-30.0, 3.0, -181.0)
        wait(AntiDie1_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13.35943031311, 3.0, -182.44982910156)
        wait(AntiDie1_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-37.562549591064, 6.4678139686584, -226.47694396973)
        wait(AntiDie1_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-33.365234375, 6.4678139686584, -195.48100280762)
        wait(AntiDie1_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-20.857997894287, 6.5923500061035, -202.79592895508)
        wait(AntiDie1_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-29.912626266479, 3.0214474201202, -228.10636901855)
        wait(AntiDie1_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-24.716865539551, 3.0, -231.61094665527)
        wait(AntiDie1_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-29.0, 3.0, -215.85543823242)
        wait(AntiDie1_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-43.339576721191, 3.0, -236.16175842285)
        wait(AntiDie1_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13.669812202454, 3.0, -242.0)
        wait(AntiDie1_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-28.788187026978, 2.9999992847443, -248.42706298828)
        wait(AntiDie1_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-50.115543365479, 3.0, -222.92395019531)
        until getgenv().Diee == false
    else
        getgenv().Diee = false
        wait(2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-30.10, 6.691588, -210.136368)
    end
end)

AntiSection:NewToggle("Anti Die | Better", "Make players hard to kill you", function(state)
    if state then
        getgenv().DieeB = true
		repeat wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-47.532779693604, 29.0, -188.43943786621)
        wait(AntiDie2_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-29.94979095459, 29.0, -211.22297668457)
        wait(AntiDie2_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-46.231246948242, 29.0, -182.2142578125)
        wait(AntiDie2_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-30.0, 29.0, -181.0)
        wait(AntiDie2_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13.35943031311, 29.0, -182.44982910156)
        wait(AntiDie2_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-37.562549591064, 29.0, -226.47694396973)
        wait(AntiDie2_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-33.365234375, 29.0, -195.48100280762)
        wait(AntiDie2_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-20.857997894287, 29.0, -202.79592895508)
        wait(AntiDie2_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-29.912626266479, 29.0, -228.10636901855)
        wait(AntiDie2_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-24.716865539551, 29.0, -231.61094665527)
        wait(AntiDie2_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-29.0, 29.0, -215.85543823242)
        wait(AntiDie2_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-43.339576721191, 29.0, -236.16175842285)
        wait(AntiDie2_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13.669812202454, 29.0, -242.0)
        wait(AntiDie2_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-28.788187026978, 29.0, -248.42706298828)
        wait(AntiDie2_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-50.115543365479, 29.0, -222.92395019531)
        wait(AntiDie2_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-47.532779693604, 29.0, -188.43943786621)
        wait(AntiDie2_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-29.94979095459, 29.0, -211.22297668457)
        wait(AntiDie2_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-46.231246948242, 29.0, -182.2142578125)
        wait(AntiDie2_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-30.0, 29.0, -181.0)
        wait(AntiDie2_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13.35943031311, 29.0, -182.44982910156)
        wait(AntiDie2_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-37.562549591064, 29.0, -226.47694396973)
        wait(AntiDie2_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-33.365234375, 29.0, -195.48100280762)
        wait(AntiDie2_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-20.857997894287, 29.0, -202.79592895508)
        wait(AntiDie2_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-29.912626266479, 29.0, -228.10636901855)
        wait(AntiDie2_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-24.716865539551, 29.0, -231.61094665527)
        wait(AntiDie2_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-29.0, 29.0, -215.85543823242)
        wait(AntiDie2_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-43.339576721191, 29.0, -236.16175842285)
        wait(AntiDie2_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13.669812202454, 29.0, -242.0)
        wait(AntiDie2_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-28.788187026978, 29.0, -248.42706298828)
        wait(AntiDie2_Speed)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-50.115543365479, 29.0, -222.92395019531)
        until getgenv().DieeB == false
    else
        getgenv().DieeB = false
        wait(2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-30.10, 6.691588, -210.136368)
    end
end)

AntiSection:NewSlider("Anti Die Speed", "", 5, 0.2, function(value)
    AntiDie1_Speed = value
end)

AntiSection:NewSlider("Anti Die Better Speed", "", 5, 0.2, function(value)
    AntiDie2_Speed = value
end)

AntiSection:NewToggle("Anti Die Normal", "Make players hard to kill you", function(state)
    if state then
        getgenv().Diee = true
		repeat wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-47.532779693604, 3.0, -188.43943786621)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-29.94979095459, 6.5734910964966, -211.22297668457)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-46.231246948242, 3.0, -182.2142578125)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-30.0, 3.0, -181.0)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13.35943031311, 3.0, -182.44982910156)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-37.562549591064, 6.4678139686584, -226.47694396973)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-33.365234375, 6.4678139686584, -195.48100280762)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-20.857997894287, 6.5923500061035, -202.79592895508)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-29.912626266479, 3.0214474201202, -228.10636901855)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-24.716865539551, 3.0, -231.61094665527)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-29.0, 3.0, -215.85543823242)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-43.339576721191, 3.0, -236.16175842285)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13.669812202454, 3.0, -242.0)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-28.788187026978, 2.9999992847443, -248.42706298828)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-50.115543365479, 3.0, -222.92395019531)game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-47.532779693604, 3.0, -188.43943786621)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-29.94979095459, 6.5734910964966, -211.22297668457)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-46.231246948242, 3.0, -182.2142578125)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-30.0, 3.0, -181.0)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13.35943031311, 3.0, -182.44982910156)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-37.562549591064, 6.4678139686584, -226.47694396973)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-33.365234375, 6.4678139686584, -195.48100280762)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-20.857997894287, 6.5923500061035, -202.79592895508)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-29.912626266479, 3.0214474201202, -228.10636901855)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-24.716865539551, 3.0, -231.61094665527)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-29.0, 3.0, -215.85543823242)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-43.339576721191, 3.0, -236.16175842285)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13.669812202454, 3.0, -242.0)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-28.788187026978, 2.9999992847443, -248.42706298828)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-50.115543365479, 3.0, -222.92395019531)
        until getgenv().Diee == false
    else
        getgenv().Diee = false
        wait(2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-30.10, 6.691588, -210.136368)
    end
end)

AntiSection:NewToggle("Anti Die | Better Normal", "Make players hard to kill you", function(state)
    if state then
        getgenv().DieeB = true
		repeat wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-47.532779693604, 29.0, -188.43943786621)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-29.94979095459, 29.0, -211.22297668457)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-46.231246948242, 29.0, -182.2142578125)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-30.0, 29.0, -181.0)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13.35943031311, 29.0, -182.44982910156)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-37.562549591064, 29.0, -226.47694396973)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-33.365234375, 29.0, -195.48100280762)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-20.857997894287, 29.0, -202.79592895508)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-29.912626266479, 29.0, -228.10636901855)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-24.716865539551, 29.0, -231.61094665527)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-29.0, 29.0, -215.85543823242)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-43.339576721191, 29.0, -236.16175842285)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13.669812202454, 29.0, -242.0)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-28.788187026978, 29.0, -248.42706298828)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-50.115543365479, 29.0, -222.92395019531)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-47.532779693604, 29.0, -188.43943786621)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-29.94979095459, 29.0, -211.22297668457)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-46.231246948242, 29.0, -182.2142578125)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-30.0, 29.0, -181.0)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13.35943031311, 29.0, -182.44982910156)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-37.562549591064, 29.0, -226.47694396973)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-33.365234375, 29.0, -195.48100280762)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-20.857997894287, 29.0, -202.79592895508)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-29.912626266479, 29.0, -228.10636901855)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-24.716865539551, 29.0, -231.61094665527)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-29.0, 29.0, -215.85543823242)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-43.339576721191, 29.0, -236.16175842285)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13.669812202454, 29.0, -242.0)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-28.788187026978, 29.0, -248.42706298828)
        wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-50.115543365479, 29.0, -222.92395019531)
        until getgenv().DieeB == false
    else
        getgenv().DieeB = false
        wait(2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-30.10, 6.691588, -210.136368)
    end
end)

CombatSection:NewToggle("Auto Kill Gunslinger", "Patched", function(state)
    if state then
getgenv().Gunslinger = true
    repeat wait()
    if getgenv().Gunslinger == true then
--Normal Variables
local tk = Enum.KeyCode.F
--Variables
local uis = game:GetService("UserInputService")
local p = game:GetService('Players').LocalPlayer
local pl = game:GetService('Players')
local m = p:GetMouse()
local cc = game.Workspace.CurrentCamera
local tog = true
local e1, e2

--On by Default (I wouldn't change this)
p.CameraMode = Enum.CameraMode.LockFirstPerson
if game:GetService("Workspace"):FindFirstChild("deadbodies") then
   game:GetService("Workspace").deadbodies:Destroy()
end

--Aim & Shoot Function
function ka(t)
    if t ~= p.Name then
    if tog == true then
        wait(1)
    ch = p.Character
    ch.HumanoidRootPart.CFrame = CFrame.new(ch.HumanoidRootPart.Position, pl[t].Character.HumanoidRootPart.Position)
    cc.CFrame = CFrame.new(ch.HumanoidRootPart.Position, pl[t].Character.HumanoidRootPart.Position)
    repeat wait(.005) mouse1click() until game.Workspace.gunholder[t] == nil
    end
    end
end

--Toggle Detection
e1 = uis.InputBegan:Connect(function(o)
    if uis:GetFocusedTextBox() then return end
    ------------------------------------------
 if o.KeyCode == tk and tog == true then
 ch = p.Character
 p.CameraMode = Enum.CameraMode.Classic
 tog = false
 elseif o.KeyCode == tk and tog == false then
 p.CameraMode = Enum.CameraMode.LockFirstPerson
 tog = true
 elseif o.KeyCode == sk then
 e1:Disconnect();e2:Disconnect();p.CameraMode = Enum.CameraMode.Classic;ka = nil
 end
 end)

--Gun Detection
e2 = game.Workspace.light.PointLight.Changed:Connect(function()
game.Workspace.gunholder.ChildAdded:Connect(function(c)
ka(c.Name)
end)
end)
end
 until getgenv().Gunslinger == false
        else
            getgenv().Gunslinger = false
        end
end)

CombatSection:NewToggle("Kill all Gun", "Kill all with gun", function(state)
    if state then
        getgenv().KillAll = true
    repeat wait()
if getgenv().KillAll == true then
    game:GetService("ReplicatedStorage").RemoteEvent:FireServer(16, "public")
    wait()
    for i,v in pairs(game.Players:GetPlayers()) do
        if v.Name ~= game.Players.LocalPlayer.Name then
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(30, v)
        end
    end
end
until getgenv().KillAll == false
    else
        getgenv().KillAll = false
    end
end) 

CombatSection:NewToggle("Instant Credits Premium", "", function(state)
    if state then
getgenv().InstantPremium = true
repeat wait()
if getgenv().InstantPremium == true then
    game:GetService("ReplicatedStorage").RemoteEvent:FireServer(16, "public")
    wait()
    for i,v in pairs(game.Players:GetPlayers()) do
        if v.Name ~= game.Players.LocalPlayer.Name then
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(30, v)
        end
    end
end
game:GetService("ReplicatedStorage").RemoteEvent:FireServer(16, "public")
wait()
for i,v in pairs(game.Players:GetPlayers()) do
    if v.Name ~= game.Players.LocalPlayer.Name then
        game:GetService("ReplicatedStorage").RemoteEvent:FireServer(30, v)
    end
end
game:GetService("ReplicatedStorage").RemoteEvent:FireServer(16, "public")
wait()
for i,v in pairs(game.Players:GetPlayers()) do
    if v.Name ~= game.Players.LocalPlayer.Name then
        game:GetService("ReplicatedStorage").RemoteEvent:FireServer(30, v)
    end
end
until getgenv().InstantPremium == false
    else
        getgenv().InstantPremium = false
    end
end)

CombatSection:NewToggle("Instant Credits, Levels", "Makes you get more Credits & Levels", function(state)
    if state then
getgenv().Instance = true
    repeat wait()
if getgenv().Instance == true then
    for i,v in pairs(game.Players:GetPlayers()) do
        if v.Name ~= game.Players.LocalPlayer.Name then
            if game.Workspace:FindFirstChild(v.Name) then
                if game.Workspace[v.Name].Humanoid.Sit ~= true then
                    if game.Workspace[v.Name]:FindFirstChild("Blade") then
                        game:GetService("ReplicatedStorage").RemoteEvent:FireServer(37, CFrame.new(Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)), Vector3.new(v.Character.HumanoidRootPart.CFrame.x, 4, v.Character.HumanoidRootPart.CFrame.z), Vector3.new(0, 0, 0))
                        wait(.1)
                        game:GetService("ReplicatedStorage").RemoteEvent:FireServer(43, v.Character.HumanoidRootPart, v, "IIlIla", true)
                    else
                        if v.Backpack:FindFirstChild("Blade") then
                            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(37, CFrame.new(Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)), Vector3.new(v.Character.HumanoidRootPart.CFrame.x, 4, v.Character.HumanoidRootPart.CFrame.z), Vector3.new(0, 0, 0))
                            wait(.1)
                            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(43, v.Character.HumanoidRootPart, v, "IIlIla", true)
                        end
                    end
                end
            end
        end
    end
end
until getgenv().Instance == false
else
    getgenv().Instance = false
end
end) 

CombatSection:NewToggle("Auto Buy Murderer", "", function(state)
    local args = {
[1] = 60,[2] = {["confirm"] = true,["image"] = 0,["name"] = "\nBe the murderer \n [Who did it]",["price"] = 500,["data"] = "requestmurderer"}}
    game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
    if state then
        getgenv().Murderer = true
        repeat wait(60)
if getfenv().Murderer == true then
local args = {
    [1] = 60,
    [2] = {
        ["confirm"] = true,
        ["image"] = 0,
        ["name"] = "\nBe the murderer \n [Who did it]",
        ["price"] = 500,
        ["data"] = "requestmurderer"
    }
}
game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
end
until getgenv().Murderer == false
    else
        getgenv().Murderer = false
    end
end)

CombatSection:NewButton("Kill All in Breaking Point Mode", "Loop kill all", function()
if game.PlaceId == 834827615 then
    wait(0.5)
    spawn(function()
        while wait () do
    game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):ChangeState(11)
    end end)
    spawn(function()
        while wait (0.1) do
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.spawnlocations.SpawnLocation.CFrame
    end end)
    spawn(function()
        while wait () do
        for i,v in pairs(game.Players:GetPlayers()) do
            if v.Name == game.Players.LocalPlayer.Name then
                else
                game:GetService("ReplicatedStorage").RemoteEvent:FireServer(30, v)
            end end end end)
    spawn(function()
        while wait () do
    game:GetService("ReplicatedStorage").RemoteEvent:FireServer(16, "public")
    end end)
    else
        game:GetService("TeleportService"):Teleport(834827615, LocalPlayer)
        end
    
    
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end)

--//Map\\--
MapSecation:NewColorPicker("Light Color", "Change Light color", Color3.fromRGB(0,0,0), function(color)
    game:GetService("Workspace").light.Color = color
    game:GetService("Workspace").light.PointLight.Color = color
end)

MapSecation:NewColorPicker("Table Color", "Change Table color", Color3.fromRGB(0,0,0), function(color)
game:GetService("Workspace").table.top.Color = color
game:GetService("Workspace").table.Cylinder.Color = color
game:GetService("Workspace").table.MeshPart.Color = color
game:GetService("Workspace").table.MeshPart.Color = color
game:GetService("Workspace").table.MeshPart.Color = color
game:GetService("Workspace").table.MeshPart.Color = color
end)

MapSecation:NewColorPicker("Radiant Effect Color", "Change Radiant Effect color", Color3.fromRGB(0,0,0), function(color)
    game:GetService("ReplicatedStorage").model.radiant2.Color = color
    game:GetService("ReplicatedStorage").model.radiant2c.Color = color
    game:GetService("ReplicatedStorage").model.radiantfx.Color = color
end)

MapSecation:NewToggle("Stay Light on", "Light on with some Dark", function(state)
    if state then
        getgenv().light = true
repeat wait()
if getgenv().light == true then
    game:GetService("Workspace").light.PointLight.Range = 60
    game:GetService("Workspace").light.PointLight.Enabled = true
    game:GetService("Workspace").light.PointLight.Brightness = 100
    end
until getgenv().light == false
else
    getgenv().light = false
    game:GetService("Workspace").light.PointLight.Range = 18
    game:GetService("Workspace").light.PointLight.Enabled = true
    game:GetService("Workspace").light.PointLight.Brightness = 5
end
end)

MapSecation:NewSlider("Light Distance", "", 61, 0, function(s)
    game:GetService("Workspace").light.PointLight.Range = s
    game:GetService("Workspace").light.PointLight.Brightness = s
end)

MapSecation:NewButton("Get Knife", "", function()
    if game:GetService("ReplicatedStorage").model:FindFirstChild("Blade") then
        local Clone = game:GetService("ReplicatedStorage").model:FindFirstChild("Blade"):Clone()
        Clone.Parent = game:GetService("Players").LocalPlayer:FindFirstChild("Backpack")
    end
end)

MapSecation:NewToggle("FullBright", "", function(state)
    if state then
        getgenv().FB = true
        OldAmbient = game:GetService("Lighting").Ambient
        repeat wait()
          game.Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        until getgenv().FB == false
      else
        getgenv().FB = false
        wait(0.05)
        game.Lighting.Ambient = OldAmbient
      end
end)

MapSecation:NewToggle("Remove Glass", "Can Move to Arcade", function(state)
    if state then
        game:GetService("Workspace").glass.CanCollide = false
    else
        game:GetService("Workspace").glass.CanCollide = true
    end
end)

MapSecation:NewToggle("Win Arcade Machine", "Not Work", function(state)
    if state then
    getgenv().Arcade = true
    repeat wait()
    if getgenv().Arcade == true then
    local Arcade = workspace.arcade 
    local Object = Arcade.screen.SurfaceGui.stacker.box
    
    local PlayButton = Arcade.button2 
    local StartButton = Arcade.button1
    
    fireclickdetector(StartButton.ClickDetector)
    Object:GetPropertyChangedSignal('Position'):Connect(function()
        if Object.AbsolutePosition.X == 140 then 
            fireclickdetector(PlayButton.ClickDetector)
        end
    end)
end
        until getgenv().Arcade == false
        else
            getgenv().Arcade = false
        end
end)

MapSecation:NewButton("Low Quality", "Fix Lag", function(state)
    local decalsyeeted = true -- Leaving this on makes games look shitty but the fps goes up by at least 20.
    local g = game
    local w = g.Workspace
    local l = g.Lighting
    local t = w.Terrain
    t.WaterWaveSize = 0
    t.WaterWaveSpeed = 0
    t.WaterReflectance = 0
    t.WaterTransparency = 0
    l.GlobalShadows = true
    l.FogEnd = 100000
    l.Brightness = 1
    settings().Rendering.QualityLevel = "Level01"
    for i, v in pairs(g:GetDescendants()) do
        if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
            v.Material = "Plastic"
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
            v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Lifetime = NumberRange.new(0)
        elseif v:IsA("Explosion") then
            v.BlastPressure = 1
            v.BlastRadius = 1
        elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") then
            v.Enabled = false
        elseif v:IsA("MeshPart") then
            v.Material = "Plastic"
            v.Reflectance = 1
            v.TextureID = 10385902758728957
        end
    end
    for i, e in pairs(l:GetChildren()) do
        if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
            e.Enabled = false
        end
    end
	workspace.DescendantAdded:Connect(function(child)
		coroutine.wrap(function()
			if child:IsA('ForceField') then
				game:GetService('RunService').Heartbeat:Wait()
				child:Destroy()
			elseif child:IsA('Sparkles') then
				game:GetService('RunService').Heartbeat:Wait()
				child:Destroy()
			elseif child:IsA('Smoke') or child:IsA('Fire') then
				game:GetService('RunService').Heartbeat:Wait()
				child:Destroy()
			end
		end)()
	end)
end)

--//Visual\\--
VisualSection:NewToggle("Esp", "", function(state)
    if state then
    ESP:Toggle(true)
    else
    ESP:Toggle(false)
    end
end)

VisualSection:NewToggle("Draw Box", "Draw Box on Enemis", function(state)
    if state then
    ESP.Boxes = true
    else
    ESP.Boxes = false
    end
end)

VisualSection:NewToggle("Draw Tracers", "Draw Tracer on Enemis", function(state)
    if state then
    ESP.Tracers = true
    else
    ESP.Tracers = false
    end
end)

VisualSection:NewToggle("Draw Names", "Draw Names of Enemis", function(state)
    if state then
    ESP.Names = true
    else
    ESP.Names = false
    end
end)


VisualSection:NewToggle("Face Camera Esp", "Set The ESP faced Towards The Camera", function(state)
    if state then
    ESP.FaceCamera = true
    else
    ESP.FaceCamera = false
    end
end)

VisualSection:NewColorPicker("ESP Color", "Sets The ESP Color", Color3.fromRGB(0,0,0), function(color)
    ESP.Color = color
end)

--//Dupe\\--
DupeSection:NewButton("Dupe Chair Legendary Case", "", function()
    local args = {[1] = 66,[2] = "Chair Skins",[3] = "Legendary Case"}
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
end)

DupeSection:NewButton("Dupe Knife Legendary Case", "", function()
    local args = {[1] = 66,[2] = "Knife Skins",[3] = "Legendary Case"}
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
end)

DupeSection:NewButton("Dupe /e rain", "", function()
    local args = {[1] = 66,[2] = "Animations",[3] = "Exclusive"}
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
end)

DupeSection:NewButton("Dupe Accessories", "", function()
    local args = {[1] = 66,[2] = "Accessories",[3] = "Knife Antlers"}
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
end)

DupeSection:NewButton("Dupe Candy Crown Knife", "", function()
    local args = {[1] = 66,[2] = "Knife Skins",[3] = "Winter Gift"}
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
end)

DupeSection:NewButton("Dupe Royale Red Chair", "", function()
    local args = {[1] = 66,[2] = "Chair Skins",[3] = "Winter"}
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
end)

--//Server\\--
ServerSection:NewButton("All game-modes", "Back To The Main Server", function()
    game:GetService("TeleportService"):Teleport(648362523, LocalPlayer)
end)

ServerSection:NewButton("Duck Duck Stab", "Join Duck Duck Stab Mode", function()
    game:GetService("TeleportService"):Teleport(834829150, LocalPlayer)
end)

ServerSection:NewButton("Duos", "Join Duos Mode", function()
    game:GetService("TeleportService"):Teleport(1410026010, LocalPlayer)
end)

ServerSection:NewButton("Kill Row", "Join Kill Row Mode", function()
    game:GetService("TeleportService"):Teleport(1426048327, LocalPlayer)
end)

ServerSection:NewButton("Breaking Point", "Join Breaking Point Mode", function()
    game:GetService("TeleportService"):Teleport(834827615, LocalPlayer)
end)

ServerSection:NewButton("Duel Vote", "Join Duel Vote Mode", function()
    game:GetService("TeleportService"):Teleport(901462028, LocalPlayer)
end)

ServerSection:NewButton("Everything ", "Join Everything Mode", function()
    game:GetService("TeleportService"):Teleport(694768217, LocalPlayer)
end)

ServerSection:NewButton("Free for All", "Join Free for All Mode", function()
    game:GetService("TeleportService"):Teleport(987684187, LocalPlayer)
end)

ServerSection:NewButton("Gunslinger", "Join Gunslinger Mode", function()
    game:GetService("TeleportService"):Teleport(1436726276, LocalPlayer)
end)

ServerSection:NewButton("Rejoin", "Rejoin The Server", function()
    local ts = game:GetService("TeleportService")
	
    local p = game:GetService("Players").LocalPlayer
    
    ts:Teleport(game.PlaceId, p)
end)

--//Credits\\--
CreditsSection:NewButton("Made by c00dy#0001", "My Discord Name", function()
end)
CreditsSection:NewButton("Copy Outlaws Discord Server", "My Discord Server", function()
    setclipboard("https://discord.gg/TDBXdcHScr")
    if not getgenv().DiscordJoined then
        request({
            Url = "http://127.0.0.1:6463/rpc?v=1",
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json",
                ["Origin"] = "https://discord.com"
            },
            Body = game:GetService("HttpService"):JSONEncode({
                cmd = "INVITE_BROWSER",
                args = {
                    code = "TDBXdcHScr"
                },
                nonce = game:GetService("HttpService"):GenerateGUID(false)
            }),
        })
    end

    getgenv().DiscordJoined = true
end)

while wait(60) do
game:GetService("Workspace").arcade.screen.SurfaceGui.label.Text = "OutlawsHub"
game:GetService("Workspace").arcade.screen.SurfaceGui.label.Visible = true
game:GetService("Workspace").arcade.screen.SurfaceGui.label.TextColor3 = Color3.fromRGB(255,0,0)
end