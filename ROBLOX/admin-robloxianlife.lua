-- Script for Robloxian Life

local RunService = game:GetService("RunService")
local startTime = tick()
local ID = 8432951
local Prefix = ';'

-- [ Locals ] --
local Plrs = game.Players
local Plr = Plrs.LocalPlayer
local Mouse = Plr:GetMouse()
local Commands = {
    'Loadtool', 'Kill [Lkill] (plr)', 'Unlkill', 'Kidnap (plr)', 'Bring (plr)', 'Jail (plr)', 'Unicorn (plr)', 'Ununicorn', 'Play (AssetId)', 'Volume (Num)', 'Goto (plr)', 'Barvis', 'Barcolor (red, green, blue)', 'globalcloud', 'tag (plr)', 'board','Unload'
}
local Char = Plr.Character
local LoopKill = false
local cubevis, barvis = false

-- [ UI ] --
local UIAsset = 9857478385
local Version = 1
local UI = game:GetObjects(('rbxassetid://%s&version=%s'):format(UIAsset, Version))[1]; UI.Parent = game:GetService('CoreGui')
local Main = UI['Main']
local CommandsHolder = Main['Commands']
local CommandInput = Main['Input']
local CommandName = Main['Holder']
local Notification = loadstring(game:HttpGet('https://raw.githubusercontent.com/Kinlei/Dynissimo/main/Scripts/AkaliNotif.lua'))()
local Notify = Notification.Notify


-- [ Functions ] --
local CloudFunction = function(c, b, d)
    Plr.Character:FindFirstChild('PompousTheCloud').ServerControl:InvokeServer('SetProperty', {
        ['Value'] = d,
        ['Property'] = b,
        ['Object'] = c
    })
end

local GiveUnicorn = function(Id)
    local Item
    workspace.GiveTool:FireServer(tonumber(Id))
    Item = Plr.Backpack:FindFirstChild('FluffyUnicorn')
    if (not Char:FindFirstChild('FluffyUnicorn') and Item) then
        Item.Parent = Char
    else
        Plr.Backpack:WaitForChild('FluffyUnicorn').Parent = Char
    end
    Item = Char:FindFirstChild('FluffyUnicorn')
    Item:Activate()
    Item:remove()
    return Char.Head:WaitForChild('Fluffy')
end

local GiveHat = function(Id)
    local Replicated = game:GetService('ReplicatedStorage')

    if (Replicated) then
        Replicated.AvatarEditor.HatHandle:FireServer(Id)
    else
        Notify({Title = 'Zor', Description = '(Error) Couldnt get "ReplicatedStorage"', Duration = 1.5})
    end
end

for i,v in pairs(Commands) do
    for i = #Commands, #Commands do
        local Cloned = CommandName:clone()
        Cloned.Parent = CommandsHolder
        Cloned.Text = v
        Cloned.Visible = true
        Cloned.TextXAlignment = 'Left'
    end
end

local GetPlr = function(String)
    local Found = {}
    local strl = String:lower()
        for i, v in pairs(game.Players:GetPlayers()) do
            if (v.Name:lower():sub(1, #String) == String:lower() or v.DisplayName:lower():sub(1, #String) == String:lower()) then
                table.insert(Found, v)
            elseif (String == 'me') then
                table.insert(Found, game.Players.LocalPlayer)
            elseif (String == 'all') then
                table.insert(Found, v)
            end
        end
    return Found
end

-- [ Scripts ] --
Main.Position = UDim2.new(-0.5, -0.9, 0, 300)
task.wait(0.05)
Main:TweenPosition(UDim2.new(0, 0.9, 0, 300), 'Out', 'Quart', 0.25)
task.wait(1)
Main:TweenPosition(UDim2.new(-0.5, -0.9, 0, 300), 'In', 'Quart', 0.25)

Mouse.KeyDown:connect(function(key)
    if (key:match(Prefix)) then
        CommandInput:CaptureFocus()
        task.wait()
        if (string.sub(CommandInput.Text, 1, string.len(Prefix)):lower() == tostring(Prefix):lower()) then
            CommandInput.Text = string.sub(CommandInput.Text, string.len(Prefix)+1)
        end
        Main:TweenPosition(UDim2.new(0, 0.9, 0, 300), 'Out', 'Quart', 0.25)
    end
end)

CommandInput.FocusLost:connect(function()
    Main:TweenPosition(UDim2.new(-0.5, -0.9, 0, 300), 'In', 'Quart', 0.25)
    CommandInput.Text = ''
end)

-- [ Command Bar ] --
CommandInput.FocusLost:connect(function()
    local str = CommandInput.Text:lower()
    
    if (str == ('loadtool')) then
        for i,v in pairs(Plr.Backpack:GetChildren()) do
            if (v:IsA('Tool') and v.Name:match('Pompous')) then
                v.Parent = Plr.Character
                CloudFunction(Plr.Character.PompousTheCloud.Handle.Mesh, 'MeshId', '')
                task.wait(0.05)
                if (v:IsA('LocalScript')) then
                    v:remove()
                end
            end
        end
        for i,v in pairs(Plr.Character.Humanoid:GetPlayingAnimationTracks()) do
            v:stop()
        end
    end
    if (str:find('board')) then
        GiveHat(14129625)
        Char:WaitForChild('PhantomMask'):remove()
        local Board1 = Char:WaitForChild('14129625')
        for i,v in pairs(Board1.Handle:GetChildren()) do
            if (not v:IsA('SpecialMesh')) then
                v:remove()
            end
        end
        CloudFunction(Board1.Handle, 'Anchored', true)
        CloudFunction(Board1.Handle.Mesh, 'MeshId', 'rbxassetid://463255802')
        CloudFunction(Board1.Handle.Mesh, 'TextureId', 'rbxassetid://10296802135')
        CloudFunction(Board1.Handle.Mesh, 'Scale', Vector3.new(0.099, 0.16, 0.015))
        CloudFunction(Board1.Handle, 'Size', Vector3.new(34.78, 27.32, 4.06))
        CloudFunction(Board1.Handle, 'Orientation', Vector3.new(0, -150, -89.96))
        CloudFunction(Board1.Handle, 'Position', Vector3.new(-70.515, 3974.46, 394.958))
        CloudFunction(Board1.Handle, 'CanCollide', true)
        CloudFunction(Board1.Handle, 'Name', 'discord.gg/enz')
        CloudFunction(Board1['discord.gg/enz'], 'Parent', workspace)
        Board1:remove()
        GiveHat(14129625)
        Char:WaitForChild('PhantomMask'):remove()
        local Board2 = Char:WaitForChild('14129625')
        for i,v in pairs(Board2.Handle:GetChildren()) do
            if (not v:IsA('SpecialMesh')) then
                v:remove()
            end
        end
        CloudFunction(Board2.Handle, 'Anchored', true)
        CloudFunction(Board2.Handle.Mesh, 'MeshId', 'rbxassetid://463255802')
        CloudFunction(Board2.Handle.Mesh, 'TextureId', 'rbxassetid://10296802135')
        CloudFunction(Board2.Handle.Mesh, 'Scale', Vector3.new(0.099, 0.16, 0.015))
        CloudFunction(Board2.Handle, 'Size', Vector3.new(34.78, 27.32, 4.06))
        CloudFunction(Board2.Handle, 'Orientation', Vector3.new(0, 150, -89.9))
        CloudFunction(Board2.Handle, 'Position', Vector3.new(-8.005, 3973.827, 394.081))
        CloudFunction(Board2.Handle, 'CanCollide', true)
        CloudFunction(Board2.Handle, 'Name', 'discord.gg/enz')
        CloudFunction(Board2['discord.gg/enz'], 'Parent', workspace)
        Board2:remove()
    end
    if (str:find('kill')) then
        local args = string.split(str, ' ')[2]

        if (args) then
            for i,v in pairs(GetPlr(args)) do
                Char:FindFirstChild('PompousTheCloud').ServerControl:InvokeServer('Fly', {['Flying'] = true})
                CloudFunction(Char.PompousTheCloud:WaitForChild('EffectCloud'), 'Transparency', 1)
                CloudFunction(Char.PompousTheCloud.EffectCloud.Weld, 'C0', CFrame.new(1,1,1))
                CloudFunction(Char.PompousTheCloud.EffectCloud, 'Name', 'Head')
                CloudFunction(Char.PompousTheCloud.Head, 'Parent', v.Character)
                Char:FindFirstChild('PompousTheCloud').ServerControl:InvokeServer('Fly', {['Flying'] = false})
            end
        else
            Notify({Title = 'Zor', Description = '(Error) invalid arg provided [Player]', Duration = 1.5})
        end
    end
    if (str:find('lkill')) then
        local args = string.split(str, ' ')[2]
        if (args) then
            for i,v in pairs(GetPlr(args)) do
                LoopKill = true
                if (LoopKill) then
                    repeat task.wait()
                        if (not v.Character) then v.CharacterAdded:wait() end
                        Char:FindFirstChild('PompousTheCloud').ServerControl:InvokeServer('Fly', {['Flying'] = true})
                        CloudFunction(Char.PompousTheCloud:WaitForChild('EffectCloud'), 'Transparency', 1)
                        CloudFunction(Char.PompousTheCloud.EffectCloud.Weld, 'C0', CFrame.new(1,1,1))
                        CloudFunction(Char.PompousTheCloud.EffectCloud, 'Name', 'Head')
                        CloudFunction(Char.PompousTheCloud.Head, 'Parent', v.Character)
                        Char:FindFirstChild('PompousTheCloud').ServerControl:InvokeServer('Fly', {['Flying'] = false})
                    until not LoopKill
                end
            end
        else
            Notify({Title = 'Zor', Description = '(Error) invalid arg provided [Player]', Duration = 1.5})
        end
    end
    if (str == ('unlkill')) then
        LoopKill = false
    end
    if (str:find('unload')) then
        UI:remove()
    end
    if (str:find('kleg')) then
        local args = string.split(str, ' ')[2]

        if (args) then
            GiveHat(14129625)
            Char:WaitForChild('PhantomMask'):remove()
            for i,v in pairs(GetPlr(args)) do
                CloudFunction(Char['14129625'].Handle.Mesh, 'MeshId', 'rbxassetid://101851696')
                CloudFunction(Char['14129625'].Handle.Mesh, 'TextureId', 'rbxassetid://101851254')
                CloudFunction(Char['14129625'].Handle.Mesh, 'Scale', Vector3.new(1, 1, 1))
                CloudFunction(Char['14129625'].Handle.Mesh, 'Parent', v.Character['Right Leg'])
                Char['14129625']:remove()
            end
        else
            Notify({Title = 'Zor', Description = '(Error) invalid arg provided [Player]', Duration = 1.5})
        end
    end
    
    if (str:find('globalcloud')) then
        CloudFunction(Plr.Character:FindFirstChild('PompousTheCloud'), 'Parent', game.StarterPack)
    end
    
    if (str:find('tag')) then
        local args = string.split(str, ' ')[2]
        
        if (args) then
            for i,v in pairs(GetPlr(args)) do
                workspace:FindFirstChild('GuiEvent'):FireServer('') 
                local Head = Char:WaitForChild('').Head
                CloudFunction(Head.NametagTemplate, 'Parent', v.Character.Head)
                Char:WaitForChild(''):remove()
            end
            CloudFunction(Plr.Character.Head, 'Transparency', 0)
        else
            Notify({Title = 'Zor', Description = '(Error) invalid arg provided [Player]', Duration = 1.5})
        end
    end
    if (str:find('unicorn')) then
        local args = string.split(str, ' ')[2]

        if (args) then
            GiveUnicorn(2187476)
            GiveHat(14129625)
            Char:WaitForChild('PhantomMask')
            Char.PhantomMask:remove()

            for i,v in pairs(GetPlr(args)) do
                CloudFunction(Char['14129625'].Handle.AccessoryWeld, 'Parent', Char.Head.Fluffy)
                CloudFunction(Char['14129625']:remove())
                CloudFunction(Char.Head.Fluffy.AccessoryWeld, 'Part0', Char.Head.Fluffy)
                CloudFunction(Char.Head.Fluffy.AccessoryWeld, 'Part1', v.Character.HumanoidRootPart)
                CloudFunction(Char.Head.Fluffy, 'Transparency', 1)
            end
        else
            Notify({Title = 'Zor', Description = '(Error) invalid arg provided [Player]', Duration = 1.5})
        end
    end

    if (str:find('ununicorn')) then
        Char.Head.Fluffy:remove()
    end

    if (str:find('play')) then
        local args = string.split(str, ' ')[2]

        if (args) then
            if (not Char.HumanoidRootPart:FindFirstChild('Sound')) then
                Char:FindFirstChild('PompousTheCloud').ServerControl:InvokeServer('Fly', {['Flying'] = true})
                CloudFunction(Char.PompousTheCloud.EffectCloud.Wind, 'Name', 'Sound')
                CloudFunction(Char.PompousTheCloud.EffectCloud.Sound, 'Parent', Char.HumanoidRootPart)
                task.wait(0.5)
                CloudFunction(Char.HumanoidRootPart.Sound, 'SoundId', ('rbxassetid://%s'):format(args))
                CloudFunction(Char.HumanoidRootPart.Sound, 'Volume', 1)
                CloudFunction(Char.HumanoidRootPart.Sound, 'TimePosition', 0)
                CloudFunction(Char.HumanoidRootPart.Sound, 'Pitch', 1)
                CloudFunction(Char.HumanoidRootPart.Sound, 'EmitterSize', 99999)
                CloudFunction(Char.HumanoidRootPart.Sound, 'MaxDistance', 99999)
                CloudFunction(Char.HumanoidRootPart.Sound, 'Playing', true)
                CloudFunction(Char.HumanoidRootPart.Sound, 'IsPlaying', true)
                Char:FindFirstChild('PompousTheCloud').ServerControl:InvokeServer('Fly', {['Flying'] = false})
            elseif (Char.HumanoidRootPart:FindFirstChild('Sound')) then
                CloudFunction(Char.HumanoidRootPart.Sound, 'SoundId', ('rbxassetid://%s'):format(args))
                CloudFunction(Char.HumanoidRootPart.Sound, 'Volume', 1)
                CloudFunction(Char.HumanoidRootPart.Sound, 'TimePosition', 0)
                CloudFunction(Char.HumanoidRootPart.Sound, 'Pitch', 1)
                CloudFunction(Char.HumanoidRootPart.Sound, 'EmitterSize', 99999)
                CloudFunction(Char.HumanoidRootPart.Sound, 'MaxDistance', 99999)
                CloudFunction(Char.HumanoidRootPart.Sound, 'Playing', true)
                CloudFunction(Char.HumanoidRootPart.Sound, 'IsPlaying', true)
            end
        else
            Notify({Title = 'Zor', Description = '(Error) invalid arg provided [AssetId]', Duration = 1.5})
        end
    end

    if (str:find('volume')) then
        local args = string.split(str, ' ')[2]

        if (args) then
            if (Char.HumanoidRootPart:FindFirstChild('Sound')) then
                CloudFunction(Char.HumanoidRootPart.Sound, 'Volume', args)
            else
                Notify({Title = 'Zor', Description = '(Error) no playing audio detected', Duration = 1.5})
            end
        end
    end

    if (str:match('barcolor')) then
        local args = string.split(str, ' ')[2]

        if (args and Char:FindFirstChild('Bar1') and Char:FindFirstChild('Bar2')) then
            if (args == 'red') then
                CloudFunction(Char.Bar1, 'Color', Color3.fromRGB(255, 0, 0))
                CloudFunction(Char.Bar2, 'Color', Color3.fromRGB(255, 0, 0))
            elseif (args == 'green') then
                CloudFunction(Char.Bar1, 'Color', Color3.fromRGB(0, 255, 0))
                CloudFunction(Char.Bar2, 'Color', Color3.fromRGB(0, 255, 0))
            elseif (args == 'blue') then
                CloudFunction(Char.Bar1, 'Color', Color3.fromRGB(0, 0, 255))
                CloudFunction(Char.Bar2, 'Color', Color3.fromRGB(0, 0, 255))
            end
        end
    end

    if (str:find('kidnap')) then
        local args = string.split(str, ' ')[2]

        if (args and Char:FindFirstChild('PompousTheCloud')) then
            for i,v in pairs(GetPlr(args)) do
                Char:FindFirstChild('PompousTheCloud').ServerControl:InvokeServer('Fly', {['Flying'] = true})
                CloudFunction(Char.PompousTheCloud.EffectCloud, 'Transparency', 0)
                CloudFunction(Char.PompousTheCloud.EffectCloud.Mesh, 'MeshId', 'rbxassetid://4843028945')
                CloudFunction(Char.PompousTheCloud.EffectCloud.Mesh, 'TextureId', '')
                CloudFunction(Char.PompousTheCloud.EffectCloud.Mesh, 'Scale', Vector3.new(1,1,1))
                CloudFunction(Char.PompousTheCloud.EffectCloud, 'Color', Color3.fromRGB(255,255,255))
                CloudFunction(Char.PompousTheCloud.EffectCloud.Weld, 'Part0', v.Character.HumanoidRootPart)
                CloudFunction(Char.PompousTheCloud.EffectCloud, 'Anchored', true)
                CloudFunction(Char.PompousTheCloud.EffectCloud.Weld, 'C0', CFrame.new(0, -6, 0))
                task.wait(0.1)
                local numx = 4
                for i = 1, 37.5 do
                    task.wait()
                    CloudFunction(Char.PompousTheCloud.EffectCloud.Mesh, 'Offset', Vector3.new(numx, 6.7, 0))
                    CloudFunction(Char.PompousTheCloud.EffectCloud.Weld, 'C1', CFrame.new(numx, 0, 0))
                    numx = numx + 4.3
                end
                task.wait(0.5)
                CloudFunction(Char.PompousTheCloud.EffectCloud.Weld, 'C0', CFrame.new(0, 3213163126, 0))
                Char:FindFirstChild('PompousTheCloud').ServerControl:InvokeServer('Fly', {['Flying'] = false})
            end
        else
            Notify({Title = 'Zor', Description = '(Error) invalid arg provided [Player]', Duration = 1.5})
        end
    end

    if (str:find('bring')) then
        local args = string.split(str, ' ')[2]

        if (args and Char:FindFirstChild('PompousTheCloud')) then
            for i,v in pairs(GetPlr(args)) do
                workspace:FindFirstChild('GuiEvent'):FireServer('')
                local Part = Char:WaitForChild('')
                Char:FindFirstChild('PompousTheCloud').ServerControl:InvokeServer('Fly', {['Flying'] = true})
                CloudFunction(Part.Head.Weld, 'Parent', Char.PompousTheCloud.Handle)
                CloudFunction(Part.Head, 'Anchored', true)
                CloudFunction(Char.PompousTheCloud.Handle.Weld, 'Part1', v.Character.HumanoidRootPart)
                task.wait()
                Part:remove()
                Char.PompousTheCloud.Handle.Weld:remove()
                CloudFunction(Char.Head, 'Transparency', 0)
                Char:FindFirstChild('PompousTheCloud').ServerControl:InvokeServer('Fly', {['Flying'] = false})
            end
        else
            Notify({Title = 'Zor', Description = '(Error) invalid arg provided [Player]', Duration = 1.5})
        end
    end

    if (str:find('jail')) then
        local args = string.split(str, ' ')[2]

        if (args and Char:FindFirstChild('PompousTheCloud')) then
            for i,v in pairs(GetPlr(args)) do
                Char:FindFirstChild('PompousTheCloud').ServerControl:InvokeServer('Fly', {['Flying'] = true})
                CloudFunction(Char.PompousTheCloud.EffectCloud.Smoke:remove())
                CloudFunction(Char.PompousTheCloud.EffectCloud, 'Color', Color3.fromRGB(255, 0, 0))
                CloudFunction(Char.PompousTheCloud.EffectCloud.Weld, 'Part0', Char.PompousTheCloud.EffectCloud)
                CloudFunction(Char.PompousTheCloud.EffectCloud, 'Material', 'Neon')
                CloudFunction(Char.PompousTheCloud.EffectCloud.Mesh, 'Scale', Vector3.new(1,1,1))
                CloudFunction(Char.PompousTheCloud.EffectCloud.Mesh, 'Offset', Vector3.new(1, -4, 0))
                CloudFunction(Char.PompousTheCloud.EffectCloud.Mesh, 'MeshId', 'rbxassetid://5230387796')
                CloudFunction(Char.PompousTheCloud.EffectCloud.Mesh, 'TextureId', '')
                CloudFunction(Char.PompousTheCloud.EffectCloud, 'CFrame', v.Character)
                CloudFunction(Char.PompousTheCloud.EffectCloud.Weld, 'Part1', v.Character.HumanoidRootPart)
                CloudFunction(Char.PompousTheCloud.EffectCloud, 'Anchored', true)
                CloudFunction(Char.PompousTheCloud.EffectCloud, 'Parent', v.Character.HumanoidRootPart)
                Char.PompousTheCloud:remove()
                workspace.GiveTool:FireServer(ID, 'PompousTheCloud')
                Plr.Backpack:WaitForChild('PompousTheCloud').Parent = Char
            end
        else
            Notify({Title = 'Zor', Description = '(Error) invalid arg provided [Player]', Duration = 1.5})
        end
    end
end)

-- [ Runservice ] --
workspace.GiveTool:FireServer(ID, 'PompousTheCloud')


















































--[[
_________________  __________  
\____    /\   _  \ \______   \ 
  /     / /  /_\  \ |       _/ 
 /     /_ \  \_/   \|    |   \ 
/_______ \ \_____  /|____|_  / 
        \/       \/        \/  
]]--#region
Notify({Title = 'Zor', Description = (('Loaded in %s second(s)'):format(('%.3f'):format(tick() - startTime))), Duration = 1.5})
repeat task.wait()
    Char = game.Players.LocalPlayer.Character
until Fart