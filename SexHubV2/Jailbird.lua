loadstring(game:HttpGet("https://raw.githubusercontent.com/HyperNIt3/Backups/main/SexHubV2/c00dyBypass.lua"))()
--Synapse Compatibilities
if syn then
    queue_on_teleport = syn.queue_on_teleport
    request = syn.request
end

--Var
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/HyperNIt3/Backups/main/SexHubV2/ESPO.lua"))()
ESP:Toggle(false)
ESP.Tracers = false
ESP.Names = false
ESP.Boxes = false
ESP.TeamColor = false
ESP.TeamMates = false

--Aimbot
local OldNameCall = nil
OldNameCall = hookmetamethod(game, "__namecall", function(...)
    local Args = {...}
    local Self = Args[1]
    if getnamecallmethod()=="FireServer" and tostring(Self)=="Utility" then
            return wait(math.huge)
    end
    return OldNameCall(...)
end)

local Circle = Drawing.new("Circle")
Circle.Color =  Color3.fromRGB(128, 234, 255)
Circle.Thickness = 1
Circle.Radius = 50
Circle.Visible = false
Circle.NumSides = 1000
Circle.Filled = false
Circle.Transparency = 1

game:GetService("RunService").RenderStepped:Connect(function()
    local Mouse = game:GetService("UserInputService"):GetMouseLocation()
    Circle.Position = Vector2.new(Mouse.X, Mouse.Y)
end)
getgenv().AimBot = {
FreeForAll= false,
WallCheck = false,
Enabled = false,
FOV = 50,
Smoothness = 0.1
}

local Shoot = false

function FreeForAll(v)
    if getgenv().AimBot.FreeForAll == false or getgenv().TriggerBot.FreeForAll == false then
        if game.Players.LocalPlayer.Team == v.Team then return false
        else return true end
    else return true end
end

local Shoot = false

function NotObstructing(i, v)
    if getgenv().AimBot.WallCheck then
        c = workspace.CurrentCamera.CFrame.p
        a = Ray.new(c, i- c)
        f = workspace:FindPartOnRayWithIgnoreList(a, v)
        return f == nil
    else
        return true
    end
end

game:GetService("UserInputService").InputBegan:Connect(function(v)
    if v.UserInputType == Enum.UserInputType.MouseButton2 then
        Shoot = true
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(v)
    if v.UserInputType == Enum.UserInputType.MouseButton2 then
        Shoot = false
    end
end)

function GetMouse()
    return Vector2.new(game.Players.LocalPlayer:GetMouse().X, game.Players.LocalPlayer:GetMouse().Y)
end
function GetClosestToCuror()
    MousePos = GetMouse()
    Closest = math.huge
    Target = nil
    for _,v in pairs(game:GetService("Players"):GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0  then
                Point,OnScreen = workspace.CurrentCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                if OnScreen and NotObstructing(v.Character.HumanoidRootPart.Position,{game.Players.LocalPlayer.Character,v.Character}) then
                    Distance = (Vector2.new(Point.X,Point.Y) - MousePos).magnitude
                      if Distance <= getgenv().AimBot.FOV then
                          Closest = Distance
                       Target = v
                     end
               end
            end
         end
    return Target
end

game:GetService('RunService').Stepped:connect(function()
    pcall(function()
        if getgenv().AimBot.Enabled == false or Shoot == false then return end
        ClosestPlayer = GetClosestToCuror()
        if ClosestPlayer then
         workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p,ClosestPlayer.Character[getgenv().AimPart].CFrame.p)
        end 
    end)
end)

getgenv().TriggerBot = {
   TeamCheck = false;
   Delay = 0.01;
   Enabled = false;
}

local Aim = false
game:GetService("UserInputService").InputBegan:connect(function(v)
   if v.UserInputType  == Enum.UserInputType.MouseButton2 and getgenv().TriggerBot.Enabled then
       Aim = true
       while Aim do wait()
           if game:GetService("Players").LocalPlayer:GetMouse().Target and game:GetService("Players"):FindFirstChild(game:GetService("Players").LocalPlayer:GetMouse().Target.Parent.Name) then
            local Person = game:GetService("Players"):FindFirstChild(game:GetService("Players").LocalPlayer:GetMouse().Target.Parent.Name)
               if Person.Team ~= game:GetService("Players").LocalPlayer.Team or not getgenv().TriggerBot.TeamCheck then
                   if getgenv().TriggerBot.Delay > 0 then wait(getgenv().TriggerBot.Delay) end
                   mouse1press(); wait(); mouse1release()
               end
           end
           if not getgenv().TriggerBot.Enabled then break end
       end
   end
end)

game:GetService("UserInputService").InputEnded:connect(function(v)
   if v.KeyCode == Enum.UserInputType.MouseButton2 and getgenv().TriggerBot.Enabled then
       Aim = false
   end
end)

--Script--
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("SexHub-V2")

--//Tabs\\--
local WelcomeTab = Window:NewTab("Welcome")
local Main = Window:NewTab("Local Player")
local Combat = Window:NewTab("Combat")
local Guns = Window:NewTab("Gun")
local Map = Window:NewTab("Map")
local Visual = Window:NewTab("Visual")
local Server = Window:NewTab("Server")
local Credits = Window:NewTab("Credits")

--// Sections \\--
local WelcomeSection = WelcomeTab:NewSection("Welcome")
local MainSection = Main:NewSection("Player")
local CombatSection = Combat:NewSection("Combat")
local GunSection = Guns:NewSection("Gun Cheats")
local GunMSection = Guns:NewSection("Gun Modifications")
local MapSecation = Map:NewSection("Map")
local VisualSection = Visual:NewSection("Visual")
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
WelcomeSection:NewButton("Players In game: "..player_count.." |  Max Players: "..game.Players.MaxPlayers)
WelcomeSection:NewButton("Timezone: " .. os.date("%Z"))
--WelcomeSection:NewButton("Time: " .. os.date("%I:%M:%S %p", (os.time())))
_G.EXPLOIT = ''..identifyexecutor();
WelcomeSection:NewButton("Exploit: ".._G.EXPLOIT, "EXPLOIT Name")
WelcomeSection:NewKeybind("UI Key Bind", "PutAnyKeybind", Enum.KeyCode.RightShift, function()
	Library:ToggleUI()
end)

--//Main\\--
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

MainSection:NewToggle("Fly", "", function(State)
    sex2 = State
    local Max = 0
    local Players = game.Players
    local LP = Players.LocalPlayer
    local Mouse = LP:GetMouse()
    Mouse.KeyDown:connect(
        function(V)
            if V:lower() == "V" then
                Max = Max + 1
                getgenv().Fly = false
                if sex2 then
                    local T = LP.Character.UpperTorso
                    local S = {
                        F = 0,
                        B = 0,
                        L = 0,
                        R = 0
                    }
                    local S2 = {
                        F = 0,
                        B = 0,
                        L = 0,
                        R = 0
                    }
                    local SPEED = 5
                    local function FLY()
                        getgenv().Fly = true
                        local BodyGyro = Instance.new("BodyGyro", T)
                        local BodyVelocity = Instance.new("BodyVelocity", T)
                        BodyGyro.P = 9e4
                        BodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
                        BodyGyro.cframe = T.CFrame
                        BodyVelocity.velocity = Vector3.new(0, 0.1, 0)
                        BodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
                        spawn(
                            function()
                                repeat
                                    wait()
                                    LP.Character.Humanoid.PlatformStand = false
                                    if S.L + S.R ~= 0 or S.F + S.B ~= 0 then
                                        SPEED = 200
                                    elseif not (S.L + S.R ~= 0 or S.F + S.B ~= 0) and SPEED ~= 0 then
                                        SPEED = 0
                                    end
                                    if (S.L + S.R) ~= 0 or (S.F + S.B) ~= 0 then
                                        BodyVelocity.velocity =
                                            ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (S.F + S.B)) +
                                            ((game.Workspace.CurrentCamera.CoordinateFrame *
                                                CFrame.new(S.L + S.R, (S.F + S.B) * 0.2, 0).p) -
                                                game.Workspace.CurrentCamera.CoordinateFrame.p)) *
                                            SPEED
                                        S2 = {
                                            F = S.F,
                                            B = S.B,
                                            L = S.L,
                                            R = S.R
                                        }
                                    elseif (S.L + S.R) == 0 and (S.F + S.B) == 0 and SPEED ~= 0 then
                                        BodyVelocity.velocity =
                                            ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (S2.F + S2.B)) +
                                            ((game.Workspace.CurrentCamera.CoordinateFrame *
                                                CFrame.new(S2.L + S2.R, (S2.F + S2.B) * 0.2, 0).p) -
                                                game.Workspace.CurrentCamera.CoordinateFrame.p)) *
                                            SPEED
                                    else
                                        BodyVelocity.velocity = Vector3.new(0, 0.1, 0)
                                    end
                                    BodyGyro.cframe = game.Workspace.CurrentCamera.CoordinateFrame
                                until not getgenv().Fly
                                S = {
                                    F = 0,
                                    B = 0,
                                    L = 0,
                                    R = 0
                                }
                                S2 = {
                                    F = 0,
                                    B = 0,
                                    L = 0,
                                    R = 0
                                }
                                SPEED = 0
                                BodyGyro:destroy()
                                BodyVelocity:destroy()
                                LP.Character.Humanoid.PlatformStand = false
                            end
                        )
                    end
                    Mouse.KeyDown:connect(
                        function(k)
                            if k:lower() == "w" then
                                S.F = 1
                            elseif k:lower() == "s" then
                                S.B = -1
                            elseif k:lower() == "a" then
                                S.L = -1
                            elseif k:lower() == "d" then
                                S.R = 1
                            end
                        end
                    )
                    Mouse.KeyUp:connect(
                        function(k)
                            if k:lower() == "w" then
                                S.F = 0
                            elseif k:lower() == "s" then
                                S.B = 0
                            elseif k:lower() == "a" then
                                S.L = 0
                            elseif k:lower() == "d" then
                                S.R = 0
                            end
                        end
                    )
                    FLY()
                    if Max == 2 then
                        getgenv().Fly = false
                        Max = 0
                    end
                end
            end
        end
    )
end)


MainSection:NewToggle("WalkSpeed", "Toggles WalkSpeed", function(state)
    if state then
      getgenv().WS = true
      if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid") then
        game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid"):GetPropertyChangedSignal("WalkSpeed"):Connect(function()
          if getgenv().WS == true then
            game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid").WalkSpeed = 50
          end
        end)
      end
    else
      getgenv().WS = false
      wait(0.04)
      if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid") then
        game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid").WalkSpeed = 13
      end
    end
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

MainSection:NewSlider("WalkSpeed", "Select your WalkSpeed", 100, 20, function(a)
  WalkSpeedValue = a
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

MainSection:NewButton("Shit to tpwalk", "", function()
	tpwalking = false

	game:GetService("UserInputService").InputBegan:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.LeftShift then
			tpwalking = not tpwalking
			local chr = game.Players.LocalPlayer.Character
		local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
		while tpwalking and hum and hum.Parent do
	wait()
			if hum.MoveDirection.Magnitude > 0 then
				chr:TranslateBy(hum.MoveDirection)
			end
		end
		end
	end)

	if input.KeyCode == Enum.KeyCode.LeftShift then
	tpwalking = true
    end
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

MainSection:NewSlider("Player Fov","Set The Player Fov", 120, 70, function(v)
    game:GetService'Workspace'.Camera.FieldOfView = v
end)


--//Combat\\--
CombatSection:NewToggle("Aimbot", "", function(State)
    getgenv().AimBot.Enabled = State
end)

CombatSection:NewToggle("Fov Circle", "", function(State)
    Circle.Visible = State
end)

CombatSection:NewToggle("WallCheck", "", function(State)
    getgenv().AimBot.WallCheck = State
end)

CombatSection:NewToggle("FreeForAll", "", function(State)
    getgenv().AimBot.FreeForAll = State
    getfenv().TriggerBot.TeamCheck = State
end)

CombatSection:NewToggle("TriggerBot", "", function(State)
    getgenv().TriggerBot.Enabled = State
end)


CombatSection:NewSlider("Fov Size", "", 500,0, function(Value)
    getgenv().AimBot.FOV = Value
    Circle.Radius = Value
end)

CombatSection:NewSlider("Aimbot Smoothness", "SliderInfo", 10, 0.1, function(s)
    getgenv().AimBot.Smoothness = s
end)

CombatSection:NewDropdown("AimPart", "HumanoidRootPart", {"Head", "UpperTorso", "LowerTorso","Random"}, function(String)
	getgenv().AimPart = String
end)

CombatSection:NewToggle("Silent Aim", "Auto Aim Actions", function(state)
    if state then
    getgenv().SilentAim = true

    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Mouse = LocalPlayer:GetMouse()
    function ClosestPlayerToCurser()
        local MaxDistance, Closest = math.huge
        for i,v in pairs(Players.GetPlayers(Players)) do
            if v ~= LocalPlayer  and v.Character then
                local H = v.Character.FindFirstChild(v.Character, "Head")
                if H then 
                    local Pos, Vis = workspace.CurrentCamera.WorldToScreenPoint(workspace.CurrentCamera, H.Position)
                    if Vis then
                        local A1, A2 = Vector2.new(Mouse.X, Mouse.Y), Vector2.new(Pos.X, Pos.Y)
                        local Dist = (A2 - A1).Magnitude
                        if Dist < MaxDistance and Dist <= math.huge then
                            MaxDistance = Dist
                            Closest = v
                        end
                    end
                end
            end
        end
        return Closest
    end

    for Fuck, You in next,getgc() do
       if getfenv(You).script == game.Players.LocalPlayer.PlayerScripts.PlayerModule.CameraModule.ZoomController.Popper and typeof(You) == "function" and getgenv().SilentAim then
           for Ass, Head in next, getconstants(You) do
               if tonumber(Head) == 0.25 then
                   setconstant(You,Ass,0)
               elseif tonumber(Head) == 0 then
                   setconstant(You,Ass,0.25)
               end
           end
       end
    end

    loadstring(game:HttpGet("https://raw.githubusercontent.com/1201for/V.G_Hub_Extras/main/RayCast_Method"))()
else
    getgenv().SilentAim = false
end
end)

CombatSection:NewColorPicker("Circle Color", "Color Info", Color3.fromRGB(0,0,0), function(color)
    Circle.Color = color
end)

CombatSection:NewToggle("Hitbox", "", function(State)
    doodoo = State

    while doodoo do
        wait(1)
         pcall(function()
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character then
                v.Character.LowerTorso.CanCollide = false
                v.Character.LowerTorso.Material = "Neon"
                v.Character.LowerTorso.Transparency = 0.5
                v.Character.LowerTorso.Size = Vector3.new(head, head, head)
                v.Character.HumanoidRootPart.Size = Vector3.new(head, head, head)
            end
        end
    end)
    end
end)

CombatSection:NewSlider("Hitbox Size", 1, 10, 1, function(Value)
    head = Value
end)

GunSection:NewButton("Gun Mods", "Mod The Guns", function()
    local aux = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Upbolt/Hydroxide/revision/ohaux.lua"))()

    local scriptPath = game:GetService("Players").LocalPlayer.Character.Saude["Client_System"]
    local closureName = "ChamberBKAnim"
    local upvalueIndex = 9
    local closureConstants = {
        [1] = "ChamberBKAnim",
        [2] = "GripW",
        [3] = "Value"
    }

    local closure = aux.searchClosure(scriptPath, closureName, upvalueIndex, closureConstants)
    local value = 999999999999999
    local elementIndex = "Ammo"

    debug.getupvalue(closure, upvalueIndex)[elementIndex] = value
    local aux = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Upbolt/Hydroxide/revision/ohaux.lua"))()

    local scriptPath = game:GetService("Players").LocalPlayer.Character.Saude["Client_System"]
    local closureName = "recoil"
    local upvalueIndex = 6
    local closureConstants = {
        [1] = "spawn",
        [2] = aux.placeholderUserdataConstant,
        [3] = "SmokePart",
        [4] = "FindFirstChild",
        [5] = "pairs",
        [6] = aux.placeholderUserdataConstant
    }

    local closure = aux.searchClosure(scriptPath, closureName, upvalueIndex, closureConstants)
    local value = 20
    local elementIndex = "Bullets"

    debug.getupvalue(closure, upvalueIndex)[elementIndex] = value
    local aux = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Upbolt/Hydroxide/revision/ohaux.lua"))()

    local scriptPath = game:GetService("Players").LocalPlayer.Character.Saude["Client_System"]
    local closureName = "Unnamed function"
    local upvalueIndex = 13
    local closureConstants = {
        [1] = "Tool",
        [2] = "IsA",
        [3] = "ACS_Modulo",
        [4] = "FindFirstChild",
        [5] = "ACS_Setup",
        [6] = "Health"
    }

    local closure = aux.searchClosure(scriptPath, closureName, upvalueIndex, closureConstants)
    local value = 0
    local elementIndex = "MaxSpread"

    debug.getupvalue(closure, upvalueIndex)[elementIndex] = value
    local aux = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Upbolt/Hydroxide/revision/ohaux.lua"))()

    local scriptPath = game:GetService("Players").LocalPlayer.Character.Saude["Client_System"]
    local closureName = "Unnamed function"
    local upvalueIndex = 13
    local closureConstants = {
        [1] = "Tool",
        [2] = "IsA",
        [3] = "ACS_Modulo",
        [4] = "FindFirstChild",
        [5] = "ACS_Setup",
        [6] = "Health"
    }

    local closure = aux.searchClosure(scriptPath, closureName, upvalueIndex, closureConstants)
    local value = 0
    local elementIndex = "MinSpread"

    debug.getupvalue(closure, upvalueIndex)[elementIndex] = value
end)

GunMSection:NewToggle("RGB Body", "", function(state)
	if state then
	getgenv().chams = true
	repeat wait()
	if getgenv().chams == true then
	Blacklisted = {"Flame", "SightMark", "SightMark2A", "Tip", "Trigger"}
	workspace.CurrentCamera.DescendantAdded:Connect(function(O)
		if O:IsA("BasePart") and not table.find(Blacklisted, O.Name) then
			spawn(function()
				while wait() do
					O.Color = Color3.fromHSV((tick() % 5 / 5), 1, 1)
					O.Transparency = 0.8
					O.Material = Enum.Material.ForceField
				end
			end)
		end
	end)
	end
	until getgenv().chams == false
	else
		getgenv().chams = false
	end
end)

--//Map\\--
MapSecation:NewToggle("FullBright", "", function(state)
    FullBright = state
    if FullBright then
        game:GetService("Lighting").Ambient = Color3.new(1, 1, 1)
        game:GetService("Lighting").ColorShift_Bottom = Color3.new(1, 1, 1)
        game:GetService("Lighting").ColorShift_Top = Color3.new(1, 1, 1)
    else
        game:GetService("Lighting").Ambient = Color3.new(0, 0, 0)
        game:GetService("Lighting").ColorShift_Bottom = Color3.new(0, 0, 0)
        game:GetService("Lighting").ColorShift_Top = Color3.new(0, 0, 0)
    end
game.Lighting.Changed:connect(
function()
    if FullBright then
        game:GetService("Lighting").Ambient = Color3.new(1, 1, 1)
        game:GetService("Lighting").ColorShift_Bottom = Color3.new(1, 1, 1)
        game:GetService("Lighting").ColorShift_Top = Color3.new(1, 1, 1)
    else
        game:GetService("Lighting").Ambient = Color3.new(0, 0, 0)
        game:GetService("Lighting").ColorShift_Bottom = Color3.new(0, 0, 0)
        game:GetService("Lighting").ColorShift_Top = Color3.new(0, 0, 0)
    end
end
)
end)

MapSecation:NewButton("Anti Lag", "", function()
for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
    if v:IsA("BasePart") and not v.Parent:FindFirstChild("Humanoid") then --- i stole this from the actual game LOL >-<
        v.Material = Enum.Material.SmoothPlastic
        if v:IsA("Texture") then
            v:Destroy()
        end
    end
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

VisualSection:NewToggle("Draw Team Color", "Draw Color By Team", function(state)
    if state then
    ESP.TeamColor = true
    else
    ESP.TeamColor = false
    end
end)

VisualSection:NewToggle("Team Check", "Esp On Your Team", function(state)
    if state then
    ESP.TeamMates = true
    else
    ESP.TeamMates = false
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

--//Server\\--
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