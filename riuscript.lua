

local TextService = game:GetService("TextService")
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Robojini/Tuturial_UI_Library/main/UI_Template_1"))()

local Window = Library.CreateLib("firpishub", "RJTheme6")

local Tab = Window:NewTab("Fast-money")

local Section = Tab:NewSection("buggy")

Section:NewButton("Item farm", "Laggy as fuck", function()

local Players = game:GetService("Players")
local Plr = Players.LocalPlayer;
local Char = Plr.Character or Plr.Character:Wait();
local Map = game:GetService("Workspace"):WaitForChild("Map", 1337)
local Spawned_Items = Map:WaitForChild("Items", 1337).SpawnedItems

game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
   prompt.HoldDuration = 0
end)
-- lol
for i,item in pairs(Spawned_Items:GetChildren()) do
    if item then
        local Proximity = item:FindFirstChild("ProximityPrompt",true);
        if Proximity and Proximity:IsA("ProximityPrompt") and Char.PrimaryPart then
            if item:IsA("Model") then item = item.PrimaryPart; end
            Char.PrimaryPart.CFrame  = item.CFrame + Vector3.new(0, 3, 0);
            task.wait(1)
            fireproximityprompt(Proximity);
            task.wait(0.2)
        end
    end
end
end)

local Section = Tab:NewSection("Auto-Sells")

Section:NewSlider("Arrow auto-sell", "Auto sell number of arrows = number in slider", 10, 0, function(s) -- 500 (Макс. значение) | 0 (Мин. значение)
    local args = {
    [1] = game:GetService("Players").LocalPlayer.Character,
    [2] = "Arrow",
    [3] = "Arrow",
    [4] = "Cash",
    [5] = 2000,
    [6] = s
}
game:GetService("ReplicatedStorage").Events.ItemSellEvent:FireServer(unpack(args))
end)

Section:NewSlider("SBall auto-sell", "Auto sell number of balls = number in slider", 10, 0, function(s) -- 500 (Макс. значение) | 0 (Мин. значение)
local args = {
    [1] = game:GetService("Players").LocalPlayer.Character,
    [2] = "Steel Ball",
    [3] = "SteelBall",
    [4] = "Cash",
    [5] = 500,
    [6] = s
}

game:GetService("ReplicatedStorage").Events.ItemSellEvent:FireServer(unpack(args))

end)

Section:NewSlider("SMask auto-sell", "Auto sell number of masks = number in slider", 10, 0, function(s) -- 500 (Макс. значение) | 0 (Мин. значение)
    local args = {
    [1] = game:GetService("Players").LocalPlayer.Character,
    [2] = "Stone Mask",
    [3] = "StoneMask",
    [4] = "Cash",
    [5] = 2000,
    [6] = s
}
game:GetService("ReplicatedStorage").Events.ItemSellEvent:FireServer(unpack(args))
end)

Section:NewSlider("Req Arrow auto-sell", "Auto sell number of reqarrows = number in slider", 10, 0, function(s) -- 500 (Макс. значение) | 0 (Мин. значение)
    local args = {
    [1] = game:GetService("Players").LocalPlayer.Character,
    [2] = "Requiem Arrow",
    [3] = "RequiemArrow",
    [4] = "Cash",
    [5] = 2000,
    [6] = s
}
game:GetService("ReplicatedStorage").Events.ItemSellEvent:FireServer(unpack(args))
end)

local Section = Tab:NewSection("Server hop button")

Section:NewButton("Server hop", "just hopping server, questions?", function()
    local PlaceID = game.PlaceId
          local AllIDs = {}
          local foundAnything = ""
          local actualHour = os.date("!*t").hour
          local Deleted = false
          --[[
          local File = pcall(function()
              AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
          end)
          if not File then
              table.insert(AllIDs, actualHour)
              writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
          end
          ]]
          function TPReturner()
              local Site;
              if foundAnything == "" then
                  Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
              else
                  Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
              end
              local ID = ""
              if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
                  foundAnything = Site.nextPageCursor
              end
              local num = 0;
              for i,v in pairs(Site.data) do
                  local Possible = true
                  ID = tostring(v.id)
                  if tonumber(v.maxPlayers) > tonumber(v.playing) then
                      for _,Existing in pairs(AllIDs) do
                          if num ~= 0 then
                              if ID == tostring(Existing) then
                                  Possible = false
                              end
                          else
                              if tonumber(actualHour) ~= tonumber(Existing) then
                                  local delFile = pcall(function()
                                      -- delfile("NotSameServers.json")
                                      AllIDs = {}
                                      table.insert(AllIDs, actualHour)
                                  end)
                              end
                          end
                          num = num + 1
                      end
                      if Possible == true then
                          table.insert(AllIDs, ID)
                          wait()
                          pcall(function()
                              -- writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                              wait()
                              game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                          end)
                          wait(4)
                      end
                  end
              end
          end

          function Teleport()
              while wait() do
                  pcall(function()
                      TPReturner()
                      if foundAnything ~= "" then
                          TPReturner()
                      end
                  end)
              end
          end

          Teleport()
end)

local Tab = Window:NewTab("Standart Functions")

local Section = Tab:NewSection("JP, WS, Gravity etc")

Section:NewTextBox("Walkspeed changer", "Normal ws, what are you looking at?", function(txt)
    while wait() do
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = txt
    end
end)

Section:NewTextBox("Jumppower changer", "Normal jp, what are you looking at?", function(txt)
    while wait() do
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = txt
    end
end)

Section:NewTextBox("Gravity changer", "Normal gravity changer, what are you looking at?", function(txt)
    while wait() do
        game.Workspace.Gravity = txt
    end
end)

Section:NewButton("Enable CTRL + Click TP", "^^^^^^^^^^^", function()

local Plr = game:GetService("Players").LocalPlayer local Mouse = Plr:GetMouse()

Mouse.Button1Down:connect( function() if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then return end if not Mouse.Target then return end Plr.Character:MoveTo(Mouse.Hit.p) end )

end)

local Tab = Window:NewTab("Stand")

local Section = Tab:NewSection("Stand related things")

Section:NewButton("Use arrow", "oh no my arow", function()
    local args = {
        [1] = game:GetService("Players").LocalPlayer.Character,
        [2] = "Arrow",
        [3] = "Arrow"
    }
    
    game:GetService("ReplicatedStorage").Events.ItemUseEvent:FireServer(unpack(args))
end)

Section:NewButton("Reset points (roka needed)", "roka pls", function()
    local args = {
        [1] = game:GetService("Players").LocalPlayer.Character,
        [2] = "Locacaca",
        [3] = "Locacaca"
    }
    
    game:GetService("ReplicatedStorage").Events.ItemUseEvent:FireServer(unpack(args))
end)

Section:NewButton("Reset stand for money", "oh no my mone", function()
    local args = {
        [1] = game:GetService("Players").LocalPlayer.Character,
        [2] = "Remove Stand",
        [4] = 1000
    }
    
    game:GetService("ReplicatedStorage").Events.InteractEvent:FireServer(unpack(args))
end)

Section:NewButton("Reset Specialiy", "oh no my mone", function()
    local args = {
        [1] = game:GetService("Players").LocalPlayer.Character,
        [2] = "Remove Speciality",
        [4] = 1000
    }
    
    game:GetService("ReplicatedStorage").Events.InteractEvent:FireServer(unpack(args))
end)

local Tab = Window:NewTab("ESP")


local Section = Tab:NewSection("Player esp")

Section:NewButton("Chams (read desc)", "To disable rejoin or server hop, im lazy", function()
    _G.FriendColor = Color3.fromRGB(255, 0, 0)
_G.EnemyColor = Color3.fromRGB(255, 0, 0)
_G.UseTeamColor = false

--------------------------------------------------------------------

loadstring(game:HttpGet("https://raw.githubusercontent.com/zeroisswag/universal-esp/main/esp.lua"))()
end)

Section:NewButton("Name esp (read desc)", "To disable press P button", function()
    
    local function API_Check()
        if Drawing == nil then
            return "No"
        else
            return "Yes"
        end
    end
    
    local Find_Required = API_Check()
    
    if Find_Required == "No" then
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Exunys Developer";
            Text = "ESP script could not be loaded because your exploit is unsupported.";
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
    
    _G.SendNotifications = true   -- If set to true then the script would notify you frequently on any changes applied and when loaded / errored. (If a game can detect this, it is recommended to set it to false)
    _G.DefaultSettings = false   -- If set to true then the ESP script would run with default settings regardless of any changes you made.
    
    _G.TeamCheck = false   -- If set to true then the script would create ESP only for the enemy team members.
    
    _G.ESPVisible = true   -- If set to true then the ESP will be visible and vice versa.
    _G.TextColor = Color3.fromRGB(94, 219, 90)   -- The color that the boxes would appear as.
    _G.TextSize = 20   -- The size of the text.
    _G.Center = true   -- If set to true then the script would be located at the center of the label.
    _G.Outline = true   -- If set to true then the text would have an outline.
    _G.OutlineColor = Color3.fromRGB(0, 0, 0)   -- The outline color of the text.
    _G.TextTransparency = 0.7   -- The transparency of the text.
    _G.TextFont = Drawing.Fonts.UI   -- The font of the text. (UI, System, Plex, Monospace) 
    
    _G.DisableKey = Enum.KeyCode.P   -- The key that disables / enables the ESP.
    
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
                            ESP.Text = ("("..tostring(math.floor(tonumber(Dist)))..") "..v.Name.." ["..workspace[v.Name].Humanoid.Health.."]")
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
                                ESP.Text = ("("..tostring(math.floor(tonumber(Dist)))..") "..v.Name.." ["..workspace[v.Name].Humanoid.Health.."]")
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
    
    if _G.DefaultSettings == true then
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
            
            if _G.SendNotifications == true then
                game:GetService("StarterGui"):SetCore("SendNotification",{
                    Title = "ESP notify";
                    Text = "The ESP's visibility is now set to "..tostring(_G.ESPVisible)..".";
                    Duration = 5;
                })
            end
        end
    end)
    
    local Success, Errored = pcall(function()
        CreateESP()
    end)
    
end)

local Tab = Window:NewTab("Combat")

local Section = Tab:NewSection("Combat")

Section:NewKeybind("KeybindText", "KeybindInfo", Enum.KeyCode.C, function()
	local args = {
        [1] = "Blood Suck",
        [2] = true,
        [3] = false
    }
    
    game:GetService("Players").LocalPlayer.Backpack.Events.HotkeyEvent:FireServer(unpack(args))

    local CurrentCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame

    wait(3.6)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1382.28699, 425.571014, -11729.7051, -0.999533832, 0.0061407024, -0.029907437, 9.71650227e-09, 0.979565084, 0.201127484, 0.0305313449, 0.201033726, -0.979108393)
    wait(1)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CurrentCFrame

    local CurrentCFrame = nil
    if CurrentCFrame == nil then
        print("lol ez nil moment")
    end
end)

local Tab = Window:NewTab("Teleports")

local Section = Tab:NewSection("Parts Teleport")

Section:NewButton("TP to Vento Aureo", "ButtonInfo", function()
    local PlaceIDGameTP1 = 8893338477
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
--[[
local File = pcall(function()
    AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)
if not File then
    table.insert(AllIDs, actualHour)
    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end
]]
function TPReturner()
    local Site;
    if foundAnything == "" then
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/8893338477/servers/Public?sortOrder=Asc&limit=100'))
    else
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/8893338477/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
    end
    local ID = ""
    if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
        foundAnything = Site.nextPageCursor
    end
    local num = 0;
    for i,v in pairs(Site.data) do
        local Possible = true
        ID = tostring(v.id)
        if tonumber(v.maxPlayers) > tonumber(v.playing) then
            for _,Existing in pairs(AllIDs) do
                if num ~= 0 then
                    if ID == tostring(Existing) then
                        Possible = false
                    end
                else
                    if tonumber(actualHour) ~= tonumber(Existing) then
                        local delFile = pcall(function()
                            -- delfile("NotSameServers.json")
                            AllIDs = {}
                            table.insert(AllIDs, actualHour)
                        end)
                    end
                end
                num = num + 1
            end
            if Possible == true then
                table.insert(AllIDs, ID)
                wait()
                pcall(function()
                    -- writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                    wait()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceIDGameTP1, ID, game.Players.LocalPlayer)
                end)
                wait(4)
            end
        end
    end
end

function Teleport()
    while wait() do
        pcall(function()
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end
end

Teleport()
end)

Section:NewButton("TP to Phantom Blood", "ButtonInfo", function()
    local PlaceIDGameTP2 = 8578977731
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
--[[
local File = pcall(function()
    AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)
if not File then
    table.insert(AllIDs, actualHour)
    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end
]]
function TPReturner()
    local Site;
    if foundAnything == "" then
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/8578977731/servers/Public?sortOrder=Asc&limit=100'))
    else
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/8578977731/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
    end
    local ID = ""
    if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
        foundAnything = Site.nextPageCursor
    end
    local num = 0;
    for i,v in pairs(Site.data) do
        local Possible = true
        ID = tostring(v.id)
        if tonumber(v.maxPlayers) > tonumber(v.playing) then
            for _,Existing in pairs(AllIDs) do
                if num ~= 0 then
                    if ID == tostring(Existing) then
                        Possible = false
                    end
                else
                    if tonumber(actualHour) ~= tonumber(Existing) then
                        local delFile = pcall(function()
                            -- delfile("NotSameServers.json")
                            AllIDs = {}
                            table.insert(AllIDs, actualHour)
                        end)
                    end
                end
                num = num + 1
            end
            if Possible == true then
                table.insert(AllIDs, ID)
                wait()
                pcall(function()
                    -- writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                    wait()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceIDGameTP2, ID, game.Players.LocalPlayer)
                end)
                wait(4)
            end
        end
    end
end

function Teleport()
    while wait() do
        pcall(function()
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end
end

Teleport()
end)

local Section = Tab:NewSection("Phantom Blood")

Section:NewButton("London", "Teleports you to a London", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1845.19849, 29.7123928, 3025.74731, 0.00122094119, 0, 0.999999225, 0, 1, 0, -0.999999225, 0, 0.00122094119)
end)

Section:NewButton("Jojo's Mansion", "???", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(762.982727, 28.3677502, 4730.42236, -0.99990499, 2.87755526e-08, 0.0137838069, 2.91144975e-08, 1, 2.43893918e-08, -0.0137838069, 2.47883829e-08, -0.99990499)
end)

Section:NewButton("Windknight's Lot", "One", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-547.102112, 40.9258423, 1013.32233, 0.999811351, -0.0194209944, 0.000169308158, 0.0194217321, 0.999774873, -0.00854456145, -3.3261822e-06, 0.00854623783, 0.999963462)
end)

Section:NewButton("The Graveyard", "bad", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-100.141289, 51.6230927, 70.4090652, 0.957996786, -0.00795572065, 0.286668509, 9.76671455e-09, 0.999615133, 0.0277416222, -0.286778867, -0.026576383, 0.957628071)
end)

Section:NewButton("Infront of DIO's Castle", "gloop", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-978.477844, 260.882874, -335.384369, 0.999999702, 5.3712288e-08, -0.000770651735, -5.37640936e-08, 1, -6.72060025e-08, 0.000770651735, 6.72474201e-08, 0.999999702)
end)

Section:NewButton("Inside of DIO's Castle", "and", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-976.183899, 467.123322, -2.36030602, -0.999952972, -0.000122374055, 0.00969847851, -8.72688499e-09, 0.999920428, 0.0126159573, -0.00969925057, 0.012615364, -0.9998734)
end)

Section:NewButton("Black market", "she", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1892.52881, 30.2123928, 3479.67358, 0.998187184, 1.77535728e-08, -0.0601859353, -1.69641208e-08, 1, 1.36278446e-08, 0.0601859353, -1.2582138e-08, 0.998187184)
end)

Section:NewButton("Zeppeli with hamon style", "do", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(755.208801, 25.0829582, 4067.96069, 0.119031861, -5.44950751e-08, 0.992890418, 9.04946944e-08, 1, 4.40364012e-08, -0.992890418, 8.46095816e-08, 0.119031861)
end)

Section:NewButton("Jonathan 1 (with noob dio)", "what", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(401.167786, 25.0829525, 3867.65625, -0.17515178, -2.28919852e-08, 0.984541416, 6.7610614e-08, 1, 3.52794736e-08, -0.984541416, 7.27447116e-08, -0.17515178)
end)

Section:NewButton("Jonathan 2", "i", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(737.197571, 28.2377281, 4730.22021, -0.00568518741, 2.37535147e-09, 0.999983847, 4.82336393e-09, 1, -2.34796782e-09, -0.999983847, 4.80993734e-09, -0.00568518741)
end)

Section:NewButton("Speedwagon (best waifu)", "yoinky", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1922.7605, 30.20467, 3392.86426, -0.0295611657, -6.062158e-10, 0.999562979, 5.81990955e-10, 1, 6.23692709e-10, -0.999562979, 6.00173689e-10, -0.0295611657)
end)

Section:NewButton("Zeppeli (graveyard)", "ButtonInfo", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-39.5531654, 49.9179611, 103.953903, -0.803889453, -4.04458902e-08, -0.594778717, -1.80445536e-09, 1, -6.55627161e-08, 0.594778717, -5.16319254e-08, -0.803889453)
end)

Section:NewButton("Jonathan 3 (with cool but still noob dio)", "ButtonInfo", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-995.955933, 260.875153, -322.133728, -0.853715777, -4.12438723e-08, 0.520739257, -6.10901836e-08, 1, -2.09505604e-08, -0.520739257, -4.96978778e-08, -0.853715777)
end)

Section:NewButton("Stand/Spec reset", "ButtonInfo", function()
    print("Clicked")
end)

Section:NewButton("Homeless noob", "ButtonInfo", function()
    print("Clicked")
end)

local Section = Tab:NewSection("Vento Aureo")

Section:NewButton("Koichi", "ButtonInfo", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-163.399643, 24.3252335, -5.08614779, -0.999996722, -3.67966422e-08, 0.00256014825, -3.6803609e-08, 1, -2.67327871e-09, -0.00256014825, -2.76749246e-09, -0.999996722)
end)

Section:NewButton("giorno thief", "ButtonInfo", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(166.440369, 53.825222, 277.13681, -0.00508177886, 4.10180654e-08, -0.999987066, 1.44929988e-08, 1, 4.09449434e-08, 0.999987066, -1.42847387e-08, -0.00508177886)
end)

Section:NewButton("Leaky eye luca", "ButtonInfo", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1114.40393, 51.8006325, 614.062622, -0.997706532, 3.24260192e-08, -0.0676879957, 3.02288861e-08, 1, 3.34839783e-08, 0.0676879957, 3.13610506e-08, -0.997706532)
end)

Section:NewButton("cool giorno 1", "ButtonInfo", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(635.529297, 199.073807, 749.618103, 0.83754319, -5.16588869e-08, -0.546371162, 7.53073053e-08, 1, 2.08909903e-08, 0.546371162, -5.8642847e-08, 0.83754319)
end)

Section:NewButton("noobie bruno", "ButtonInfo", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(353.158295, 203.198822, 1007.06165, 0.0246564765, -1.19522197e-08, 0.999695957, 3.55814329e-08, 1, 1.10782743e-08, -0.999695957, 3.52974645e-08, 0.0246564765)
end)

Section:NewButton("que pro bruno", "ButtonInfo", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-597.708191, 24.1278381, 435.581116, -0.0936404392, -9.51109627e-08, 0.995606065, -1.78014137e-08, 1, 9.38564284e-08, -0.995606065, -8.93443897e-09, -0.0936404392)
end)

Section:NewButton("imagin being scared of a number", "ButtonInfo", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-563.170776, 24.3252296, 670.623413, -0.999994934, -7.29502219e-08, 0.00318583031, -7.2743525e-08, 1, 6.49978631e-08, -0.00318583031, 6.47657856e-08, -0.999994934)
end)

Section:NewButton("abaqio", "ButtonInfo", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(835.589355, 53.9751968, 397.320374, 0.984155536, -3.6077108e-09, 0.177307457, -1.00988895e-09, 1, 2.59526516e-08, -0.177307457, -2.57205066e-08, 0.984155536)
end)

Section:NewButton("ButtonText", "ButtonInfo", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new
end)

Section:NewButton("ButtonText", "ButtonInfo", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new
end)

Section:NewButton("ButtonText", "ButtonInfo", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new
end)

Section:NewButton("ButtonText", "ButtonInfo", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new
end)

Section:NewButton("ButtonText", "ButtonInfo", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new
end)

Section:NewButton("ButtonText", "ButtonInfo", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new
end)

Section:NewButton("ButtonText", "ButtonInfo", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new
end)

Section:NewButton("Homeless Man", "completely forgot about him at part1 💀", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(14.2817774, 24.3252296, 13.2515678, 0.00245378539, 4.56619382e-08, 0.99999696, -1.17134658e-08, 1, -4.56333353e-08, -0.99999696, -1.16014558e-08, 0.00245378539)
end)

local Tab = Window:NewTab("Credits")

local Section = Tab:NewSection("Creators:")

Section:NewButton("bt807", "Came with idea, one of the dev", function()
    
end)

Section:NewButton("hadness", "one of the dev, made the most of script", function()
    
end)
end
end
