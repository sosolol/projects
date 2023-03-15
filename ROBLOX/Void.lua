local Plr = game.Players.LocalPlayer
local Char = Plr.Character
local Humanoid = Char:FindFirstChildOfClass('Humanoid')

local GetPlr = function(String)
    local Found = {}
    local strl = String:lower()
        for i, v in pairs(game.Players:GetPlayers()) do
            if (v.Name:lower():sub(1, #String) == String:lower() or v.DisplayName:lower():sub(1, #String) == String:lower()) then
                table.insert(Found, v)
            end
        end
    return Found
end

local GetRoot = function(Character)
    local Root
    if (Character) then
        Root = Character:FindFirstChild('HumanoidRootPart')
    end
    return Root
end

local Void = function(Target)
    for i,v in pairs(GetPlr(Target)) do
        local MainRoot = GetRoot(Char)
        local TargetChar = v.Character
        local TargetRoot = GetRoot(TargetChar)
        local Tool = Plr.Backpack:FindFirstChildOfClass('Tool') or Char:FindFirstChildOfClass('Tool')
        local n = 0
        local NewHumanoid = Humanoid:clone()
    
        Humanoid.Name = '1'
        NewHumanoid.Parent = Char
        NewHumanoid.Name = 'Humanoid'
        NewHumanoid.DisplayDistanceType = 'None'
        task.wait()
        Humanoid:remove()
        workspace.CurrentCamera.CameraSubject = Char
    
        Tool.Parent = Char
        MainRoot.CFrame = MainRoot.CFrame * CFrame.new(math.random(-100, 100)/200,math.random(-100, 100)/200,math.random(-100, 100)/200)
        repeat task.wait(0.1)
            n = n+1
            MainRoot.CFrame = TargetRoot.CFrame
        until (Tool.Parent ~= Char or not MainRoot or not TargetRoot or n > 250) and n > 2
        repeat task.wait()
            MainRoot.CFrame = CFrame.new(0, 4e5, 0)
        until (not GetRoot(TargetChar) or not GetRoot(Char))
    end
end

Void('PLAYER')