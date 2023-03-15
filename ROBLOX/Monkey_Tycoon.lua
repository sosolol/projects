t = tick()
local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Triple-Zs/lib/main/Finity"))()
local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()

local Window = Lib.new(true, "Xans | Monkey Tycoon"); Window.ChangeToggleKey(Enum.KeyCode.F2)
local Tabs = { Window:Category("Home"); Window:Category("Main") }
local Replicated = game:GetService("ReplicatedStorage")
local Config = {
    AutoSelling = false;
    AutoGrabbing = false;
    ["Grab"] = {
        Replicated.GTycoonClient.Remotes.GrabDrops, 9e9
    };
    ["Deposit"] = {
        Replicated.GTycoonClient.Remotes.DepositDrops, 9e9
    };
    ["Dropper"] = {
        Replicated.GTycoonClient.Remotes.BuyDropper, 1
    };
    ["Speed"] = {
        Replicated.GTycoonClient.Remotes.BuySpeed, 1
    };
    ["Merge"] = {
        Replicated.GTycoonClient.Remotes.MergeDroppers
    }
}

do
    local MainSector = Tabs[1]:Sector("Main")
    MainSector:Cheat("Label", "Script by [ Xan (728711900841377832) ]")
    MainSector:Cheat("Label", "Lib [ Fork of FinityUi ] ")
    MainSector:Cheat("Label", "Script Version [ v1.0.0 ]")
    local LinkSector = Tabs[1]:Sector("Links")
    LinkSector:Cheat("Button", "Discord", function()
        local http = game:GetService('HttpService')
        local req = (syn and syn.request) or (http and http.request) or http_request
        if req then
            req(
                {
                    Url = 'http://127.0.0.1:6463/rpc?v=1',
                    Method = 'POST',
                    Headers = {
                        ['Content-Type'] = 'application/json',
                        Origin = 'https://discord.com'
                    },
                    Body = http:JSONEncode({
                    cmd = 'INVITE_BROWSER',
                    nonce = http:GenerateGUID(false),
                    args = {code = 'JAuAUcKa6y'}
                })
            })
        end
    end, {text = "Join"})

    local SellSector = Tabs[2]:Sector("Sell")
    SellSector:Cheat("Checkbox", "Auto Sell", function(state)
        Config.AutoSelling = state
    end)

    SellSector:Cheat("Checkbox", "Auto Grab", function(state)
        Config.AutoGrabbing = state
    end)

    SellSector:Cheat("Button", "Grab All", function()
        Config.Grab[1]:FireServer(Config.Grab[2])
    end, {text = "Click"})

    SellSector:Cheat("Button", "Sell All", function()
        Config.Deposit[1]:FireServer(Config.Deposit[2])
    end, {text = "Click"})

    local BuySector = Tabs[2]:Sector("Buy")
    BuySector:Cheat("TextBox", "Monkey Amt", function(state)
        Config.Dropper[2] = state
    end,{placeholder = "1"})

    BuySector:Cheat("Button", "Buy Monkey", function()
        Config.Dropper[1]:FireServer(Config.Dropper[2])
    end, {text = "Click"})
    BuySector:Cheat("Label", "")
    BuySector:Cheat("TextBox", "Rate Amt", function(state)
        Config.Speed[2] = state
    end,{placeholder = "1"})
    
    BuySector:Cheat("Button", "Rate Speed", function()
        Config.Speed[1]:FireServer(Config.Speed[2])
    end, {text = "Click"})
    BuySector:Cheat("Label", "")
    BuySector:Cheat("Button", "Merge All", function()
        Config.Merge[1]:FireServer()
    end, {text = "Click"})

    task.spawn(function()
        pcall(function()
            while task.wait() do
                if Config.AutoSelling then
                    task.wait(1)
                    Config.Deposit[1]:FireServer(Config.Deposit[2])
                end
                if Config.AutoGrabbing then
                    task.wait(1)
                    Config.Grab[1]:FireServer(Config.Grab[2])
                end
            end
        end)
    end)
end