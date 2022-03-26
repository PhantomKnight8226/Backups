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
WallCheck = false,
Enabled = false,
FOV = 50,
Smoothness = 0.1
}

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

game:GetService("RunService").RenderStepped:Connect(
    function()
        if getgenv().AimBot.Enabled == false or Shoot == false then
            return
        end
        ClosestPlayer = GetClosestToCuror()
        if ClosestPlayer then
           workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p,ClosestPlayer.Character.HumanoidRootPart.CFrame.p)
        end
    end
)

--Script--
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("SexHub-V2")

--//Tabs\\--
local WelcomeTab = Window:NewTab("Welcome")
local Main = Window:NewTab("Local Player")
local Combat = Window:NewTab("Combat")
local Map = Window:NewTab("Map")
local Visual = Window:NewTab("Visual")
local Server = Window:NewTab("Server")
local Credits = Window:NewTab("Credits")

--// Sections \\--
local WelcomeSection = WelcomeTab:NewSection("Welcome")
local MainSection = Main:NewSection("Player")
local CombatSection = Combat:NewSection("Combat")
local PlayerModsSection = Combat:NewSection("Player Mods")
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

MainSection:NewToggle("Fly", "Toggle Fly", function(state)
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
CombatSection:NewToggle("Aimbot-Head", "", function(state)
    if state then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HyperNIt3/Backups/main/SexHubV2/AimbotHead.lua"))()
    else
        getgenv().Aimbot.Settings = {
            SendNtiations = false,
            Savtings = false, -- Re-execute upon changing
            Reloadeleport = false,
            Enabled = false,
            AliveCheck = true,
            WallCheck = true, -- Laggy
            Sensitivity = 0, -- Animation length (in seconds) before fully locking onto target
            TriggerKey = "MouseButton2",
            Toggle = false,
            LockPart = "Head" -- Body part to lock on
        }
    end
end)
CombatSection:NewToggle("Aimbot-Body", "", function(State)
    getgenv().AimBot.Enabled = State
end)

CombatSection:NewToggle("Fov Circle", "", function(State)
    Circle.Visible = State
end)

CombatSection:NewToggle("WallCheck", "", function(State)
    getgenv().AimBot.WallCheck = State
end)

CombatSection:NewSlider("Fov Size", "", 500,0, function(Value)
    getgenv().AimBot.FOV = Value
    Circle.Radius = Value
end)

CombatSection:NewSlider("Aimbot Smoothness", "SliderInfo", 10, 0.1, function(s)
    getgenv().AimBot.Smoothness = s
end)

CombatSection:NewToggle("Silent Aim", "Auto Doing Actions", function(state)
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

CombatSection:NewSlider("Hitbox size", 1, 10, 1, function(s)
    _G.HeadSize = s

    game:GetService('RunService').RenderStepped:connect(function()
    if _G.Disabled then
    for i,v in next, game:GetService('Players'):GetPlayers() do
    if v.Name ~= game:GetService('Players').LocalPlayer.Name then
    pcall(function()
    v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
    v.Character.HumanoidRootPart.Transparency = 0.2
    v.Character.HumanoidRootPart.BrickColor = BrickColor.new("White")
    v.Character.HumanoidRootPart.Material = nil
    v.Character.HumanoidRootPart.CanCollide = false
    end)
    end
    end
    end
    end)
end)

CombatSection:NewSlider("Hitbox Transparency", 1, 10, 1, function(n)
    for i,v in next, game:GetService('Players'):GetPlayers() do
        if v.Name ~= game:GetService('Players').LocalPlayer.Name then
            v.Character.HumanoidRootPart.Transparency = n
        end
    end
end)

PlayerModsSection:NewToggle("Infinite Sprint ", "Sprint", function(state)
    if state then
        getgenv().InfSprint = true
        repeat wait()
        if getgenv().InfSprint == true then
        local Sprint = game:GetService("ReplicatedStorage").CharStats[game:GetService("Players").LocalPlayer.Name].Sprinting
        Sprint.Changed:Connect(function()
            if getgenv().InfSprint == true then
                Sprint.Value = false
            end
        end)
    end
    until getgenv().InfSprint == false
    else
     getgenv().InfSprint = false
    end
end)

PlayerModsSection:NewButton("No Fall Damage", "No Fall Damage", function()
    game:GetService("ReplicatedStorage").Events["__DFfDD"]:Destroy()
end)

PlayerModsSection:NewButton("Respawn", "Reset Your Character", function()
    game:GetService("Workspace").Characters.LocalPlayer.Humanoid.Health = 0
end)

PlayerModsSection:NewButton("Headless", "Gives You Headless", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/carlcoded/pro/main/headlessperma"))()
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

MapSecation:NewButton("Free Cam", "", function()
    function sandbox(var,func)
        local env = getfenv(func)
        local newenv = setmetatable({},{
        __index = function(self,k)
        if k=="script" then
        return var
        else
        return env[k]
        end
        end,
        })
        setfenv(func,newenv)
        return func
        end
        cors = {}
        mas = Instance.new("Model",game:GetService("Lighting"))
        LocalScript0 = Instance.new("LocalScript")
        LocalScript0.Name = "FreeCamera"
        LocalScript0.Parent = mas
        table.insert(cors,sandbox(LocalScript0,function()

        local pi    = math.pi
        local abs   = math.abs
        local clamp = math.clamp
        local exp   = math.exp
        local rad   = math.rad
        local sign  = math.sign
        local sqrt  = math.sqrt
        local tan   = math.tan
        
        local ContextActionService = game:GetService("ContextActionService")
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local StarterGui = game:GetService("StarterGui")
        local UserInputService = game:GetService("UserInputService")
        
        local LocalPlayer = Players.LocalPlayer
        if not LocalPlayer then
        Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
        LocalPlayer = Players.LocalPlayer
        end
        
        local Camera = workspace.CurrentCamera
        workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
        local newCamera = workspace.CurrentCamera
        if newCamera then
        Camera = newCamera
        end
        end)
        
        ------------------------------------------------------------------------
        
        local TOGGLE_INPUT_PRIORITY = Enum.ContextActionPriority.Low.Value
        local INPUT_PRIORITY = Enum.ContextActionPriority.High.Value
        local FREECAM_MACRO_KB = {Enum.KeyCode.LeftShift, Enum.KeyCode.P}
        
        local NAV_GAIN = Vector3.new(1, 1, 1)*64
        local PAN_GAIN = Vector2.new(0.75, 1)*8
        local FOV_GAIN = 300
        
        local PITCH_LIMIT = rad(90)
        
        local VEL_STIFFNESS = 1.5
        local PAN_STIFFNESS = 1.0
        local FOV_STIFFNESS = 4.0
        
        ------------------------------------------------------------------------
        
        local Spring = {} do
        Spring.__index = Spring
        
        function Spring.new(freq, pos)
        local self = setmetatable({}, Spring)
        self.f = freq
        self.p = pos
        self.v = pos*0
        return self
        end
        
        function Spring:Update(dt, goal)
        local f = self.f*2*pi
        local p0 = self.p
        local v0 = self.v
        
        local offset = goal - p0
        local decay = exp(-f*dt)
        
        local p1 = goal + (v0*dt - offset*(f*dt + 1))*decay
        local v1 = (f*dt*(offset*f - v0) + v0)*decay
        
        self.p = p1
        self.v = v1
        
        return p1
        end
        
        function Spring:Reset(pos)
        self.p = pos
        self.v = pos*0
        end
        end
        
        ------------------------------------------------------------------------
        
        local cameraPos = Vector3.new()
        local cameraRot = Vector2.new()
        local cameraFov = 0
        
        local velSpring = Spring.new(VEL_STIFFNESS, Vector3.new())
        local panSpring = Spring.new(PAN_STIFFNESS, Vector2.new())
        local fovSpring = Spring.new(FOV_STIFFNESS, 0)
        
        ------------------------------------------------------------------------
        
        local Input = {} do
        local thumbstickCurve do
        local K_CURVATURE = 2.0
        local K_DEADZONE = 0.15
        
        local function fCurve(x)
        return (exp(K_CURVATURE*x) - 1)/(exp(K_CURVATURE) - 1)
        end
        
        local function fDeadzone(x)
        return fCurve((x - K_DEADZONE)/(1 - K_DEADZONE))
        end
        
        function thumbstickCurve(x)
        return sign(x)*clamp(fDeadzone(abs(x)), 0, 1)
        end
        end
        
        local gamepad = {
        ButtonX = 0,
        ButtonY = 0,
        DPadDown = 0,
        DPadUp = 0,
        ButtonL2 = 0,
        ButtonR2 = 0,
        Thumbstick1 = Vector2.new(),
        Thumbstick2 = Vector2.new(),
        }
        
        local keyboard = {
        W = 0,
        A = 0,
        S = 0,
        D = 0,
        E = 0,
        Q = 0,
        U = 0,
        H = 0,
        J = 0,
        K = 0,
        I = 0,
        Y = 0,
        Up = 0,
        Down = 0,
        LeftShift = 0,
        RightShift = 0,
        }
        
        local mouse = {
        Delta = Vector2.new(),
        MouseWheel = 0,
        }
        
        local NAV_GAMEPAD_SPEED  = Vector3.new(1, 1, 1)
        local NAV_KEYBOARD_SPEED = Vector3.new(1, 1, 1)
        local PAN_MOUSE_SPEED    = Vector2.new(1, 1)*(pi/64)
        local PAN_GAMEPAD_SPEED  = Vector2.new(1, 1)*(pi/8)
        local FOV_WHEEL_SPEED    = 1.0
        local FOV_GAMEPAD_SPEED  = 0.25
        local NAV_ADJ_SPEED      = 0.75
        local NAV_SHIFT_MUL      = 0.25
        
        local navSpeed = 1
        
        function Input.Vel(dt)
        navSpeed = clamp(navSpeed + dt*(keyboard.Up - keyboard.Down)*NAV_ADJ_SPEED, 0.01, 4)
        
        local kGamepad = Vector3.new(
        thumbstickCurve(gamepad.Thumbstick1.x),
        thumbstickCurve(gamepad.ButtonR2) - thumbstickCurve(gamepad.ButtonL2),
        thumbstickCurve(-gamepad.Thumbstick1.y)
        )*NAV_GAMEPAD_SPEED
        
        local kKeyboard = Vector3.new(
        keyboard.D - keyboard.A + keyboard.K - keyboard.H,
        keyboard.E - keyboard.Q + keyboard.I - keyboard.Y,
        keyboard.S - keyboard.W + keyboard.J - keyboard.U
        )*NAV_KEYBOARD_SPEED
        
        local shift = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift)
        
        return (kGamepad + kKeyboard)*(navSpeed*(shift and NAV_SHIFT_MUL or 1))
        end
        
        function Input.Pan(dt)
        local kGamepad = Vector2.new(
        thumbstickCurve(gamepad.Thumbstick2.y),
        thumbstickCurve(-gamepad.Thumbstick2.x)
        )*PAN_GAMEPAD_SPEED
        local kMouse = mouse.Delta*PAN_MOUSE_SPEED
        mouse.Delta = Vector2.new()
        return kGamepad + kMouse
        end
        
        function Input.Fov(dt)
        local kGamepad = (gamepad.ButtonX - gamepad.ButtonY)*FOV_GAMEPAD_SPEED
        local kMouse = mouse.MouseWheel*FOV_WHEEL_SPEED
        mouse.MouseWheel = 0
        return kGamepad + kMouse
        end
        
        do
        local function Keypress(action, state, input)
        keyboard[input.KeyCode.Name] = state == Enum.UserInputState.Begin and 1 or 0
        return Enum.ContextActionResult.Sink
        end
        
        local function GpButton(action, state, input)
        gamepad[input.KeyCode.Name] = state == Enum.UserInputState.Begin and 1 or 0
        return Enum.ContextActionResult.Sink
        end
        
        local function MousePan(action, state, input)
        local delta = input.Delta
        mouse.Delta = Vector2.new(-delta.y, -delta.x)
        return Enum.ContextActionResult.Sink
        end
        
        local function Thumb(action, state, input)
        gamepad[input.KeyCode.Name] = input.Position
        return Enum.ContextActionResult.Sink
        end
        
        local function Trigger(action, state, input)
        gamepad[input.KeyCode.Name] = input.Position.z
        return Enum.ContextActionResult.Sink
        end
        
        local function MouseWheel(action, state, input)
        mouse[input.UserInputType.Name] = -input.Position.z
        return Enum.ContextActionResult.Sink
        end
        
        local function Zero(t)
        for k, v in pairs(t) do
        t[k] = v*0
        end
        end
        
        function Input.StartCapture()
        ContextActionService:BindActionAtPriority("FreecamKeyboard", Keypress, false, INPUT_PRIORITY,
        Enum.KeyCode.W, Enum.KeyCode.U,
        Enum.KeyCode.A, Enum.KeyCode.H,
        Enum.KeyCode.S, Enum.KeyCode.J,
        Enum.KeyCode.D, Enum.KeyCode.K,
        Enum.KeyCode.E, Enum.KeyCode.I,
        Enum.KeyCode.Q, Enum.KeyCode.Y,
        Enum.KeyCode.Up, Enum.KeyCode.Down
        )
        ContextActionService:BindActionAtPriority("FreecamMousePan",          MousePan,   false, INPUT_PRIORITY, Enum.UserInputType.MouseMovement)
        ContextActionService:BindActionAtPriority("FreecamMouseWheel",        MouseWheel, false, INPUT_PRIORITY, Enum.UserInputType.MouseWheel)
        ContextActionService:BindActionAtPriority("FreecamGamepadButton",     GpButton,   false, INPUT_PRIORITY, Enum.KeyCode.ButtonX, Enum.KeyCode.ButtonY)
        ContextActionService:BindActionAtPriority("FreecamGamepadTrigger",    Trigger,    false, INPUT_PRIORITY, Enum.KeyCode.ButtonR2, Enum.KeyCode.ButtonL2)
        ContextActionService:BindActionAtPriority("FreecamGamepadThumbstick", Thumb,      false, INPUT_PRIORITY, Enum.KeyCode.Thumbstick1, Enum.KeyCode.Thumbstick2)
        end
        
        function Input.StopCapture()
        navSpeed = 1
        Zero(gamepad)
        Zero(keyboard)
        Zero(mouse)
        ContextActionService:UnbindAction("FreecamKeyboard")
        ContextActionService:UnbindAction("FreecamMousePan")
        ContextActionService:UnbindAction("FreecamMouseWheel")
        ContextActionService:UnbindAction("FreecamGamepadButton")
        ContextActionService:UnbindAction("FreecamGamepadTrigger")
        ContextActionService:UnbindAction("FreecamGamepadThumbstick")
        end
        end
        end
        
        local function GetFocusDistance(cameraFrame)
        local znear = 0.1
        local viewport = Camera.ViewportSize
        local projy = 2*tan(cameraFov/2)
        local projx = viewport.x/viewport.y*projy
        local fx = cameraFrame.rightVector
        local fy = cameraFrame.upVector
        local fz = cameraFrame.lookVector
        
        local minVect = Vector3.new()
        local minDist = 512
        
        for x = 0, 1, 0.5 do
        for y = 0, 1, 0.5 do
        local cx = (x - 0.5)*projx
        local cy = (y - 0.5)*projy
        local offset = fx*cx - fy*cy + fz
        local origin = cameraFrame.p + offset*znear
        local part, hit = workspace:FindPartOnRay(Ray.new(origin, offset.unit*minDist))
        local dist = (hit - origin).magnitude
        if minDist > dist then
        minDist = dist
        minVect = offset.unit
        end
        end
        end
        
        return fz:Dot(minVect)*minDist
        end
        
        ------------------------------------------------------------------------
        
        local function StepFreecam(dt)
        local vel = velSpring:Update(dt, Input.Vel(dt))
        local pan = panSpring:Update(dt, Input.Pan(dt))
        local fov = fovSpring:Update(dt, Input.Fov(dt))
        
        local zoomFactor = sqrt(tan(rad(70/2))/tan(rad(cameraFov/2)))
        
        cameraFov = clamp(cameraFov + fov*FOV_GAIN*(dt/zoomFactor), 1, 120)
        cameraRot = cameraRot + pan*PAN_GAIN*(dt/zoomFactor)
        cameraRot = Vector2.new(clamp(cameraRot.x, -PITCH_LIMIT, PITCH_LIMIT), cameraRot.y%(2*pi))
        
        local cameraCFrame = CFrame.new(cameraPos)*CFrame.fromOrientation(cameraRot.x, cameraRot.y, 0)*CFrame.new(vel*NAV_GAIN*dt)
        cameraPos = cameraCFrame.p
        
        Camera.CFrame = cameraCFrame
        Camera.Focus = cameraCFrame*CFrame.new(0, 0, -GetFocusDistance(cameraCFrame))
        Camera.FieldOfView = cameraFov
        end
        
        ------------------------------------------------------------------------
        
        local PlayerState = {} do
        local mouseIconEnabled
        local cameraSubject
        local cameraType
        local cameraFocus
        local cameraCFrame
        local cameraFieldOfView
        local screenGuis = {}
        local coreGuis = {
        Backpack = true,
        Chat = true,
        Health = true,
        PlayerList = true,
        }
        local setCores = {
        BadgesNotificationsActive = true,
        PointsNotificationsActive = true,
        }
        
        -- Save state and set up for freecam
        function PlayerState.Push()
        for name in pairs(coreGuis) do
        coreGuis[name] = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType[name])
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType[name], false)
        end
        for name in pairs(setCores) do
        setCores[name] = StarterGui:GetCore(name)
        StarterGui:SetCore(name, false)
        end
        local playergui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
        if playergui then
        for _, gui in pairs(playergui:GetChildren()) do
        if gui:IsA("ScreenGui") and gui.Enabled then
        screenGuis[#screenGuis + 1] = gui
        gui.Enabled = false
        end
        end
        end

        cameraFieldOfView = Camera.FieldOfView
        Camera.FieldOfView = 70

        cameraType = Camera.CameraType
        Camera.CameraType = Enum.CameraType.Custom

        cameraSubject = Camera.CameraSubject
        Camera.CameraSubject = nil

        cameraCFrame = Camera.CFrame
        cameraFocus = Camera.Focus

        mouseIconEnabled = UserInputService.MouseIconEnabled
        UserInputService.MouseIconEnabled = false

        mouseBehavior = UserInputService.MouseBehavior
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        end

        -- Restore state
        function PlayerState.Pop()
        for name, isEnabled in pairs(coreGuis) do
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType[name], isEnabled)
        end
        for name, isEnabled in pairs(setCores) do
        StarterGui:SetCore(name, isEnabled)
        end
        for _, gui in pairs(screenGuis) do
        if gui.Parent then
        gui.Enabled = true
        end
        end

        Camera.FieldOfView = cameraFieldOfView
        cameraFieldOfView = nil

        Camera.CameraType = cameraType
        cameraType = nil

        Camera.CameraSubject = cameraSubject
        cameraSubject = nil

        Camera.CFrame = cameraCFrame
        cameraCFrame = nil

        Camera.Focus = cameraFocus
        cameraFocus = nil

        UserInputService.MouseIconEnabled = mouseIconEnabled
        mouseIconEnabled = nil

        UserInputService.MouseBehavior = mouseBehavior
        mouseBehavior = nil
        end
        end

        local function StartFreecam()
        local cameraCFrame = Camera.CFrame
        cameraRot = Vector2.new(cameraCFrame:toEulerAnglesYXZ())
        cameraPos = cameraCFrame.p
        cameraFov = Camera.FieldOfView

        velSpring:Reset(Vector3.new())
        panSpring:Reset(Vector2.new())
        fovSpring:Reset(0)

        PlayerState.Push()
        RunService:BindToRenderStep("Freecam", Enum.RenderPriority.Camera.Value, StepFreecam)
        Input.StartCapture()
        end

        local function StopFreecam()
        Input.StopCapture()
        RunService:UnbindFromRenderStep("Freecam")
        PlayerState.Pop()
        end

        ------------------------------------------------------------------------

        do
        local enabled = false

        local function ToggleFreecam()
        if enabled then
        StopFreecam()
        else
        StartFreecam()
        end
        enabled = not enabled
        end

        local function CheckMacro(macro)
        for i = 1, #macro - 1 do
        if not UserInputService:IsKeyDown(macro[i]) then
        return
        end
        end
        ToggleFreecam()
        end

        local function HandleActivationInput(action, state, input)
        if state == Enum.UserInputState.Begin then
        if input.KeyCode == FREECAM_MACRO_KB[#FREECAM_MACRO_KB] then
        CheckMacro(FREECAM_MACRO_KB)
        end
        end
        return Enum.ContextActionResult.Pass
        end

        ContextActionService:BindActionAtPriority("FreecamToggle", HandleActivationInput, false, TOGGLE_INPUT_PRIORITY, FREECAM_MACRO_KB[#FREECAM_MACRO_KB])
        end
        end))
        for i,v in pairs(mas:GetChildren()) do
        v.Parent = game:GetService("Players").LocalPlayer.PlayerGui
        pcall(function() v:MakeJoints() end)
        end
        mas:Destroy()
        for i,v in pairs(cors) do
        spawn(function()
        pcall(v)
        end)
        end
end)

MapSecation:NewToggle("Enable Chat", "Let You See Chat History", function(state)
    if state then
        game:GetService("Players").LocalPlayer.PlayerGui.Chat.Frame.ChatChannelParentFrame.Visible = true
    else
        game:GetService("Players").LocalPlayer.PlayerGui.Chat.Frame.ChatChannelParentFrame.Visible = false
    end
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

VisualSection:NewToggle("Draw Delar", "Draw Box on Delar", function(state)
    if state then

    else

    end
end)

VisualSection:NewToggle("Draw Atm Soon!", "Draw Box on ATM", function(state)
    if state then

    else

    end
end)


VisualSection:NewButton("Esp Register", "", function()
    function create(safe)
        pcall(function() if (safe.Ahh.Enabled == true) then safe.Ahh:Destroy() end end)
        local x = Instance.new('BillboardGui',safe)
        x.Name = "Ahh"
        x.AlwaysOnTop = true
        x.Size = UDim2.new(1.2,0,1.2,0)
        local b = Instance.new('Frame',x)
        b.Size = UDim2.new(1.2,0,1.2,0)
        x.Adornee = safe
        if safe.Values.Broken.Value ~= false then b.BackgroundColor3 = Color3.new(255,0,0) else b.BackgroundColor3 = Color3.new(128,234,255) end
     end
     
     game:GetService("RunService").Heartbeat:Connect(function()
        for i,v in pairs(game:GetService("Workspace").Map.BredMakurz:GetChildren()) do
            create(v)
        end
     end)
end)

VisualSection:NewButton("Esp Radar", "More Radar Options Will Add Soon", function()
local Players = game:service("Players")
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local Camera = game:service("Workspace").CurrentCamera
local RS = game:service("RunService")
local UIS = game:service("UserInputService")

repeat wait() until Player.Character ~= nil and Player.Character.PrimaryPart ~= nil

local LerpColorModule = loadstring(game:HttpGet("https://pastebin.com/raw/wRnsJeid"))()
local HealthBarLerp = LerpColorModule:Lerp(Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 255, 0))

local function NewCircle(Transparency, Color, Radius, Filled, Thickness)
    local c = Drawing.new("Circle")
    c.Transparency = Transparency
    c.Color = Color
    c.Visible = false
    c.Thickness = Thickness
    c.Position = Vector2.new(0, 0)
    c.Radius = Radius
    c.NumSides = math.clamp(Radius*55/100, 10, 75)
    c.Filled = Filled
    return c
end

local RadarInfo = {
    Position = Vector2.new(200, 200),
    Radius = 100,
    Scale = 1, -- Determinant factor on the effect of the relative position for the 2D integration
    RadarBack = Color3.fromRGB(10, 10, 10),
    RadarBorder = Color3.fromRGB(75, 75, 75),
    LocalPlayerDot = Color3.fromRGB(255, 255, 255),
    PlayerDot = Color3.fromRGB(60, 170, 255),
    Team = Color3.fromRGB(0, 255, 0),
    Enemy = Color3.fromRGB(255, 0, 0),
    Health_Color = true,
    Team_Check = true
}

local RadarBackground = NewCircle(0.9, RadarInfo.RadarBack, RadarInfo.Radius, true, 1)
RadarBackground.Visible = true
RadarBackground.Position = RadarInfo.Position

local RadarBorder = NewCircle(0.75, RadarInfo.RadarBorder, RadarInfo.Radius, false, 3)
RadarBorder.Visible = true
RadarBorder.Position = RadarInfo.Position

local function GetRelative(pos)
    local char = Player.Character
    if char ~= nil and char.PrimaryPart ~= nil then
        local pmpart = char.PrimaryPart
        local camerapos = Vector3.new(Camera.CFrame.Position.X, pmpart.Position.Y, Camera.CFrame.Position.Z)
        local newcf = CFrame.new(pmpart.Position, camerapos)
        local r = newcf:PointToObjectSpace(pos)
        return r.X, r.Z
    else
        return 0, 0
    end
end

local function PlaceDot(plr)
    local PlayerDot = NewCircle(1, RadarInfo.PlayerDot, 3, true, 1)

    local function Update()
        local c 
        c = game:service("RunService").RenderStepped:Connect(function()
            local char = plr.Character
            if char and char:FindFirstChildOfClass("Humanoid") and char.PrimaryPart ~= nil and char:FindFirstChildOfClass("Humanoid").Health > 0 then
                local hum = char:FindFirstChildOfClass("Humanoid")
                local scale = RadarInfo.Scale
                local relx, rely = GetRelative(char.PrimaryPart.Position)
                local newpos = RadarInfo.Position - Vector2.new(relx * scale, rely * scale) 
                
                if (newpos - RadarInfo.Position).magnitude < RadarInfo.Radius-2 then 
                    PlayerDot.Radius = 3   
                    PlayerDot.Position = newpos
                    PlayerDot.Visible = true
                else 
                    local dist = (RadarInfo.Position - newpos).magnitude
                    local calc = (RadarInfo.Position - newpos).unit * (dist - RadarInfo.Radius)
                    local inside = Vector2.new(newpos.X + calc.X, newpos.Y + calc.Y)
                    PlayerDot.Radius = 2
                    PlayerDot.Position = inside
                    PlayerDot.Visible = true
                end

                PlayerDot.Color = RadarInfo.PlayerDot
                if RadarInfo.Team_Check then
                    if plr.TeamColor == Player.TeamColor then
                        PlayerDot.Color = RadarInfo.Team
                    else
                        PlayerDot.Color = RadarInfo.Enemy
                    end
                end

                if RadarInfo.Health_Color then
                    PlayerDot.Color = HealthBarLerp(hum.Health / hum.MaxHealth)
                end
            else 
                PlayerDot.Visible = false
                if Players:FindFirstChild(plr.Name) == nil then
                    PlayerDot:Remove()
                    c:Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(Update)()
end

for _,v in pairs(Players:GetChildren()) do
    if v.Name ~= Player.Name then
        PlaceDot(v)
    end
end

local function NewLocalDot()
    local d = Drawing.new("Triangle")
    d.Visible = true
    d.Thickness = 1
    d.Filled = true
    d.Color = RadarInfo.LocalPlayerDot
    d.PointA = RadarInfo.Position + Vector2.new(0, -6)
    d.PointB = RadarInfo.Position + Vector2.new(-3, 6)
    d.PointC = RadarInfo.Position + Vector2.new(3, 6)
    return d
end

local LocalPlayerDot = NewLocalDot()

Players.PlayerAdded:Connect(function(v)
    if v.Name ~= Player.Name then
        PlaceDot(v)
    end
    LocalPlayerDot:Remove()
    LocalPlayerDot = NewLocalDot()
end)

-- Loop
coroutine.wrap(function()
    local c
    c = game:service("RunService").RenderStepped:Connect(function()
        if LocalPlayerDot ~= nil then
            LocalPlayerDot.Color = RadarInfo.LocalPlayerDot
            LocalPlayerDot.PointA = RadarInfo.Position + Vector2.new(0, -6)
            LocalPlayerDot.PointB = RadarInfo.Position + Vector2.new(-3, 6)
            LocalPlayerDot.PointC = RadarInfo.Position + Vector2.new(3, 6)
        end
        RadarBackground.Position = RadarInfo.Position
        RadarBackground.Radius = RadarInfo.Radius
        RadarBackground.Color = RadarInfo.RadarBack

        RadarBorder.Position = RadarInfo.Position
        RadarBorder.Radius = RadarInfo.Radius
        RadarBorder.Color = RadarInfo.RadarBorder
    end)
end)()

-- Draggable
local inset = game:service("GuiService"):GetGuiInset()

local dragging = false
local offset = Vector2.new(0, 0)
UIS.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and (Vector2.new(Mouse.X, Mouse.Y + inset.Y) - RadarInfo.Position).magnitude < RadarInfo.Radius then
        offset = RadarInfo.Position - Vector2.new(Mouse.X, Mouse.Y)
        dragging = true
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

coroutine.wrap(function()
    local dot = NewCircle(1, Color3.fromRGB(255, 255, 255), 3, true, 1)
    local c 
    c = game:service("RunService").RenderStepped:Connect(function()
        if (Vector2.new(Mouse.X, Mouse.Y + inset.Y) - RadarInfo.Position).magnitude < RadarInfo.Radius then
            dot.Position = Vector2.new(Mouse.X, Mouse.Y + inset.Y)
            dot.Visible = true
        else 
            dot.Visible = false
        end
        if dragging then
            RadarInfo.Position = Vector2.new(Mouse.X, Mouse.Y) + offset
        end
    end)
end)()

--[[ Example:
wait(3)
RadarInfo.Position = Vector2.new(300, 300)
RadarInfo.Radius = 150
RadarInfo.RadarBack = Color3.fromRGB(50, 0, 0)
]]
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