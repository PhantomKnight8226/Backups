local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window = Library.CreateLib("SexHub")

    --// Loading Tabs \\--
    local WelcomeTab = Window:NewTab("Welcome")
    local Main = Window:NewTab("Auto win")
    local Player = Window:NewTab("Player")
    local VisualTab = Window:NewTab("Visuals")
    local Misc = Window:NewTab("Misc")
    local Teleport = Window:NewTab("Teleport")
    local Server = Window:NewTab("Server")

    --variable
    local RunService = game:GetService("RunService")
    local UIS = game:GetService("UserInputService")
    local Workspace = game:GetService("Workspace")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local TweenService = game:GetService("TweenService")
    local CollectionService = game:GetService("CollectionService")
    local TeleportService = game:GetService("TeleportService")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local CameraSubject = Workspace.Camera.CameraSubject

    --// Loading Sections \\--
    local WelcomeSection = WelcomeTab:NewSection("Welcome")
    local MainSection = Main:NewSection("Main")
    local RedSection = Main:NewSection("RED LIGHT GREEN LIGHT")
    local HONEYSection = Main:NewSection("HONEY COMB")
    local TUGSection = Main:NewSection("TUG OF WAR")
    local MARBLESection = Main:NewSection("Marbile")
    local GLASSSection = Main:NewSection("GLASS BRIDGE")
    local Squadection = Main:NewSection("SQUID GAME")
    local PlayerSection = Player:NewSection("Player")
    local VisualSection = VisualTab:NewSection("Visual")
    local MiscSection = Misc:NewSection("Misc")
    local PlayerTPSection = Teleport:NewSection("Teleport")
    local ServerSection = Server:NewSection("Server")

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
    WelcomeSection:NewKeybind("UI Key Bind", "PutAnyKeybind", Enum.KeyCode.RightShift, function()
        Library:ToggleUI()
    end)


    --//Main\\--
    MainSection:NewButton("Go To Game Arena", "You can go to any game Arena", function ()
    local args = {
        [1] = workspace.Mechanics.GoalPart1
    }

    game:GetService("ReplicatedStorage").Remotes.ReachedGoal:FireServer(unpack(args))

    end)

    MainSection:NewToggle("Auto Punch", "", function(state)
        if state then
            getgenv().AutoPunch = true
                local Distance = math.huge
                local Closest
            
                for next, Target in pairs(Players:GetPlayers()) do
                    if Target ~= LocalPlayer and Target.Character and Target.Character:FindFirstChild("HumanoidRootPart") and Target.Character.Humanoid.Health > 0 and not Target:GetAttribute("Guard") then
                        local Magnitude = (LocalPlayer.Character.HumanoidRootPart.Position - Target.Character.HumanoidRootPart.Position).magnitude
                        if Magnitude < Distance then
                            Distance = Magnitude
                            Closest = Target
                        end
                    end
                end
            
                if Closest ~= nil then ReplicatedStorage.Remotes.PunchEvent:FireServer(Workspace[Closest.Name]) end
        else
            getgenv().AutoPunch = false
        end
    end)

    MainSection:NewButton("Remove Kill Parts", "", function()
        Workspace.Mechanics:WaitForChild("Kill"):Destroy()
        Workspace.Mechanics:WaitForChild("Kill2"):Destroy()
    end)

    --//Red\\--
    RedSection:NewButton("Win Red light", "", function()
    local tweenInfo = TweenInfo.new(13, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
    local tween = TweenService:Create(LocalPlayer.Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(-294.16134643555, 3, 427.0)})
        ReplicatedStorage.Remotes.ReachedGoal:FireServer(Workspace.Mechanics.GoalPart1)
            tween:Play()
    end)

    RedSection:NewButton("Win Red light (Old)", "", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-294.16134643555, 3, 427.0)
    end)

    --//HONEY\\--
    HONEYSection:NewButton("Win Cookie", "", function()
        local args = {
            [1] = true
        }
        
        game:GetService("ReplicatedStorage").Remotes.HoneyCombResult:FireServer(unpack(args))
    end)

    pcall(function()
        ReplicatedStorage.Remotes.StartHoneycomb.OnClientEvent:Connect(function(Cookie)
            getgenv().CurrentCookie = Cookie
        end)
    end)

    HONEYSection:NewButton("Win Cookie V2", "", function()
        getgenv().CurrentCookie = nil
        if getgenv().CurrentCookie ~= nil then
            getgenv().CurrentCookie:SetAttribute("Percent", 100)
            getgenv().CurrentCookie[getgenv().CurrentCookie.Name .. "Hitboxes"]:ClearAllChildren()
            wait(5)
            ReplicatedStorage.Remotes.HoneyCombResult:FireServer(true)
        end
    end)

    HONEYSection:NewButton("Stop Pick Shape (Glitch it)", "Use it when you be forntman", function()
        local args = {
            [1] = 1,
            [2] = "Circle"
        }
        game:GetService("ReplicatedStorage").FrontmanRemotes.PickShape:FireServer(unpack(args))
        wait(1)
        local args = {
            [1] = 2,
            [2] = "Circle"
        }
        game:GetService("ReplicatedStorage").FrontmanRemotes.PickShape:FireServer(unpack(args))
        wait(1)
        local args = {
            [1] = 3,
            [2] = "Circle"
        }
        game:GetService("ReplicatedStorage").FrontmanRemotes.PickShape:FireServer(unpack(args))
        wait(1)
        local args = {
            [1] = 4,
            [2] = "Circle"
        }
        game:GetService("ReplicatedStorage").FrontmanRemotes.PickShape:FireServer(unpack(args))
    end)

    --//TUG\\--
    TUGSection:NewToggle("Auto Rope Pull", "Use it when you in TUG OF WAR Mode", function(state)
        if state then
            getgenv().Pull = true
            repeat wait()
                game:GetService("ReplicatedStorage").Pull:FireServer(1)
            until getgenv().Pull == false
        else
            getgenv().Pull = false
        end
    end)

    TUGSection:NewButton("Team 1", "", function()
            local ohNumber1 = 1

            game:GetService("ReplicatedStorage").Remotes.TeamUi:FireServer(ohNumber1)
    end)

    TUGSection:NewButton("Team 2", "", function()
        local ohNumber1 = 2

        game:GetService("ReplicatedStorage").Remotes.TeamUi:FireServer(ohNumber1)
    end)
    --//MARBILE\\--
    getgenv().MarbleGame = false

    MARBLESection:NewButton("Win Marble Game", "", function()
        getgenv().MarbleGame  = true
    end)
    --//Glass\\--
    GLASSSection:NewButton("Win Glass Bridge", "", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-500.78649902344, 78.206031799316, -474.77124023438)
    end)

    GLASSSection:NewButton("Break Glasses", "", function()
        for next, Glass in pairs(Workspace.Glass:GetChildren()) do
            ReplicatedStorage.Remotes.BreakGlass:FireServer(Glass)
        end
    end)

    GLASSSection:NewToggle("Glass ESP", "", function(state)
        if state then
            getgenv().GlassESP = true

            if not true then
                for next, Glass in pairs(Workspace.Glass:GetChildren()) do
                    if Glass:FindFirstChild("SelectionBox") then
                        Glass.SelectionBox.Transparency = 1
                    end
                end
            end
        else
            getgenv().GlassESP = false
        end
    end)

    GLASSSection:NewColorPicker("GLASS Esp Color", "Sets the GLASSESP Color", Color3.fromRGB(0,0,0), function(color)
        Glass.SelectionBox.SurfaceColor3 = color
    end)

    GLASSSection:NewToggle("Cross The Glass Bridge Without Falling", "", function(state)
        if state then
            game.Players.LocalPlayer.Character.GlassLocalScript.Disabled = true
        else
            game.Players.LocalPlayer.Character.GlassLocalScript.Disabled = false
        end
    end)

    --//Squad\\--
    Squadection:NewButton("Win SQUID GAME", "", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-314, 3, 326)
    end)


    --//Player\\--
    PlayerSection:NewTextBox("Wins", "Change Wins Value", function(txt)
        game:GetService("Players").LocalPlayer.leaderstats.Wins.Value = txt
    end)

    PlayerSection:NewToggle("Fly", "", function(state)
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

    PlayerSection:NewToggle("WalkSpeed", "WalkSpeed", function(state)
        if state then
            getgenv().WSSpeed = 100
            
            
            local RunService = game:GetService("RunService")
            
            RunService.Stepped:Connect(function()
                    game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").WalkSpeed = getgenv().WSSpeed
            end)
        else
            getgenv().WSSpeed = 20
        end
    end)

    PlayerSection:NewToggle("Noclip", "Go through objects", function(state)
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

    PlayerSection:NewToggle("Infinite Jump","Fly Jump",function(state)
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

    PlayerSection:NewSlider("Player Fov","Player Fov", 120, 70, function(v)
        game:GetService'Workspace'.Camera.FieldOfView = v
    end)

    --//Visual\\--
    VisualSection:NewToggle("Esp", "", function(state)
        if state then
            _G.BoxesVisible = true
            _G.ESPVisible = true
            _G.TracersVisible = true
            _G.HeadDotsVisible = true
        else
            _G.BoxesVisible = false
            _G.ESPVisible = false
            _G.TracersVisible = false
            _G.HeadDotsVisible = false
        end
    end)

    VisualSection:NewToggle("Draw Box", "", function(state)
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

    VisualSection:NewToggle("Draw Tracer", "", function(state)
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
        
        _G.ModeSkipKey = Enum.KeyCode.E   -- The key that changes between modes that indicate where will the tracers come from.
        _G.DisableKey = Enum.KeyCode.Q   -- The key that disables / enables the tracers.
        
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
                _G.ModeSkipKey = Enum.KeyCode.E
                _G.DisableKey = Enum.KeyCode.Q
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

    VisualSection:NewToggle("Draw Player Name", "", function(state)
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
            _G.TextSize = 14   -- The size of the text.
            _G.Center = true   -- If set to true then the script would be located at the center of the label.
            _G.Outline = true   -- If set to true then the text would have an outline.
            _G.OutlineColor = Color3.fromRGB(0, 0, 0)   -- The outline color of the text.
            _G.TextTransparency = 2   -- The transparency of the text.
            _G.TextFont = GothamBlack   -- The font of the text. (UI, System, Plex, Monospace) 
            
            _G.DisableKey = Enum.KeyCode.Q   -- The key that disables / enables the ESP.
            
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
                _G.DisableKey = Enum.KeyCode.Q
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

    --//Misc\\--
    MiscSection:NewButton("Be a Guard", "", function()
    local args = {
        [1] = true
    }

    game:GetService("ReplicatedStorage").GuardRemotes.BecomeGuard:InvokeServer(unpack(args))
    end)

    MiscSection:NewButton("Be a Frontman", "", function()
    local args = {
        [1] = true
    }

    game:GetService("ReplicatedStorage").FrontmanRemotes.BecomeFrontman:InvokeServer(unpack(args))
    end)

    MiscSection:NewButton("Collect All Bodies", "", function()
        for next, Body in pairs(Workspace.Bodies:GetChildren()) do
            ReplicatedStorage.GuardRemotes.CollectBody:FireServer(LocalPlayer, Body.Torso.CFrame, Body.Name)
        end
    end)

    --//Teleport\\--
    local playerlist = {}

    for i,v in pairs(game.Players:GetPlayers())do
    if v ~= game.Players.LocalPlayer then
        table.insert(playerlist,v.Name)
    end
    end

    SelectedPlayer = ""
    local dropdown = PlayerTPSection:NewDropdown("Select Player","Select the Player to TP to", playerlist, function(s)
        SelectedPlayer = s
    end)

    PlayerTPSection:NewButton("Teleport to Player", "Teleports you to the Selected Player", function()
        if game:GetService("Workspace"):FindFirstChild(SelectedPlayer) then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace"):FindFirstChild(SelectedPlayer).HumanoidRootPart.CFrame * CFrame.new(0,0,1)
        end
    end)

    --//Server\\--

    ServerSection:NewButton("Back To Lobby", "", function()
        local TeleportService = game:GetService("TeleportService")
        TeleportService:Teleport(7540891731, LocalPlayer)
    end)

    ServerSection:NewButton("Rejoin", "Click Rejoin if You Want To Turn Off The Script", function()
        local ts = game:GetService("TeleportService")
        
        local p = game:GetService("Players").LocalPlayer
        
        
        ts:Teleport(game.PlaceId, p)
    end)

    local RunService = game:GetService("RunService")
    RunService.RenderStepped:Connect(function()
    if Glass:FindFirstChild("SelectionBox") then
        Glass.SelectionBox.Transparency = 0
        Glass.SelectionBox.SurfaceColor3 = getgenv().GlassESPColor
    end
    end)
