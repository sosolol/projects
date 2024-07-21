local start_time = os.clock()

local Config = {
    Streamable = false; -- If Streamable, UI doesnt load. Edit config
    Aiming = {
        Enabled = false;
        Method = "From Mouse";
        MouseDist = 35;
        UseClosetPart = false;

    }, Keys  = {
        SilentKey = Enum.KeyCode.X;

    }, Notifications = {
        Enabled = true;

    }, Checks = {
        Wall_Check = false;

    }, Options = {
        Hitpart = "Head"; -- Head, Torso, Right Arm, Left Arm, Right Leg, Left Leg

        Resolver = false;
        AutoPrediction = true;

        Prediction = 0.178;
    }, Spoofing = {}
}
local Services = {
    Replicated = game:GetService("ReplicatedStorage");
    MarketPlace = game:GetService("MarketplaceService");
    RunService = game:GetService("RunService");
    UserInput = game:GetService("UserInputService");
    TeleportService = game:GetService("TeleportService");
    GuiService = game:GetService("GuiService");
    Statistics = game:GetService("Stats");
    TweenService = game:GetService("TweenService");
}

local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()


if not Config.Streamable then
    do 
        local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/vozoid/ui-libraries/main/drawing/void/source.lua"))()

        local Window = Library:Load{
            Name = "Artic | https://encrypts.lol";
            SizeX = 600;
            SizeY = 550;
            Theme = "Default";
            Extension = "json";
            Folder = "Artic-Streets"
        }
        local Artic_Tabs = {
            Main = Window:Tab("Main");
            Settings = Window:Tab("Settings")
        }
        local Artic_Sections = {
            SilentSection = Artic_Tabs.Main:Section{Name = "Aiming", Side = "Left"};
            OptionSection = Artic_Tabs.Main:Section{Name = "Options", Side = "Right"};
            
            SettingSection = Artic_Tabs.Settings:Section{Name = "Settings", Side = "Left"};
        }

        do
            local SilentToggle = Artic_Sections.SilentSection:Toggle{
                Name = "Silent Aim";
                Callback = function(bool)
                    Config.Aiming.Enabled = bool
                end
            }
            SilentToggle:Keybind{
                Default = Enum.KeyCode.U;
                Blacklist = {Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2};
                Mode = "Toggle"
            }
            Artic_Sections.SilentSection:Keybind{
                Name = "Silent Aim Key";
                Default = Enum.KeyCode.X;
                Blacklist = {Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2};
                Callback = function(value)
                    Config.Keys.SilentKey = value
                end
            }
            Artic_Sections.SilentSection:Dropdown{
                Name = "Method";
                Default = "From Mouse";
                Scrollable = true;
                ScrollingMax = 5;
                Content = {
                    "From Mouse";
                }
            }
            Artic_Sections.SilentSection:Slider{
                Name = "From Mouse Distance";
                Text = "[value]/200";
                Min = 35;
                Max = 200;
                Callback = function(value)
                    Config.Aiming.MouseDist = value
                end
            }
            Artic_Sections.SilentSection:Toggle{
                Name = "Use closet part to mouse";
                Callback = function(bool)
                    Config.Aiming.UseClosetPart = bool
                end
            }
            Artic_Sections.SilentSection:Separator("Checks")
            Artic_Sections.SilentSection:Toggle{
                Name = "Wall Check";
                Callback = function(bool)
                    Config.Checks.Wall_Check = bool
                end
            }
            Artic_Sections.SilentSection:Separator("Notifications")
            Artic_Sections.SilentSection:Toggle{
                Name = "Enabled";
                Default = true;
                Callback = function(bool)
                    Config.Notifications.Enabled = bool
                end
            }

            Artic_Sections.OptionSection:Dropdown{
                Name = "Hit part";
                Default = "Head";
                Scrollable = true;
                ScrollingMax = 5;
                Content = {
                    "Head"; 
                    "Torso"; 
                    "Right Arm"; 
                    "Left Arm"; 
                    "Right Leg"; 
                    "Left Leg"
                };
                Callback = function(value)
                    Config.Options.Hitpart = value
                end
            }
            Artic_Sections.OptionSection:Toggle{
                Name = "Auto Prediction";
                Default = true;
                Callback = function(bool)
                    Config.Options.AutoPrediction = bool
                end
            }
            Artic_Sections.OptionSection:Toggle{
                Name = "Resolver";
                Callback = function(bool)
                    Config.Options.Resolver = bool
                end
            }

            Artic_Sections.SettingSection["Accent"] = Library:ChangeThemeOption("Accent", Color3.new(153/255, 75/255, 75/255))
            Artic_Sections.SettingSection:Keybind{
                Name = "Toggle Key",
                Flag = "UI Toggle",
                Default = Enum.KeyCode.RightControl,
                Blacklist = {Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.MouseButton3},
                Callback = function(_, fromsetting)
                    if not fromsetting then
                        Library:Close()
                    end
                end
            }
            Artic_Sections.SettingSection:Button{
                Name = "Unload UI";
                Callback = function()
                    Library:Unload()
                end
            }
        end
    end
end

do
    local Players = game.Players
    local LocalPlayer = Players.LocalPlayer
    local Mouse = LocalPlayer:GetMouse()
    local CurrentCamera = workspace.CurrentCamera
    local silent_enabled = false
    local Target = nil

     -- // Functions
     local SeeAble = function(Player)
        local raybeamkaboom = Ray.new(game.Players.LocalPlayer.Character.Head.Position, (Player.Position - game.Players.LocalPlayer.Character.Head.Position).Unit * 300)
        local Part, Position = workspace:FindPartOnRayWithIgnoreList(raybeamkaboom, {game.Players.LocalPlayer.Character}, false, true)
        if Part then
            local Humanoid = Part.Parent:FindFirstChildOfClass("Humanoid")
            if not Humanoid then
                Humanoid = Part.Parent.Parent:FindFirstChildOfClass("Humanoid")
            end
            if Humanoid and Player and Humanoid.Parent == Player.Parent then
                local Vector, OnScreen = workspace.CurrentCamera:WorldToScreenPoint(Player.Position)
                if OnScreen then 
                    return true
                end
            end
        end
    end
    local GetClosestPart = function(Character)
        local TargetParts = {"Head", "Torso", "Right Arm", "Left Arm", "Right Leg", "Left Leg"}
        local ClosestPart = nil
        local ClosestPartPosition = nil
        local ClosestPartOnScreen = false
        local ClosestPartMagnitudeFromMouse = nil
        local ShortestDistance = 1/0
    
        local function CheckTargetPart(TargetPart)
            if (typeof(TargetPart) == "string") then
                TargetPart = Instance.new("Part").FindFirstChild(Character, TargetPart)
            end
    
            if not (TargetPart) then
                return
            end
    
            local PartPos, onScreen = CurrentCamera.WorldToViewportPoint(CurrentCamera, TargetPart.Position)
            local GuiInset = Services.GuiService:GetGuiInset(Services.GuiServic)
            local Magnitude = (Vector2.new(PartPos.X, PartPos.Y - GuiInset.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
    
            if (Magnitude < ShortestDistance) then
                ClosestPart = TargetPart
                ClosestPartPosition = PartPos
                ClosestPartOnScreen = onScreen
                ClosestPartMagnitudeFromMouse = Magnitude
                ShortestDistance = Magnitude
            end
        end
    
        if (typeof(TargetParts) == "string") then
            if (TargetParts == "All") then
                for _, v in ipairs(Character:GetChildren()) do
                    if not (v:IsA("BasePart")) then
                        continue
                    end
                    CheckTargetPart(v)
                end
            else
                CheckTargetPart(TargetParts)
            end
        end
    
        if (typeof(TargetParts) == "table") then
            for _, TargetPartName in ipairs(TargetParts) do
                CheckTargetPart(TargetPartName)
            end
        end
        return ClosestPart, ClosestPartPosition, ClosestPartOnScreen, ClosestPartMagnitudeFromMouse
    end
    
    local GetClosestPlayerToCursor = function()
        local TargetPart = nil
        local ClosestPlayer = nil
    
        local ShortestDistance = 1/0
    
        for _, Player in ipairs(game.Players:GetPlayers()) do
            local Character = Player.Character
            if Character and Config.Aiming.Enabled then
                local TargetPartTemp, _, _, Magnitude = GetClosestPart(Character)
                
                if TargetPartTemp then
                    if (Config.Aiming.MouseDist*3) > Magnitude and Magnitude < ShortestDistance then
                        if Player ~= LocalPlayer then
                            ClosestPlayer = Player 
                            ShortestDistance = Magnitude
                            TargetPart = TargetPartTemp
                        end
                    end
                end
            end
        end
    
        return ClosestPlayer
    end

    Services.UserInput.InputBegan:connect(function(InputObj, Process)
        if not Process then
            if InputObj.KeyCode == Config.Keys.SilentKey and Config.Aiming.Enabled then
                if not silent_enabled then
                    Target = GetClosestPlayerToCursor()
                    silent_enabled = true
                    print(GetClosestPart(Target.Character).Name)
                    if Config.Notifications.Enabled then
                        Notification:Notify(
                            {Title = "Artic-Streets", Description = "Locked onto " .. (Target.DisplayName)},
                            {OutlineColor = Color3.new(153/255, 75/255, 75/255), Time = 2, Type = "image"},
                            {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 255, 255)}
                        )
                    end
                else
                    Target = nil
                    silent_enabled = false
                end

                if Config.Checks.Wall_Check then
                    if not SeeAble(Target.Character.Head) then
                        silent_enabled = false
                        Target = nil
                    end
                end
            end
        end
    end)

    task.spawn(function()
        pcall(function()
            while task.wait() do
                if Config.Aiming.Enabled and silent_enabled then
                    if Config.Aiming.UseClosetPart then
                        Config.Options.Hitpart = GetClosestPart(Target.Character).Name
                    end
                end
            end
        end)
    end)
    task.spawn(function()
        pcall(function()
            Services.RunService.Heartbeat:connect(function()
                if Config.Options.Resolver then
                    for i,v in next, game.Players:GetPlayers() do
                        if v ~= LocalPlayer and v.Character then
                            local Root = v.Character.HumanoidRootPart
                            Root.Velocity = Vector3.new(0, 0, 0)
                            Root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        end
                    end
                end
            end)
        end)
    end)
    task.spawn(function()
        pcall(function()
            while task.wait() do
                if Config.Options.AutoPrediction then
                    local Ping = Services.Statistics.Network.ServerStatsItem["Data Ping"]:GetValue()
                    if Ping > 190 then
                        Config.Options.Prediction = 0.206547
                    elseif Ping > 180 then
                        Config.Options.Prediction = 0.19284
                    elseif Ping > 170 then
                        Config.Options.Prediction = 0.1923111
                    elseif Ping > 160 then
                        Config.Options.Prediction = 0.1823111
                    elseif Ping > 150 then
                        Config.Options.Prediction = 0.171
                    elseif Ping > 140 then
                        Config.Options.Prediction = 0.165773
                    elseif Ping > 130 then
                        Config.Options.Prediction = 0.1223333
                    elseif Ping > 120 then
                        Config.Options.Prediction = 0.143765
                    elseif Ping > 110 then
                        Config.Options.Prediction = 0.1455
                    elseif Ping > 100 then
                        Config.Options.Prediction = 0.130340
                    elseif Ping > 90 then
                        Config.Options.Prediction = 0.136
                    elseif Ping > 80 then
                        Config.Options.Prediction = 0.1347
                    elseif Ping > 70 then
                        Config.Options.Prediction = 0.119
                    elseif Ping > 60 then
                        Config.Options.Prediction = 0.12731
                    elseif Ping > 50 then
                        Config.Options.Prediction = 0.127668
                    elseif Ping > 40 then
                        Config.Options.Prediction = 0.125
                    elseif Ping > 30 then
                        Config.Options.Prediction = 0.11
                    elseif Ping > 20 then
                        Config.Options.Prediction = 0.12588
                    elseif Ping > 10 then
                        Config.Options.Prediction = 0.9
                    end
                end
            end
        end)
    end)

    local finish_time = os.clock()
    Notification:Notify(
        {Title = "Artic-Streets", Description = "Loaded in " .. (finish_time - start_time) .. "(s)"},
        {OutlineColor = Color3.new(153/255, 75/255, 75/255), Time = 2, Type = "image"},
        {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 255, 255)}
    )

    -- Main Hook. DON'T EDIT UNLESS YOU KNOW WHAT YOU'RE DOING!
    local hook; hook = hookmetamethod(game, "__namecall", function(remote, ...)
        args = { ... }
        if getnamecallmethod() == "FireServer" and tostring(remote) == "Shoot" then
            if Config.Aiming.Enabled and silent_enabled then
                args[1] = Target.Character[Config.Options.Hitpart].CFrame + (Target.Character[Config.Options.Hitpart].Velocity * Config.Options.Prediction)
                return hook(remote, unpack(args))
            end
        end
        return hook(remote, ...)
    end)
end


--[[

 $$$$$$\  $$$$$$$\ $$$$$$$$\ $$$$$$\  $$$$$$\  
$$  __$$\ $$  __$$\\__$$  __|\_$$  _|$$  __$$\ 
$$ /  $$ |$$ |  $$ |  $$ |     $$ |  $$ /  \__|
$$$$$$$$ |$$$$$$$  |  $$ |     $$ |  $$ |      
$$  __$$ |$$  __$$<   $$ |     $$ |  $$ |      
$$ |  $$ |$$ |  $$ |  $$ |     $$ |  $$ |  $$\ 
$$ |  $$ |$$ |  $$ |  $$ |   $$$$$$\ \$$$$$$  |
\__|  \__|\__|  \__|  \__|   \______| \______/ 
            https://encrypts.lol

    [*] Scripted by ves#0001
    [*] Don't claim, give credit lol   

]]