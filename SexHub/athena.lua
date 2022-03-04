-- Wait for game to load
repeat wait() until game:IsLoaded()

-- Synapse Compatibilities
if syn then
    queue_on_teleport = syn.queue_on_teleport
    request = syn.request
end

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

--Teleport
local player = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")
local Mouse = player:GetMouse()

local mt = getrawmetatable(game)
setreadonly(mt, false)
local old = mt.__index

local deb = false  
local opos = player.Character.HumanoidRootPart.CFrame

mt.__index = newcclosure(function(self, key)
    if self == "HumanoidRootPart" and self.Parent == player.Character and key == "CFrame" and deb then
        return opos
    end
    return old(self, key)
end)

local function tp(newpos)
    if player.Character ~= nil and player.Character:FindFirstChild("HumanoidRootPart") ~= nil then
        opos = player.Character.HumanoidRootPart.CFrame
        deb = true
        player.Character.HumanoidRootPart.CFrame = CFrame.new(newpos)
        deb = false
    end
end

UIS.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
        tp(Mouse.Hit.p + Vector3.new(0, 3, 0))
    end
end)

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("SexHub")

--//Tabs\\--
local WelcomeTab = Window:NewTab("Welcome")
local Main = Window:NewTab("Local Player")
local Combat = Window:NewTab("Combat")
local Teleport = Window:NewTab("Teleport")
local Visual = Window:NewTab("Visual")
local Server = Window:NewTab("Server")
local Credits = Window:NewTab("Credits")

--// Sections \\--
local WelcomeSection = WelcomeTab:NewSection("Welcome")
local MainSection = Main:NewSection("Player")
local CombatSection = Combat:NewSection("Combat")
local TeleportSection = Teleport:NewSection("Towns")
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
WelcomeSection:NewButton("Players In game: "..player_count.." |  Max Players: "..game.Players.MaxPlayers, "Show You How Many Players On Server You Play in")
    _G.EXPLOIT = ''..identifyexecutor();
WelcomeSection:NewButton("Exploit: ".._G.EXPLOIT, "EXPLOIT Name")
WelcomeSection:NewKeybind("UI Key Bind", "PutAnyKeybind", Enum.KeyCode.RightShift, function()
	Library:ToggleUI()
end)


--//Main\\--
MainSection:NewSlider("WalkSpeed", "", 500, 16, function(v)
	local Player = game:GetService("Players").LocalPlayer

	local cody = v
	local function LoopWS(Char)
		if Char then
			local man = Char:WaitForChild("Humanoid")
			man:GetPropertyChangedSignal("WalkSpeed"):Connect(function() man.WalkSpeed = cody end)
			man.WalkSpeed = cody
		end
	end

	LoopWS(Player.Character)
	Player.CharacterAdded:Connect(LoopWS)
end)

MainSection:NewSlider("JumpPower", "JumpPower", 500, 50, function(v)
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

MainSection:NewToggle("Fly", "Fly", function(state)
	if state then
		loadstring(game:HttpGet(('https://raw.githubusercontent.com/MostafaXc00dy/MostafaXc00dy/main/n/banned/sema'),true))()
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

MainSection:NewToggle("Low Grafity", "It Like JumpPower", function(state)
	if state then
		getgenv().Grafity = true
		repeat wait()
		if getgenv().Grafity == true then
		local p = game.Players.LocalPlayer.Character.HumanoidRootPart
		local yeah_this_is_yeah = Instance.new("BodyForce")
		yeah_this_is_yeah.Parent = p
		yeah_this_is_yeah.Force = Vector3.new(0, 1500, 0)
		end
	until getgenv().Grafity == false
	else
		getgenv().Grafity = false
	end
end)

MainSection:NewSlider("Player Fov","Player Fov", 120, 70, function(v)
	game:GetService'Workspace'.Camera.FieldOfView = v
end)

--//Combat\\--
CombatSection:NewToggle("Aimlock", "", function(state)
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
		_G.CircleTransparency = 1
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

CombatSection:NewToggle("Fov", "", function(state)
    if state then
        _G.CircleVisible = true
    else
        _G.CircleVisible = false
    end
end)

CombatSection:NewToggle("Fov Filled", "", function(state)
    if state then
        _G.CircleFilled = true
    else
        _G.CircleFilled = false
    end
end)

CombatSection:NewSlider("Fov Circle", "", 61, 0, function(c)
	_G.CircleRadius = c
end)

CombatSection:NewToggle("Bighead", "", function(state)
	if state then
	_G.Disabled = true
	else
	_G.Disabled = false
	end
end)

CombatSection:NewSlider("Bighead size", "", function(s)
_G.HeadSize = s
_G.Disabled = true

game:GetService('RunService').RenderStepped:connect(function()
if _G.Disabled then
for i,v in next, game:GetService('Players'):GetPlayers() do
if v.Name ~= game:GetService('Players').LocalPlayer.Name then
pcall(function()
v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
v.Character.HumanoidRootPart.Transparency = 0.7
v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue")
v.Character.HumanoidRootPart.Material = "Neon"
v.Character.HumanoidRootPart.CanCollide = false
end)
end
end
end
end)
end)

CombatSection:NewToggle("Click tp", "", function(state)
	if state then
	getgenv().Clicktp = true
	repeat wait()
	if getgenv().Clicktp == true then
	repeat wait() until game:GetService("Players").LocalPlayer ~= nil and game:GetService("Players").LocalPlayer.Character ~= nil
	local TS = game:GetService("TweenService")
	local player = game:GetService("Players").LocalPlayer
	local UIS = game:GetService("UserInputService")
	local Mouse = player:GetMouse()
	
	local function tp(x, y, z)
		local info = TweenInfo.new(0.1)
		local move = TS:Create(player.Character.HumanoidRootPart, info, {CFrame = CFrame.new(x, y, z)})
		move:Play()
	end
	
	UIS.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
			tp(Mouse.Hit.X,Mouse.Hit.Y+3,Mouse.Hit.Z)
		end
	end)
end
until getgenv().Clicktp == false
else
	getgenv().Clicktp = false
end
end)

CombatSection:NewButton("Shit to tpwalk", "", function()
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

--//Map\\--
TeleportSection:NewButton("TILTED TOWERS", "", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1421.0708007812, -417.72821044922, -57.145942687988)
end)

TeleportSection:NewButton("LOOT LAKE", "", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-655.83111572266, -436.05633544922, -1244.9927978516)
end)

TeleportSection:NewButton("PLEASANT PARK", "", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2122.6496582031, -340.36883544922, -1973.2209472656)
end)

TeleportSection:NewButton("DUSTY DEPOT", "", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(675.73638916016, -401.36932373047, -434.24932861328)
end)

TeleportSection:NewButton("RETAIL ROW", "", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2381.3173828125, -384.8688659668, 296.00573730469)
end)

TeleportSection:NewButton("SALTY SPRINGS", "", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(642.03698730469, -337.38446044922, 1104.009765625)
end)

TeleportSection:NewButton("SHIFTY SHAFTS", "", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1321.6586914062, -401.57836914062, 1207.3002929688)
end)

TeleportSection:NewButton("ANARCHY ACRES", "", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(211.47868347168, -432.18133544922, -2593.2512207031)
end)

TeleportSection:NewButton("TOMATO TOWN", "", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1568.9162597656, -435.65008544922, -1700.5867919922)
end)

TeleportSection:NewButton("LONELY LODGE", "", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3721.9208984375, -386.77676391602, -983.87164306641)
end)

TeleportSection:NewButton("WAILING WOODS", "", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3151.9555664062, -417.35321044922, -1989.6918945312)
end)

TeleportSection:NewButton("MOISTY MIRE", "", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3101.8239746094, -382.17834472656, 2780.7502441406)
end)

TeleportSection:NewButton("FATAL FIELDS", "", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(921.36175537109, -386.94696044922, 2641.2277832031)
end)

TeleportSection:NewButton("FLUSH FACTORY", "", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1344.689453125, -409.88446044922, 3477.3947753906)
end)

TeleportSection:NewButton("GREASY GROVE", "", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2736.2702636719, -403.96258544922, 1249.5084228516)
end)

TeleportSection:NewButton("SNOBBY SHORES", "", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3951.0100097656, -356.08758544922, -488.85733032227)
end)

TeleportSection:NewButton("HAUNTED HILLS", "", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3254.2858886719, -319.29071044922, -2801.1098632812)
end)

TeleportSection:NewButton("JUNK JUMCTION", "", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3035.1877441406, -354.99383544922, -3590.2553710938)
end)

--//Visual\\--
VisualSection:NewToggle("Esp", "Makes you see players", function(state)
	if state then
		_G.BoxesVisible = true
		_G.ESPVisible = true
		_G.TracersVisible = true
	else
		_G.BoxesVisible = false
		_G.ESPVisible = false
		_G.TracersVisible = false
	end
end)

VisualSection:NewToggle("Draw Box", "Draw Box on Enemis", function(state)
if state then
	local function API_Check()
		if Drawing == nil then
			return "No"
		else
			return "Yes"
		end
	end
	
	local Find_Required = API_Check()
	
	if Find_Required == "No" then
		game:GetService("StarterGui"):SetCore("",{
			Title = "";
			Text = "";
			Duration = math.huge;
			Button1 = "OK"
		})
	
		return
	end
	
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local UserInputService = game:GetService("UserInputService")
	local Camera = workspace.CurrentCamera
	
	local Typing = false
	
	_G.TeamColor = false
	
	_G.TeamCheck = false   -- If set to true then the script would create boxes only for the enemy team members.
	
	_G.BoxesVisible = true   -- If set to true then the boxes will be visible and vice versa.
	_G.LineColor = Color3.fromRGB(128,234,255)   -- The color that the boxes would appear as.
	_G.LineThickness = 2
	_G.LineTransparency = 2
	_G.SizeIncrease = 1
	
	
	local function CreateBoxes()
		for _, v in next, Players:GetPlayers() do
			if v.Name ~= Players.LocalPlayer.Name then
				local TopLeftLine = Drawing.new("Line")
				local TopRightLine = Drawing.new("Line")
				local BottomLeftLine = Drawing.new("Line")
				local BottomRightLine = Drawing.new("Line")
	
				RunService.RenderStepped:Connect(function()
					if workspace:FindFirstChild(v.Name) ~= nil and workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil then 
						TopLeftLine.Thickness = _G.LineThickness
						TopLeftLine.Transparency = _G.LineTransparency
						TopLeftLine.Color = _G.LineColor
	
						TopRightLine.Thickness = _G.LineThickness
						TopRightLine.Transparency = _G.LineTransparency
						TopRightLine.Color = _G.LineColor
	
						BottomLeftLine.Thickness = _G.LineThickness
						BottomLeftLine.Transparency = _G.LineTransparency
						BottomLeftLine.Color = _G.LineColor
	
						BottomRightLine.Thickness = _G.LineThickness
						BottomRightLine.Transparency = _G.LineTransparency
						BottomRightLine.Color = _G.LineColor
						
						local HumanoidRootPart_Position, HumanoidRootPart_Size = workspace[v.Name].HumanoidRootPart.CFrame, workspace[v.Name].HumanoidRootPart.Size * _G.SizeIncrease
	
						local TopLeftPosition, TopLeftVisible = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(HumanoidRootPart_Size.X,  HumanoidRootPart_Size.Y, 0).p)
						local TopRightPosition, TopRightVisible = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(-HumanoidRootPart_Size.X,  HumanoidRootPart_Size.Y, 0).p)
						local BottomLeftPosition, BottomLeftVisible = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(HumanoidRootPart_Size.X, -HumanoidRootPart_Size.Y, 0).p)
						local BottomRightPosition, BottomRightVisible = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(-HumanoidRootPart_Size.X, -HumanoidRootPart_Size.Y, 0).p)
	
						if TopLeftVisible == true then
							TopLeftLine.From = Vector2.new(TopLeftPosition.X, TopLeftPosition.Y)
							TopLeftLine.To = Vector2.new(TopRightPosition.X, TopRightPosition.Y)
							if _G.TeamCheck == true then 
								if Players.LocalPlayer.Team ~= v.Team then
									TopLeftLine.Visible = _G.BoxesVisible
								else
									TopLeftLine.Visible = false
								end
							else
								TopLeftLine.Visible = _G.BoxesVisible
							end
						else
							TopLeftLine.Visible = false
						end
	
						if TopRightVisible == true and _G.BoxesVisible == true then
							TopRightLine.From = Vector2.new(TopRightPosition.X, TopRightPosition.Y)
							TopRightLine.To = Vector2.new(BottomRightPosition.X, BottomRightPosition.Y)
							if _G.TeamCheck == true then 
								if Players.LocalPlayer.Team ~= v.Team then
									TopRightLine.Visible = _G.BoxesVisible
								else
									TopRightLine.Visible = false
								end
							else
								TopRightLine.Visible = _G.BoxesVisible
							end
						else
							TopRightLine.Visible = false
						end
	
						if BottomLeftVisible == true and _G.BoxesVisible == true then
							BottomLeftLine.From = Vector2.new(BottomLeftPosition.X, BottomLeftPosition.Y)
							BottomLeftLine.To = Vector2.new(TopLeftPosition.X, TopLeftPosition.Y)
							if _G.TeamCheck == true then 
								if Players.LocalPlayer.Team ~= v.Team then
									BottomLeftLine.Visible = _G.BoxesVisible
								else
									BottomLeftLine.Visible = false
								end
							else
								BottomLeftLine.Visible = _G.BoxesVisible
							end
						else
							BottomLeftLine.Visible = false
						end
	
						if BottomRightVisible == true and _G.BoxesVisible == true then
							BottomRightLine.From = Vector2.new(BottomRightPosition.X, BottomRightPosition.Y)
							BottomRightLine.To = Vector2.new(BottomLeftPosition.X, BottomLeftPosition.Y)
							if _G.TeamCheck == true then 
								if Players.LocalPlayer.Team ~= v.Team then
									BottomRightLine.Visible = _G.BoxesVisible
								else
									BottomRightLine.Visible = false
								end
							else
								BottomRightLine.Visible = _G.BoxesVisible
							end
						else
							BottomRightLine.Visible = false
						end
					else
						TopRightLine.Visible = false
						TopLeftLine.Visible = false
						BottomLeftLine.Visible = false
						BottomRightLine.Visible = false
					end
				end)
	
				Players.PlayerRemoving:Connect(function()
					TopRightLine.Visible = false
					TopLeftLine.Visible = false
					BottomLeftLine.Visible = false
					BottomRightLine.Visible = false
				end)
			end
		end
	
		Players.PlayerAdded:Connect(function(Player)
			Player.CharacterAdded:Connect(function(v)
				if v.Name ~= Players.LocalPlayer.Name then
					local TopLeftLine = Drawing.new("Line")
					local TopRightLine = Drawing.new("Line")
					local BottomLeftLine = Drawing.new("Line")
					local BottomRightLine = Drawing.new("Line")
		
					RunService.RenderStepped:Connect(function()
						if workspace:FindFirstChild(v.Name) ~= nil and workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil then 
							TopLeftLine.Thickness = _G.LineThickness
							TopLeftLine.Transparency = _G.LineTransparency
							TopLeftLine.Color = _G.LineColor
		
							TopRightLine.Thickness = _G.LineThickness
							TopRightLine.Transparency = _G.LineTransparency
							TopRightLine.Color = _G.LineColor
		
							BottomLeftLine.Thickness = _G.LineThickness
							BottomLeftLine.Transparency = _G.LineTransparency
							BottomLeftLine.Color = _G.LineColor
		
							BottomRightLine.Thickness = _G.LineThickness
							BottomRightLine.Transparency = _G.LineTransparency
							BottomRightLine.Color = _G.LineColor
							
							local HumanoidRootPart_Position, HumanoidRootPart_Size = workspace[v.Name].HumanoidRootPart.CFrame, workspace[v.Name].HumanoidRootPart.Size * _G.SizeIncrease
		
							local TopLeftPosition, TopLeftVisible = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(HumanoidRootPart_Size.X,  HumanoidRootPart_Size.Y, 0).p)
							local TopRightPosition, TopRightVisible = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(-HumanoidRootPart_Size.X,  HumanoidRootPart_Size.Y, 0).p)
							local BottomLeftPosition, BottomLeftVisible = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(HumanoidRootPart_Size.X, -HumanoidRootPart_Size.Y, 0).p)
							local BottomRightPosition, BottomRightVisible = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(-HumanoidRootPart_Size.X, -HumanoidRootPart_Size.Y, 0).p)
		
							if TopLeftVisible == true then
								TopLeftLine.From = Vector2.new(TopLeftPosition.X, TopLeftPosition.Y)
								TopLeftLine.To = Vector2.new(TopRightPosition.X, TopRightPosition.Y)
								if _G.TeamCheck == true then 
									if Players.LocalPlayer.Team ~= Player.Team then
										TopLeftLine.Visible = _G.BoxesVisible
									else
										TopLeftLine.Visible = false
									end
								else
									TopLeftLine.Visible = _G.BoxesVisible
								end
							else
								TopLeftLine.Visible = false
							end
		
							if TopRightVisible == true and _G.BoxesVisible == true then
								TopRightLine.From = Vector2.new(TopRightPosition.X, TopRightPosition.Y)
								TopRightLine.To = Vector2.new(BottomRightPosition.X, BottomRightPosition.Y)
								if _G.TeamCheck == true then 
									if Players.LocalPlayer.Team ~= Player.Team then
										TopRightLine.Visible = _G.BoxesVisible
									else
										TopRightLine.Visible = false
									end
								else
									TopRightLine.Visible = _G.BoxesVisible
								end
							else
								TopRightLine.Visible = false
							end
		
							if BottomLeftVisible == true and _G.BoxesVisible == true then
								BottomLeftLine.From = Vector2.new(BottomLeftPosition.X, BottomLeftPosition.Y)
								BottomLeftLine.To = Vector2.new(TopLeftPosition.X, TopLeftPosition.Y)
								if _G.TeamCheck == true then 
									if Players.LocalPlayer.Team ~= Player.Team then
										BottomLeftLine.Visible = _G.BoxesVisible
									else
										BottomLeftLine.Visible = false
									end
								else
									BottomLeftLine.Visible = _G.BoxesVisible
								end
							else
								BottomLeftLine.Visible = false
							end
		
							if BottomRightVisible == true and _G.BoxesVisible == true then
								BottomRightLine.From = Vector2.new(BottomRightPosition.X, BottomRightPosition.Y)
								BottomRightLine.To = Vector2.new(BottomLeftPosition.X, BottomLeftPosition.Y)
								if _G.TeamCheck == true then 
									if Players.LocalPlayer.Team ~= Player.Team then
										BottomRightLine.Visible = _G.BoxesVisible
									else
										BottomRightLine.Visible = false
									end
								else
									BottomRightLine.Visible = _G.BoxesVisible
								end
							else
								BottomRightLine.Visible = false
							end
						else
							TopRightLine.Visible = false
							TopLeftLine.Visible = false
							BottomLeftLine.Visible = false
							BottomRightLine.Visible = false
						end
					end)
		
					Players.PlayerRemoving:Connect(function()
						TopRightLine.Visible = false
						TopLeftLine.Visible = false
						BottomLeftLine.Visible = false
						BottomRightLine.Visible = false
					end)
				end
			end)
		end)
	end
	
	if _G.TeamColor == true then
		_G.TeamCheck = false
		_G.BoxesVisible = true
		_G.LineColor = Color3.fromRGB(128,234,255)
		_G.LineThickness = 2
		_G.LineTransparency = 2
		_G.SizeIncrease = 1
	end
	
	local Success, Errored = pcall(function()
		CreateBoxes()
	end)
	
	if Success and not Errored then
		if _G.SendNotificatins == true then
			game:GetService("StarterGui"):SetCore("",{
				Title = "";
				Text = "";
				Duration = 5;
			})
		end
	elseif Errored and not Success then
		if _G.SendNotificatins == true then
			game:GetService("StarterGui"):SetCore("",{
				Title = "";
				Text = "";
				Duration = 5;
			})
		end
	end
else
	_G.BoxesVisible = false
end
end)

VisualSection:NewToggle("Draw Tracer", "Draw Tracer on Enemis", function(state)
	if state then
		local function API_Check()
			if Drawing == nil then
				return "No"
			else
				return "Yes"
			end
		end
		
		local Find_Required = API_Check()
		
		if Find_Required == "No" then
			game:GetService("StarterGui"):SetCore("",{
				Title = "";
				Text = "";
				Duration = math.huge;
				Button1 = "OK"
			})
		
			return
		end
		
		local RunService = game:GetService("RunService")
		local Players = game:GetService("Players")
		local Camera = game:GetService("Workspace").CurrentCamera
		local UserInputService = game:GetService("UserInputService")
		local TestService = game:GetService("TestService")
		
		local Typing = false
		
		_G.SendNotificatins = false   -- If set to true then the script would notify you frequently on any changes applied and when loaded / errored. (If a game can detect this, it is recommended to set it to false)
		_G.TeamColor = false   -- If set to true then the tracer script would run with default settings regardless of any changes you made.
		
		_G.TeamCheck = false   -- If set to true then the script would create tracers only for the enemy team members.
		
		--[!]-- ONLY ONE OF THESE VALUES SHOULD BE SET TO TRUE TO NOT ERROR THE SCRIPT --[!]--
		
		_G.FromMouse = false   -- If set to true, the tracers will come from the position of your mouse curson on your screen.
		_G.FromCenter = false   -- If set to true, the tracers will come from the center of your screen.
		_G.FromBottom = true   -- If set to true, the tracers will come from the bottom of your screen.
		
		_G.TracersVisible = true   -- If set to true then the tracers will be visible and vice versa.
		_G.TracerColor = Color3.fromRGB(128, 234, 255)   -- The color that the tracers would appear as.
		_G.TracerThickness = 2   -- The thickness of the tracers.
		_G.TracerTransparency = 2   -- The transparency of the tracers.
		
		_G.ModeSkipKey = Enum.KeyCode -- The key that changes between modes that indicate where will the tracers come from.
		
			local function CreateTracers()
				for _, v in next, Players:GetPlayers() do
					if v.Name ~= game.Players.LocalPlayer.Name then
						local TracerLine = Drawing.new("Line")
				
						RunService.RenderStepped:Connect(function()
							if workspace:FindFirstChild(v.Name) ~= nil and workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil then
								local HumanoidRootPart_Position, HumanoidRootPart_Size = workspace[v.Name].HumanoidRootPart.CFrame, workspace[v.Name].HumanoidRootPart.Size * 1
								local Vector, OnScreen = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(0, -HumanoidRootPart_Size.Y, 0).p)
								
								TracerLine.Thickness = _G.TracerThickness
								TracerLine.Transparency = _G.TracerTransparency
								TracerLine.Color = _G.TracerColor
			
								if _G.FromMouse == true and _G.FromCenter == false and _G.FromBottom == false then
									TracerLine.From = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
								elseif _G.FromMouse == false and _G.FromCenter == true and _G.FromBottom == false then
									TracerLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
								elseif _G.FromMouse == false and _G.FromCenter == false and _G.FromBottom == true then
									TracerLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
								end
			
								if OnScreen == true  then
									TracerLine.To = Vector2.new(Vector.X, Vector.Y)
									if _G.TeamCheck == true then 
										if Players.LocalPlayer.Team ~= v.Team then
											TracerLine.Visible = _G.TracersVisible
										else
											TracerLine.Visible = false
										end
									else
										TracerLine.Visible = _G.TracersVisible
									end
								else
									TracerLine.Visible = false
								end
							else
								TracerLine.Visible = false
							end
						end)
			
						Players.PlayerRemoving:Connect(function()
							TracerLine.Visible = false
						end)
					end
				end
			
				Players.PlayerAdded:Connect(function(Player)
					Player.CharacterAdded:Connect(function(v)
						if v.Name ~= game.Players.LocalPlayer.Name then
							local TracerLine = Drawing.new("Line")
					
							RunService.RenderStepped:Connect(function()
								if workspace:FindFirstChild(v.Name) ~= nil and workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil then
									local HumanoidRootPart_Position, HumanoidRootPart_Size = workspace[v.Name].HumanoidRootPart.CFrame, workspace[v.Name].HumanoidRootPart.Size * 1
									local Vector, OnScreen = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(0, -HumanoidRootPart_Size.Y, 0).p)
									
									TracerLine.Thickness = _G.TracerThickness
									TracerLine.Transparency = _G.TracerTransparency
									TracerLine.Color = _G.TracerColor
			
									if _G.FromMouse == true and _G.FromCenter == false and _G.FromBottom == false then
										TracerLine.From = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
									elseif _G.FromMouse == false and _G.FromCenter == true and _G.FromBottom == false then
										TracerLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
									elseif _G.FromMouse == false and _G.FromCenter == false and _G.FromBottom == true then
										TracerLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
									end
			
									if OnScreen == true  then
										TracerLine.To = Vector2.new(Vector.X, Vector.Y)
										if _G.TeamCheck == true then 
											if Players.LocalPlayer.Team ~= Player.Team then
												TracerLine.Visible = _G.TracersVisible
											else
												TracerLine.Visible = false
											end
										else
											TracerLine.Visible = _G.TracersVisible
										end
									else
										TracerLine.Visible = false
									end
								else
									TracerLine.Visible = false
								end
							end)
			
							Players.PlayerRemoving:Connect(function()
								TracerLine.Visible = false
							end)
						end
					end)
				end)
			end
			
			UserInputService.TextBoxFocused:Connect(function()
				Typing = true
			end)
			
			UserInputService.TextBoxFocusReleased:Connect(function()
				Typing = false
			end)
			
			UserInputService.InputBegan:Connect(function(Input)
				if Input.KeyCode == _G.ModeSkipKey and Typing == false then
					if _G.FromMouse == true and _G.FromCenter == false and _G.FromBottom == false and _G.TracersVisible == true then
						_G.FromCenter = false
						_G.FromBottom = true
						_G.FromMouse = false
			
						if _G.SendNotificatins == true then
							game:GetService("StarterGui"):SetCore("",{
								Title = "";
								Text = "";
								Duration = 5;
							})
						end
					elseif _G.FromMouse == false and _G.FromCenter == false and _G.FromBottom == true and _G.TracersVisible == true then
						_G.FromCenter = true
						_G.FromBottom = false
						_G.FromMouse = false
			
						if _G.SendNotificatins == true then
							game:GetService("StarterGui"):SetCore("SendNotification",{
								Title = "";
								Text = "";
								Duration = 5;
							})
						end
					elseif _G.FromMouse == false and _G.FromCenter == true and _G.FromBottom == false and _G.TracersVisible == true then
						_G.FromCenter = false
						_G.FromBottom = false
						_G.FromMouse = true
			
						if _G.SendNotificatins == true then
							game:GetService("StarterGui"):SetCore("",{
								Title = "";
								Text = "";
								Duration = 5;
							})
						end
					end
				elseif Input.KeyCode == _G.DisableKey and Typing == false then
					_G.TracersVisible = not _G.TracersVisible
					
					if _G.SendNotificatins == true then
						game:GetService("StarterGui"):SetCore("",{
							Title = "";
							Text = ""..tostring(_G.TracersVisible)..".";
							Duration = 5;
						})
					end
				end
			end)
			
			if _G.TeamColor == true then
				_G.TeamCheck = false
				_G.FromMouse = false
				_G.FromCenter = false
				_G.FromBottom = true
				_G.TracersVisible = true
				_G.TracerColor = Color3.fromRGB(40, 90, 255)
				_G.TracerThickness = 2
				_G.TracerTransparency = 2
				_G.ModeSkipKey = Enum.KeyCode
			end
			
			local Success, Errored = pcall(function()
				CreateTracers()
			end)
			
			if Success and not Errored then
				if _G.SendNotificatins == true then
					game:GetService("StarterGui"):SetCore("",{
						Title = "";
						Text = "";
						Duration = 5;
					})
				end
			elseif Errored and not Success then
				if _G.SendNotificatins == true then
					game:GetService("StarterGui"):SetCore("",{
						Title = "";
						Text = "";
						Duration = 5;
					})
				end
				TestService:Message("")
				warn(Errored)
				print("")
			end
		else
			_G.TracersVisible = false
		end
		end)

VisualSection:NewToggle("Draw Player Name", "Draw Name on Enemis", function(state)
	if state then
		local function API_Check()
			if Drawing == nil then
				return "No"
			else
				return "Yes"
			end
		end
		
		local Find_Required = API_Check()
		
		if Find_Required == "No" then
			game:GetService("StarterGui"):SetCore("",{
				Title = "";
				Text = "";
				Duration = math.huge;
				Button1 = "OK"
			})
		
			return
		end
		
		local Players = game:GetService("Players")
		local RunService = game:GetService("RunService")
		local UserInputService = game:GetService("UserInputService")
		local Camera = workspace.CurrentCamera
		
		local Typing = false
		
		_G.SendNotificatis = false   -- If set to true then the script would notify you frequently on any changes applied and when loaded / errored. (If a game can detect this, it is recommended to set it to false)
		_G.TeamColor = false   -- If set to true then the ESP script would run with default settings regardless of any changes you made.
		
		_G.TeamCheck = false   -- If set to true then the script would create ESP only for the enemy team members.
		
		_G.ESPVisible = true   -- If set to true then the ESP will be visible and vice versa.
		_G.TextColor = Color3.fromRGB(128, 234, 255)   -- The color that the boxes would appear as.
		_G.TextSize = 18   -- The size of the text.
		_G.Center = true   -- If set to true then the script would be located at the center of the label.
		_G.Outline = true   -- If set to true then the text would have an outline.
		_G.OutlineColor = Color3.fromRGB(0, 0, 0)   -- The outline color of the text.
		_G.TextTransparency = 2   -- The transparency of the text.
		_G.TextFont = LuckiestGuy   -- The font of the text. (UI, System, Plex, Monospace) 
		
			-- The key that disables / enables the ESP.
		
		local function CreateESP()
			for _, v in next, Players:GetPlayers() do
				if v.Name ~= Players.LocalPlayer.Name then
					local ESP = Drawing.new("Text")
		
					RunService.RenderStepped:Connect(function()
						if workspace:FindFirstChild(v.Name) ~= nil and workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil then
							local Vector, OnScreen = Camera:WorldToViewportPoint(workspace[v.Name]:WaitForChild("Head", math.huge).Position)
		
							ESP.Size = _G.TextSize
							ESP.Center = _G.Center
							ESP.Outline = _G.Outline
							ESP.OutlineColor = _G.OutlineColor
							ESP.Color = _G.TextColor
							ESP.Transparency = _G.TextTransparency
							ESP.Font = _G.TextFont
		
							if OnScreen == true then
								local Part1 = workspace:WaitForChild(v.Name, math.huge):WaitForChild("HumanoidRootPart", math.huge).Position
								local Part2 = workspace:WaitForChild(Players.LocalPlayer.Name, math.huge):WaitForChild("HumanoidRootPart", math.huge).Position or 0
								local Dist = (Part1 - Part2).Magnitude
								ESP.Position = Vector2.new(Vector.X, Vector.Y - 25)
								ESP.Text = (""..v.Name.."")
								if _G.TeamCheck == true then 
									if Players.LocalPlayer.Team ~= v.Team then
										ESP.Visible = _G.ESPVisible
									else
										ESP.Visible = false
									end
								else
									ESP.Visible = _G.ESPVisible
								end
							else
								ESP.Visible = false
							end
						else
							ESP.Visible = false
						end
					end)
		
					Players.PlayerRemoving:Connect(function()
						ESP.Visible = false
					end)
				end
			end
		
			Players.PlayerAdded:Connect(function(Player)
				Player.CharacterAdded:Connect(function(v)
					if v.Name ~= Players.LocalPlayer.Name then 
						local ESP = Drawing.new("Text")
			
						RunService.RenderStepped:Connect(function()
							if workspace:FindFirstChild(v.Name) ~= nil and workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil then
								local Vector, OnScreen = Camera:WorldToViewportPoint(workspace[v.Name]:WaitForChild("Head", math.huge).Position)
			
								ESP.Size = _G.TextSize
								ESP.Center = _G.Center
								ESP.Outline = _G.Outline
								ESP.OutlineColor = _G.OutlineColor
								ESP.Color = _G.TextColor
								ESP.Transparency = _G.TextTransparency
			
								if OnScreen == true then
									local Part1 = workspace:WaitForChild(v.Name, math.huge):WaitForChild("HumanoidRootPart", math.huge).Position
								local Part2 = workspace:WaitForChild(Players.LocalPlayer.Name, math.huge):WaitForChild("HumanoidRootPart", math.huge).Position or 0
									local Dist = (Part1 - Part2).Magnitude
									ESP.Position = Vector2.new(Vector.X, Vector.Y - 25)
									ESP.Text = (""..v.Name.."")
									if _G.TeamCheck == true then 
										if Players.LocalPlayer.Team ~= Player.Team then
											ESP.Visible = _G.ESPVisible
										else
											ESP.Visible = false
										end
									else
										ESP.Visible = _G.ESPVisible
									end
								else
									ESP.Visible = false
								end
							else
								ESP.Visible = false
							end
						end)
			
						Players.PlayerRemoving:Connect(function()
							ESP.Visible = false
						end)
					end
				end)
			end)
		end
		
		if _G.TeamColor == true then
			_G.TeamCheck = false
			_G.ESPVisible = true
			_G.TextColor = Color3.fromRGB(40, 90, 255)
			_G.TextSize = 14
			_G.Center = true
			_G.Outline = false
			_G.OutlineColor = Color3.fromRGB(0, 0, 0)
			_G.TextTransparency = 0.75
		end
		
		UserInputService.TextBoxFocused:Connect(function()
			Typing = true
		end)
		
		UserInputService.TextBoxFocusReleased:Connect(function()
			Typing = false
		end)
		
		UserInputService.InputBegan:Connect(function(Input)
			if Input.KeyCode == _G.DisableKey and Typing == false then
				_G.ESPVisible = not _G.ESPVisible
				
				if _G.SendNotificatis == true then
					game:GetService("StarterGui"):SetCore("",{
						Title = "";
						Text = ""..tostring(_G.ESPVisible)..".";
						Duration = 5;
					})
				end
			end
		end)
		
		local Success, Errored = pcall(function()
			CreateESP()
		end)
		
		if Success and not Errored then
			if _G.SendNotificatis == true then
				game:GetService("StarterGui"):SetCore("",{
					Title = "";
					Text = "";
					Duration = 5;
				})
			end
		elseif Errored and not Success then
			if _G.SendNotificatis == true then
				game:GetService("StarterGui"):SetCore("",{
					Title = "";
					Text = "";
					Duration = 5;
				})
			end
			TestService:Message("")
			warn(Errored)
			print("")
		end
	else
		_G.ESPVisible = false
	end
end)

VisualSection:NewColorPicker("ESP Color", "Sets the ESP Color", Color3.fromRGB(0,0,0), function(color)
	_G.TracerColor = color
	_G.LineColor = color
	_G.TextColor = color
	_G.DotColor = color
end)


ServerSection:NewButton("Back To Lobby", "", function()
	game:GetService("TeleportService"):Teleport(7283831492, LocalPlayer)
end)

ServerSection:NewButton("Rejoin", "", function()
	local ts = game:GetService("TeleportService")

	local p = game:GetService("Players").LocalPlayer

	ts:Teleport(game.PlaceId, p)
end)

--//Credits\\--
CreditsSection:NewButton("Made By c00dy#0001", "My Discord Name", function()
end)