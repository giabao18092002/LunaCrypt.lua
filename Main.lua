
--INT
--[[#Definition :-x,y is in vector 2d which is in this context meaning it is client screen; x and y is the absolute position of a figure/we can use for synpase drawing library
- radius = r in a circle ; x and y is the absolute position of a circle
- xpos,ypos is the other player position represent in screen
- t,t_1 is length/width where t represent the magnitude of y axis and t_1 represent x axis
- rotationangle is the angle represent rotatation all of sides point from its original point (in this context im meaning A,B,C,D if we suppose we got quadrilateral ABCD)
This calculation can use for aimbot with square,triangle,circle 
**Rotation angle in this script meaning that you gonna rotate 
]]
local function IsInCircle(x,y,Radius,xpos,ypos) 
    if (xpos-x)^2+(ypos-y) <= Radius then
        return true
    else
        return false
    end
end
local function IsInSquare(x,y,xpos,ypos,t,rotationangle) --set rotationangle to zero if not,ratate max is 360 degree,if rotate oppsite of the direction of clowise just set rotation angle to positive number if not then MUST use negative number  
    --We gonna find all 4 side points in a square
    --Suppose we got square ABCD
    if rotationangle == 0 then
        local A,B,C,D = Vector2.new(x-t/2,y+t/2),Vector2.new(x+t/2,y+t/2),Vector2.new(x-t/2,y-t/2),Vector2.new(x+t/2,y-t/2)
        if xpos <= A.X and ypos <=A.Y and ypos >=D.Y and xpos>=B.X then
            return true
        else
            return false
        end
    elseif rotationangle<=360 and rotationangle > 0 then
        local A,B,C,D = Vector2.new(x-t/2,y+t/2),Vector2.new(x+t/2,y+t/2),Vector2.new(x-t/2,y-t/2),Vector2.new(x+t/2,y-t/2)
        local Radius = ((B-C).Magnitude)/2
        local AngleOBx = math.asin(((B-A).Magnitude)/2)* 180/3.14159  --(the value here is in radian cause math.asin return us with radian)represent angle ∠OBx where x is a perpendincular line from B point,and it stay fixed in x axis from the positive side,Let me explain here: we gonna need to calculate angle of Angle OBx and use rotation angle plus with the rotationangle(if rotationangle become negative then we actually use it to minus with angle OBx) we gonna use sinc-cos rule in triangle OBx right at x our idea here is to calculateangle OBx then plus with the rotationangle to get the actual vector of B since our first declearation of B coordinate is just its original line now we gonna find it by using tregonometric circle (you can search for explenation of trigonometric circle and how to find coordinate of a point )
        local SinAngleOB_newB = math.sin(AngleOBx+math.rad(rotationangle)) -- now return sin but in radian just same thing 
        local CosAngleOB_newB = math.cos(AngleOBx+math.rad(rotationangle))
        A,B,C,D = Vector2.new(A.X*Radius*SinAngleOB_newB,A.Y*Radius*CosAngleOB_newB),Vector2.new(B.X*Radius*SinAngleOB_newB,B.Y*Radius*CosAngleOB_newB),Vector2.new(C.X*SinAngleOB_newB,C.Y*CosAngleOB_newB),Vector2.new(D.X*SinAngleOB_newB,D.Y*CosAngleOB_newB) -- now we will calculate the atual coordinate of point A,B,C,D 
        if xpos <= A.X and ypos <=A.Y and ypos >=D.Y and xpos>=B.X then
            return true
        else
            return false
        end
    end
end
local function IsInRectangle(x,y,xpos,ypos,t,t_1,rotationangle)
    --Just like above now we gonna find 4 points
    --Suppose we got square ABCD
end
local function IsInTriangle()

end
local SupportedGame = {
    ["CENTAURA"] = 8735521924,
    ["Conquerors 3 Menu"] = 8377997,
    ["Karelia"] = 8855462985,

}
local UiLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Bracket/main/BracketV33.lua"))()

--//Variable 
local Players = game:GetService("Players")
local lplr = Players.LocalPlayer
local ps = game:GetService("PhysicsService")
local loop = game:GetService("RunService").RenderStepped
local mt = getrawmetatable(game)
--//MAIN
if game.PlaceId == SupportedGame["CENTAURA"] then --Centaura
    --//Dsiable Boundary Killing
    game:GetService("Players").LocalPlayer.PlayerGui.ReturnToCombatZone.BoundaryHandler.Enabled = false
    --// IMPORTANT HOOKS FOR "CENTAURA"
    --Library
    local Library = {
        AuraDistant = 5,
        DamageMultiplier = 1,
        DamageMultiplierEnabled = nil,
        Lag = nil,
        UnitPreference = nil, --Unit List {"Rifleman", "Assault","Grenadier","Medic","Officer","Mortarman","Flametrooper"}
        ProjectileBind = Color3.fromRGB(0,0,0),
        FlyEnbled = nil,
        FlySpeed = 1,
        SpinEnbled = nil,
        SpinSpeed = 1,
        BhopSpeed = 1,
        BhopEnabled = nil,
        LoadedAnimation = nil,
        AnimationId = nil,
        SarutationValue = nil,
        SpawnCFrame = CFrame.new(742.841248, -47.5000114, -5.41540813, -0.998077154, 6.19540899e-08, -0.0619838685, 5.74627919e-08, 1, 7.42417257e-08, 0.0619838685, 7.05372045e-08, -0.998077154),
        CloneScript = nil,
        ExistingFlingPart = nil,
        ExistingAntiSpawn = nil,
        NoSuppressionEffect = nil,
        Godmode = nil,
        AntiSpawnPart = nil
    }
    loop:Connect(function()
        if Library.Godmode then
            pcall(function()
                lplr.Character.Humanoid.Health = 100;
            end)
        end
    end)
    --Fly function
    local mouse = lplr:GetMouse()
    local UIS = game:GetService("UserInputService")
    local function NotificationUi()
        local module = {}
        return module
    end
    local ctrl = {f = 0, b = 0, l = 0, r = 0}
    local lastctrl = {f = 0, b = 0, l = 0, r = 0}
    local function Fly()
        local char = lplr.Character or lplr.CharacterAdded:Wait();
        local hrp = char.HumanoidRootPart
        local maxspeed = 50
        local speed = Library.FlySpeed
        local bg = nil
        local bv = nil
        local c1,c2
        local function Fly_1()
            bg = Instance.new("BodyGyro", hrp)
            bg.P = 9e4
            bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            bg.cframe = hrp.CFrame
            bv = Instance.new("BodyVelocity", hrp)
            bv.velocity = Vector3.new(0,0.1,0)
            bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
            repeat char.Humanoid.PlatformStand = true
            if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                speed = speed+.5+(speed/maxspeed)
                if speed > maxspeed then
                speed = maxspeed
                end
            elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
                speed = speed-1
                if speed < 0 then
                speed = 0
                end
            end
            if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
                lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
            elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
                bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
            else
                bv.velocity = Vector3.new(0,0.1,0)
            end
            loop:Wait()
            until not Library.FlyEnbled
            c2:Disconnect()
            c1:Disconnect()
            c1 = nil
            c2 = nil
            ctrl = {f = 0, b = 0, l = 0, r = 0}
            lastctrl = {f = 0, b = 0, l = 0, r = 0}
            speed = 0
            bv:Destroy()
            bv = nil
            char.Humanoid.PlatformStand = false
        end
        c1 = mouse.KeyDown:connect(function(key)
            if key:lower() == "w" then
                ctrl.f = 1
            elseif key:lower() == "s" then
                ctrl.b = -1
            elseif key:lower() == "a" then
                ctrl.l = -1
            elseif key:lower() == "d" then
                ctrl.r = 1
            end
        end)
        c2 = mouse.KeyUp:connect(function(key)
            if key:lower() == "w" then
                ctrl.f = 0
            elseif key:lower() == "s" then
                ctrl.b = 0
            elseif key:lower() == "a" then
                ctrl.l = 0
            elseif key:lower() == "d" then
                ctrl.r = 0
            end
        end)
        Fly_1()
    end
    --Hook the metamethod
    local oldNamecall 
    oldNamecall = hookfunction(mt.__namecall,function(...) -- hook the metamethod
        local self,arg1,arg2,arg3,arg4,arg6,arg7 = ...
        local method = getnamecallmethod()
        if method =="FireServer" then
            if self.Name == "DamageRemote" and Library.DamageMultiplierEnabled then
                arg3 = arg3 *Library.DamageMultiplier
            elseif Library.UnitPreference and self.Name == "ChooseClass"  then
                arg1 = Library.UnitPreference
            elseif self.Name == "RemoteEvent" then
                return 
            else
                local Possible = 0
                local Str = {}
                for i = 1,#self.Name do
                    Str[i] = string.sub(self.Name,i)
                end
                for i,v in pairs(Str) do
                    if tonumber(v) then
                        Possible +=1;
                    end
                end
                if Possible >=3 then
                    return
                end
            end
        elseif method == "InvokeServer" then
            if self.Name == "__FUNCTION" then
                return    
            end
        elseif method == "Fire" then
            if self.Name == "Suppression" and Library.NoSuppressionEffect then
                return
            end
        end
        return oldNamecall(...)
    end)
    local DefaultModuleSettings = {
        ["T"] = nil
    } --Module Settings For Gun
    for i,v in pairs(game:GetService("ReplicatedStorage").TREKModules.GunSettings:GetChildren()) do
        local mod = require(v)
        table.insert(DefaultModuleSettings,{})
    end
    for i,v in pairs(game:GetService("ReplicatedStorage").TREKModules.GunSettings:GetChildren()) do 
        if v.Name ~= "TemplateModule"then
            local mod = require(v)
            for index,key in pairs(DefaultModuleSettings) do
                local l_table = key
                table.insert(l_table,mod.firerate)
                table.insert(l_table,mod.AmmoCount)
                table.insert(l_table,mod.DefaultColor)
                table.insert(l_table,mod.Range)
                table.insert(l_table,mod.spread)
                table.insert(l_table,mod.crouchSpread)
                table.insert(l_table,mod.Weight)
                table.insert(l_table,mod.GunType)
            end
        end 
    end
    local function ResetModule(a:string,b:number) --Reset The Module In Case Client Dont Toggle Gun Mode Anymore
        for i,v in pairs(game:GetService("ReplicatedStorage").TREKModules.GunSettings:GetChildren()) do
            if v.Name ~= "TemplateModule"then
                local mod = require(v)
                mod[tostring(a)] = DefaultModuleSettings[i][b]
            end
        end
    end
    local Window = UiLib:Window({Name = "LunaCrypt.lua|Centaura"}) do
        local Legit = Window:Tab({Name  = "Legit"}) do
            local AimbotSection = Legit:Section({Name = "Enabled",Side = "Left"}) do
            
            end
            local Backtrack = Legit:Section({Name = "BackTrack",Side = "Right"}) do
            
            end
            local TriggerBot = Legit:Section({Name = "Trigger bot",Side = "Left"}) do
                TriggerBot:Toggle({Name = "Team Check",Value = false,Callback = function(val)
                    
                end})
            end
        end
        local Rage = Window:Tab({Name = "Rage"}) do
            local Gun= Rage:Section({Name = "Gun Mode",Side = "Left"}) do
                local infammoloop 
                Gun:Toggle({Name = "No Reload/ Infinite Ammo",Value = false,Callback = function(val)
                    infammoloop = val
                    if val then
                        for i,v in pairs(game:GetService("ReplicatedStorage").TREKModules.GunSettings:GetChildren()) do
                            local mod = require(v)
                            task.spawn(function()
                                local char = lplr.Character or lplr.CharacterAdded:Wait();
                                while true do
                                    if not infammoloop then 
                                        ResetModule("AmmoCount",2)
                                        break 
                                    end;
                                    mod.AmmoCount = 999999999999
                                    loop:Wait()
                                end
                            end)
                        end
                    else 
                        ResetModule("AmmoCount",2)
                    end
                end})
                local minigunloop 
                Gun:Toggle({Name = "Minigun",Value = false , Callback = function(val)
                    minigunloop = val
                    if val then 
                        for i,v in pairs(game:GetService("ReplicatedStorage").TREKModules.GunSettings:GetChildren()) do
                            local mod = require(v)
                            mod.firerate = 100000;
                            mod.AmmoCount = 999999999999
                            pcall(function()
                                lplr.Character:FindFirstAncestorOfClass("Tool").Gun.Enabled = false
                                 lplr.Character:FindFirstAncestorOfClass("Tool").Gun.Enabled = true
                            end)
                            task.spawn(function()
                                while true do
                                    if not minigunloop then 
                                        ResetModule("firerate",1)
                                        ResetModule("AmmoCount",2)
                                        break 
                                    end;
                                    mod.AmmoCount = 999999999999
                                    loop:Wait()
                                end
                            end)
                        end
                    else
                        ResetModule("firerate",1)
                        ResetModule("AmmoCount",2)
                    end
                end}):ToolTip("This exploit will be OP with rifleman/flame tropper since it is the most damage gun")
                Gun:Toggle({Name= "Infinite Range",Value = false,Callback = function(val)
                    if val then
                        for i,v in pairs(game:GetService("ReplicatedStorage").TREKModules.GunSettings:GetChildren()) do
                            local mod = require(v)
                            mod.Range = 100000000;
                        end
                    else
                        ResetModule("Range",4)
                    end
                end})
                Gun:Toggle({Name = "No Spread",Value = false,Callback = function(val)
                    if val then
                        for i,v in pairs(game:GetService("ReplicatedStorage").TREKModules.GunSettings:GetChildren()) do
                            local mod = require(v)
                            mod.spread = 0;
                            mod.crouchSpread = 0;
                        end
                    else
                        ResetModule("spread",5)
                        ResetModule("crouchSpread",6)
                    end
                end})
                Gun:Toggle({Name = "No Weight",Value = false,Callback = function(val)
                    if val then
                        for i,v in pairs(game:GetService("ReplicatedStorage").TREKModules.GunSettings:GetChildren()) do
                            local mod = require(v)
                            mod.Weight = 0;
                        end 
                    else
                        ResetModule("Weight",7)
                    end
                end})
                Gun:Slider({Name = "Damage Multiplier",Value =1,Min=1,Max=10,Callback = function(val)
                    Library.DamageMultiplier = val
                end})
                Gun:Toggle({Name = "Enabled Damage Multiplier",Value = false,Callback = function(val)
                    Library.DamageMultiplierEnabled = val
                end})
                Gun:Divider("Aura")
                Gun:Slider({Name = "Distant",Value = 5,Min =1, Max =40, Precise = 2,Callback = function(val)
                    Library.AuraDistant = val
                end})
                local auraloop
                Gun:Toggle({Name = "Enabled",Value = false,Callback = function(val)
                    auraloop = val
                    if val then
                        Players.PlayerAdded:Connect(function(v)
                            task.spawn(function()
                                while true do
                                    if Players.PlayerRemoving:Wait() == v then break end
                                    if not auraloop then break end;
                                    pcall(function()
                                        if (v.Character.Head.Position - lplr.Character.Head.Position).Magnitude <= Library.AuraDistant then
                                            local t = lplr.Character:FindFirstChildOfClass("Tool").Gun
                                            if t.Parent.Name == "CLUB" then
                                                local args = {
                                                    [1] = v.Character.Head.Position,
                                                    [2] = v.Character,
                                                    [3] = 100,
                                                    [4] = t,
                                                    [5] = v.Character.Torso,
                                                    [6] = "Melee"
                                                }
                                                game:GetService("ReplicatedStorage"):WaitForChild("TREKRemotes"):WaitForChild("DamageRemote"):FireServer(unpack(args))
                                            else
                                                local args = {
                                                    [1] = v.Character.Head.Position,
                                                    [2] = v.Character,
                                                    [3] = 100,
                                                    [4] = t,
                                                    [5] = v.Character.Torso,
                                                }
                                                game:GetService("ReplicatedStorage"):WaitForChild("TREKRemotes"):WaitForChild("DamageRemote"):FireServer(unpack(args))
                                            end
                                        end
                                    end)
                                    loop:Wait()
                                end
                            end)
                        end)
                        for i,v in pairs(Players:GetPlayers()) do
                            task.spawn(function()
                                while true do
                                    if Players.PlayerRemoving:Wait() == v then break end
                                    if not auraloop then break end;
                                    pcall(function()
                                        local t = lplr.Character:FindFirstChildOfClass("Tool").Gun
                                        if t.Parent.Name == "CLUB" then
                                            local args = {
                                                [1] = v.Character.Head.Position,
                                                [2] = v.Character,
                                                [3] = 100,
                                                [4] = t,
                                                [5] = v.Character.Head,
                                                [6] = "Melee"
                                            }
                                            game:GetService("ReplicatedStorage"):WaitForChild("TREKRemotes"):WaitForChild("DamageRemote"):FireServer(unpack(args))
                                        else
                                            local args = {
                                                [1] = v.Character.Head.Position,
                                                [2] = v.Character,
                                                [3] = 100,
                                                [4] = t.Gun,
                                                [5] = v.Character.Head
                                            }
                                            game:GetService("ReplicatedStorage"):WaitForChild("TREKRemotes"):WaitForChild("DamageRemote"):FireServer(unpack(args))
                                        end
                                    end)
                                    loop:Wait()
                                end
                            end)
                        end
                    end
                end})
            end
            local HumExploit = Rage:Section({Name = "Humanoid Exploit",Side = "Right"}) do
                HumExploit:Slider({Name = "Walk Speed",Min = 16,Max = 100,Value = 16,Callback= function(val)
                    local char = lplr.Character or lplr.CharacterAdded:Wait();
                    local Hum = char:WaitForChild("Humanoid")
                    Hum.WalkSpeed = val
                end})
                HumExploit:Slider({Name = "Jump Power",Min = 0,Max = 100 ,Value = 0,Callback = function(val)
                    local char = lplr.Character or lplr.CharacterAdded:Wait();
                    local Hum = char:WaitForChild("Humanoid")
                    Hum.JumpPower = val
                end})
                HumExploit:Slider({Name = "Fly Speed",Min = 1,Max = 10,Precise = 2,Value = 1 ,Callback = function(val)
                    Library.FlySpeed = val-1
                end})
                HumExploit:Toggle({Name = "Fly",Value = false,Callback = function(val)
                    Library.FlyEnbled = val
                    if val then
                        Fly()
                    end
                end})
                HumExploit:Slider({Name = "Spin Speed",Value = 1,Min = 1 ,Max=45,Unit = "Degree",Callback = function(val)
                    Library.SpinSpeed = val
                end})
                HumExploit:Toggle({Name = "Spin",Value = false,Callback = function(val)
                    Library.SpinEnbled = val
                    if val then
                        pcall(function()
                            local char = lplr.Character or lplr.CharacterAdded:Wait();
                            if char then
                                local hrp = char:WaitForChild("HumanoidRootPart")
                                task.spawn(function()
                                    while true do
                                        if not Library.SpinEnbled then
                                            break
                                        end;
                                        hrp.CFrame *=CFrame.Angles(0,math.rad(5*Library.SpinSpeed), 0)
                                        loop:Wait()
                                    end
                                end)
                            end
                        end)
                    end
                end})
                HumExploit:Label("Bhop")
                HumExploit:Slider({Name = "Bhop Speed",Value =1,Min =0,Max = 10,Callback = function(val)
                    Library.BhopSpeed = val
                end})
                HumExploit:Toggle({Name = "Enabled",Value = false,Callback = function(val)
                    Library.BhopEnabled = val
                    if val then
                        task.spawn(function()
                            while true do
                                if not Library.BhopEnabled then break end;
                                task.spawn(function()
                                    pcall(function()
                                        local char = lplr.Character or lplr
                                        local hum = char:FindFirstChildOfClass("Humanoid")
                                        local moveDirMag = hum.MoveDirection.Magnitude
                                        if hum:GetState() == Enum.HumanoidStateType.Running and moveDirMag >0 then
                                            hum:ChangeState(Enum.HumanoidStateType.Jumping)
                                        end
                                    end)
                                end)
                                if UIS:IsKeyDown("A") then add = 90 end      
                                if UIS:IsKeyDown("S") then add = 180 end      
                                if UIS:IsKeyDown("D") then add = 270 end      
                                if UIS:IsKeyDown("A") and UIS:IsKeyDown("W") then add = 45 end      
                                if UIS:IsKeyDown("D") and UIS:IsKeyDown("W") then add = 315 end      
                                if UIS:IsKeyDown("D") and UIS:IsKeyDown("S") then add = 225 end      
                                if UIS:IsKeyDown("A") and UIS:IsKeyDown("S") then add = 145 end   
                                local x, y, z = workspace.CurrentCamera.CFrame:ToOrientation()        
                                local rot = CFrame.new(workspace.CurrentCamera.CFrame.Position) * CFrame.Angles(0,y,0) * CFrame.Angles(0,math.rad(add),0)     
                                loop:Wait()
                            end
                        end)
                    end
                end})
                local fakeduckloop
                HumExploit:Toggle({Name = "Fake Duck",Value = false ,Callback = function(val)
                        fakeduckloop = val
                        if val then
                            task.spawn(function()
                                while true do
                                    if not fakeduckloop then break end;
                                    wait(.1)
                                end
                            end)
                        end
                end})
                local loopfakelag 
                HumExploit:Toggle({Name = "Fake Lag",Value = false,Callback = function(val)
                    if val then

                    end 
                end})
            end
            local godmodeloop
            local Exploit = Rage:Section({Name = "Exploit",Side = "Left"}) do
                Exploit:Toggle({Name = "GodMode",Value = false,Callback = function(val)
                    godmodeloop = val
                    if val then
                        task.spawn(function()
                            while true do
                                if not  godmodeloop then break end;
                                pcall(function()
                                    local t = lplr.Character:FindFirstChildOfClass("Tool").Gun
                                    if t.Parent.Name =="CLUB" then
                                        local args = {
                                            [1] = lplr.Character.HumanoidRootPart.Position,
                                            [2] = lplr.Character,
                                            [3] = -(0/0),
                                            [4] = t,
                                            [5] = lplr.Character:FindFirstChild("HumanoidRootPart"),
                                            [6] = "Melee"
                                            }
                                        game:GetService("ReplicatedStorage"):WaitForChild("TREKRemotes"):WaitForChild("DamageRemote"):FireServer(unpack(args))
                                    else
                                        game:GetService("ReplicatedStorage"):WaitForChild("TREKRemotes"):WaitForChild("FlashRemote"):FireServer()
                                        local args = {
                                            [1] = lplr.Character.HumanoidRootPart.Position,
                                            [2] = lplr.Character,
                                            [3] = -(0/0),
                                            [4] = t,
                                            [5] = lplr.Character:FindFirstChild("HumanoidRootPart"),
                                            }
                                        game:GetService("ReplicatedStorage"):WaitForChild("TREKRemotes"):WaitForChild("DamageRemote"):FireServer(unpack(args))
                                    end
                                end)
                                loop:Wait()
                            end
                        end)
                    end
                end})
                local loopantispawn
                local antispawnteamcheck

                Exploit:Divider()
                Exploit:Label("Anti Spawn")
                Exploit:Toggle({Name = "Anti Spawn",Value = false,Callback = function(val)
                    loopantispawn = val
                    if val then
                       local char = lplr.Character or lplr.CharacterAdded:Wait()
                       char:WaitForChild("")
                        Players.PlayerAdded:Connect(function(v)
                            repeat loop:Wait()
                                    if not loopantispawn then break end;
                            until pcall(function()
                                return v.Team ~= lplr.Team or v.Team == lplr.Team 
                            end) 
                            if antispawnteamcheck then
                                if v.Team ~= lplr.Team then

                                end
                            else

                            end
                        end)
                        for i,v in pairs(Players:GetPlayers()) do
                            if v ~= lplr then
                                if antispawnteamcheck then
                                    if v.Team ~= lplr.Team then
                                        task.spawn(function()
                                            while true do
                                                if not loopantispawn then break end;
                                                pcall(function()
                                                    if v.Character then
                                                        if (v.Character.HumanoidRootPart.CFrame - Library.SpawnCFrame).Magnitude <=12 then

                                                        end
                                                    end
                                                end)
                                                loop:Wait()
                                            end
                                        end)
                                    end
                                else
                                    task.spawn(function()
                                        while true do
                                            if not loopantispawn then break end;
                                            pcall(function()
                                                if v.Character then
                                                    if (v.Character.HumanoidRootPart.CFrame - Library.SpawnCFrame).Magnitude <=12 then

                                                    end
                                                end
                                            end)
                                            loop:Wait()
                                        end
                                    end)
                                end
                            end
                       end
                    end
                end})
                Exploit:Toggle({Name = "Team Check",Value = false, Callback = function(val)
                    antispawnteamcheck = val
                end})
                Exploit:Divider()
                local mortarteamcheck
                local loopmortar
                Exploit:Toggle({Name = "Mortar Everyone",Value = false, Callback=function(val)
                    loopmortar = val
                    if val then
                        Players.PlayerAdded:Connect(function(v)
                            task.spawn(function()
                                while true do
                                    if Players.PlayerRemoving:Wait() == v then break end
                                    if mortarteamcheck then 
                                        if v.Team == lplr.Team then
                                            loop:Wait()
                                            continue
                                        end
                                    end
                                    if not loopmortar then break end
                                    pcall(function()
                                        local args = {
                                            [1] = v.Character.HumanoidRootPart.Position
                                        }
                                        game:GetService("ReplicatedStorage"):WaitForChild("MortarFire"):FireServer(unpack(args))
                                    end)
                                    loop:Wait()
                                end
                            end)
                        end)
                        for i,v in pairs(Players:GetPlayers()) do
                            if v~= lplr then
                                task.spawn(function()
                                    while true do
                                        if Players.PlayerRemoving:Wait() == v then break end
                                        if mortarteamcheck then 
                                            if v.Team == lplr.Team then
                                                loop:Wait()
                                                continue
                                            end
                                        end
                                        if not loopmortar then break end
                                        pcall(function()
                                            local args = {
                                                [1] = v.Character.HumanoidRootPart.Position
                                            }
                                            game:GetService("ReplicatedStorage"):WaitForChild("MortarFire"):FireServer(unpack(args))
                                        end)
                                        loop:Wait()
                                    end
                                end)
                            end
                        end 
                    end
                end})
                Exploit:Toggle({Name = "Team Check",Value = false,Callback = function(val)
                    mortarteamcheck = val
                end})
                Exploit:Divider()
                Exploit:Toggle({Name = "No Burn Animation",Value = false , Callback = function(val)
                    if val then
                        task.spawn(function()
                            while true do
                                pcall(function()
                                    lplr.Character.BurnAnimation.Enabled = false
                                end)
                                loop:Wait()
                            end
                        end)
                    else
                        pcall(function()
                            lplr.Character.BurnAnimation.Enabled = true
                        end)
                    end
                end})
                local looplagspike
                Exploit:Toggle({Name = "Lag Spike",Value = false,Callback = function(val)
                    game:GetService("NetworkClient"):SetOutgoingKBPSLimit(10e10)
                    looplagspike = val
                    if val then
                        task.spawn(function()
                            while true do
                                for i = 1,math.random(8,15) do
                                    game:GetService("ReplicatedStorage").TREKRemotes.ReloadRemote:FireServer()
                                end
                                loop:Wait()
                            end
                        end)
                    end
                end})
                Exploit:Toggle({Name = "Crash Server",Value = false,Callback = function(val)
                    if val then
                        game:GetService("NetworkClient"):SetOutgoingKBPSLimit(math.huge)
                        loop:Connect(function()
                            for i = 1,50 do
                                game.ReplicatedStorage.OutOfBounds:FireServer()
                                game:GetService("ReplicatedStorage").LoadCharacter:FireServer()
                                local ohString1 = "Rifleman"
                                game:GetService("ReplicatedStorage").ChooseClass:FireServer(ohString1)
                            end
                        end)
                    end
                end})
            end
        end
        local Visual = Window:Tab({Name = "Visual"}) do
            local lightning = game:GetService("Lighting")
            local ColorCorrection = Instance.new("ColorCorrectionEffect",lightning)
            local esp = Visual:Section({Name = "ESP",Side = "Left"}) do
            
            end
            local client= Visual:Section({Name = "Client",Side = "Right"}) do
                client:Button({Name = "Beautify",Callback = function()
                    
                end})
                client:Toggle({Name = "Depth Of Field",Callback = function(val)
                    game:GetService("UserInputService").DepthOfField.Enabled = true
                end})
                client:Toggle({Name = "Better Shadow",Callback = function()
                    sethiddenproperty(game:GetService("Lighting"), "Technology",Enum.Technology.Future or Enum.Technology.Compatibility)
                end})
                client:Slider({Name = "Saturation",Min = 0,Max = 100,Value = 10,Callback = function(val)
                    
                end})
                client:Toggle({Name = "Enabled",Value = false,Callback = function(val)
                    if val then
                        ColorCorrection.Saturation = Library.SarutationValue/50 or 0;
                    else
                        ColorCorrection.Saturation = 0;
                    end
                end})
            end
            local NoEffect = Visual:Section({Name = "No Effect",Side = "Left"}) do
                NoEffect:Button({Name = "No blur screen effect",Callback = function()
                    lplr.PlayerScripts.Effects.Enabled = false
                end})
                NoEffect:Toggle({Name = "No suppression effect",Value = false,Callback = function(val)
                    Library.NoSuppressionEffect = val
                end})
                NoEffect:Toggle({Name = "No blood splattered effect",Callback = function(val)
                end})
            end
        end
        local Settings = Window:Tab({Name = "Settings"}) do
        end 
    end
    elseif game.PlaceId == 6788434697 then
        local AudioPlayer = Instance.new("Sound",workspace)
        AudioPlayer.Name = "LunaCrypt.lua Audio Player"
        local mouse = lplr:GetMouse()
        local mousedown = false
        local NoRealoding 
        mouse.Button1Down:Connect(function()
            mousedown = true
        end)
        mouse.Button1Up:Connect(function()
            mousedown = false
        end)
        local spawncframe = CFrame.new(6007.9502, 17.5, 1054.70007, -0.984812617, 0, -0.173621148, 0, 1, 0, 0.173621148, 0, -0.984812617)
        local Library = {
            PenisEnabled = nil,
            PenisEveryone = nil,
            Time = 12,
            TimeEnabled = nil,
            SoundAssetId = nil,
            SoundName = nil,
            SoundEnabled = nil,
            SoundVolume = 2,
            SoundVolumeClient = 1,
            DecalExploit = nil,
        }   
        local Window = UiLib:Window({Name = "LunaCrypt.lua|AniPhobia"}) do
            local Rage = Window:Tab({Name = "Rage"}) do
                local gunmode = Rage:Section({Name = "Gun Mode",Side = "Right"}) do
                    gunmode:Toggle({Name = "No Reloading", Value = false, Callback = function(val)
                        if val then
                            NoRealoding = mouse.Button1Down:Connect(function()
                                pcall(function()
                                    local tool = lplr.Character:FindFirstChildOfClass("Tool")
                                    if tool:FindFirstChild("Setting") then
                                        local lscript = getsenv(tool:FindFirstChild("GunScript_Local"))
                                        lscript.Fire_1(tool:FindFirstChild("GRIP"),{lplr.Character.HumanoidRootPart.CFrame.LookVector})
                                    end
                                end)
                            end)
                        else
                            NoRealoding = nil
                        end
                    end})
                    local mingunloop
                    gunmode:Toggle({Name = "Minigun",Value = false,Callback = function(val)
                        mingunloop= val
                        if val then
                           task.spawn(function()
                                while true do
                                    if mousedown then
                                        pcall(function()
                                            local tool = lplr.Character:FindFirstChildOfClass("Tool")
                                            if tool:FindFirstChild("Setting") then
                                                local lscript = getsenv(tool:FindFirstChild("GunScript_Local"))
                                                lscript.Fire_1(tool:FindFirstChild("GRIP"),{lplr.Character.HumanoidRootPart.CFrame.LookVector})
                                            end
                                        end)
                                        wait(.1)
                                        continue
                                    end
                                    if not mingunloop then break end
                                    loop:Wait()
                                end
                            end)
                        end
                    end})
                end
                local fe = Rage:Section({Name = "Backdoor Exploit",Side = "Right"})do
                    fe:Slider({Name = "Set Time Day",Max = 24, Min = 0, Value =12, Precise = 6,Callback = function(val)
                        Library.Time = val
                    end})
                    fe:Toggle({Name = "Enabled",Value = false,Callback = function(val)
                        Library.TimeEnabled = val
                        if val then
                            task.spawn(function()
                                while true do
                                    if not Library.TimeEnabled then break end;
                                    local args = {
                                        [1] = "Moved",
                                        [2] = lplr.Character.Head.Position,
                                        [3] = game:GetService("Lighting"),
                                        [4] = {
                                            ["ClockTime"] = Library.Time
                                        }
                                    }
                                    game:GetService("ReplicatedStorage"):WaitForChild("Container"):WaitForChild("FlashlightEvents"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
                                    loop:Wait()
                                end
                            end)
                        end 
                    end})
                    local loopnoplay
                    fe:Toggle({Name = "No Playing", Value = false, Callback = function(val)
                        loopnoplay = val
                        if val then
                            while true do
                                if not loopnoplay then
                                    local args = {
                                        [1] = "Moved",
                                        [2] = lplr.Character.Head.Position,
                                        [3] = workspace.Important["Spawning Gate"].Teleporter.SpawnPrompt,
                                        [4] = {
                                            ["CFrame"] = spawncframe
                                        }
                                    }
                                    game:GetService("ReplicatedStorage"):WaitForChild("Container"):WaitForChild("FlashlightEvents"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
                                    break
                                end
                                local args = {
                                    [1] = "Moved",
                                    [2] = lplr.Character.Head.Position,
                                    [3] = workspace.Important["Spawning Gate"].Teleporter,
                                    [4] = {
                                        ["Position"] = Vector3.new(-1000000,-1000000,-1000000)
                                    }
                                }
                                game:GetService("ReplicatedStorage"):WaitForChild("Container"):WaitForChild("FlashlightEvents"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
                                loop:Wait()
                            end
                        else
                            local args = {
                                [1] = "Moved",
                                [2] = lplr.Character.Head.Position,
                                [3] = workspace.Important["Spawning Gate"].Teleporter,
                                [4] = {
                                    ["CFrame"] = spawncframe
                                }
                            }
                        end
                    end}):ToolTip("Everyone not gonna play 😔.Toogling it on again will make everyone happi 😊")
                    fe:Label("Sound Trolling")
                    fe:DropDown({Name = "Sound List",List = {
                        {Name = "Shut Up(sfx)", Mode = "Button", Callback = function()
                            Library.SoundAssetId= "rbxassetid://2492364450"
                        end},
                        {Name = "Corn Dog(sfx)", Mode = "Button", Callback = function()
                            Library.SoundAssetId = "rbxassetid://5110030811"
                        end},
                        {Name = "Screaming(sfx)",Mode = "Button", Callback = function()
                            Library.SoundAssetId= "rbxassetid://7696491068"
                        end},
                        {Name = "FBI Open Up(sfx)", Mode = "Button", Callback = function()
                            Library.SoundAssetId = "rbxassetid://2525950283"
                        end},
                        {Name = "SCP Announcement(sfx)", Mode = "Button", Callback = function()
                            Library.SoundAssetId = "rbxassetid://9069029168"
                        end},
                        {Name = "Oh Yeah Mr Krabs(sfx)", Mode = "Button", Callback = function()
                            Library.SoundAssetId = "rbxassetid://273935922"
                        end},
                        {Name = "Mission Impossible(sfx made by roblox :pensive:)", Mode = "Button", Callback = function()
                            Library.SoundAssetId = "rbxassetid://9047965547"
                        end},
                        {Name = "Something Big Gonna Happened?(sfx)", Mode = "Button", Callback = function()
                            Library.SoundAssetId = "rbxassetid://1841714878"
                        end},
                        {Name ="Home Town Hear(song)", Mode = "Button", Callback = function()
                            Library.SoundAssetId = "rbxassetid://1848289380"
                        end},
                        {Name = "Summer Song(song)", Mode = "Button", Callback = function()
                            Library.SoundAssetId = "rbxassetid://1845736900"
                        end},
                        {Name = "Bed Chill Song(song)", Mode = "Button", Callback = function()
                            Library.SoundAssetId = "rbxassetid://9046862941"
                        end},
                    }})
                    fe:Slider({Name = "Client Volume", Value = 1, Min = 0, Max = 10, Callback = function(val)
                        Library.SoundVolumeClient = val
                    end}):ToolTip("This is volume set for you(client) to hear")
                    fe:Slider({Name = "Volume",Value = 2, Min = 0, Max = 10, Callback = function(val)
                        Library.SoundVolume = val
                    end}):ToolTip("This is volume set for everyone to hear")
                    fe:Toggle({Name = "Enabled", Value = false, Callback = function(val)
                        Library.SoundEnabled = val
                        if val then
                            Players.PlayerAdded:Connect(function(v)
                                task.spawn(function()
                                    while true do
                                        if not Library.SoundEnabled then break end;  
                                        local args = {
                                            [1] = {
                                                ["Pitch"] = 1,
                                                ["MaxDistance"] = 10000,
                                                ["Volume"] = Library.SoundVolume,
                                                ["Silenced"] = false,
                                                ["SoundId"] = Library.SoundAssetId,
                                                ["Origin"] = v.Character.HumanoidRootPart,
                                                ["Echo"] = true,
                                                ["EmitterSize"] = 40
                                            },
                                            [2] = {
                                                ["Pitch"] = 1,
                                                ["Origin"] = v.Character.HumanoidRootPart,
                                                ["CurrentAmmo"] = 7,
                                                ["AmmoPerMag"] = 8,
                                                ["Volume"] = Library.SoundVolume,
                                                ["SoundId"] = Library.SoundAssetId,
                                                ["MaxDistance"] = 10000,
                                                ["Enabled"] = true,
                                                ["EmitterSize"] = 10
                                            }
                                        }
                                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PlayAudio"):FireServer(unpack(args))
                                        AudioPlayer:Play()
                                        AudioPlayer.Stopped:Wait()
                                        loop:Wait()
                                    end
                                end)
                            end)
                            for i,v in pairs(Players:GetPlayers()) do
                                task.spawn(function()
                                    while true do
                                        if not Library.SoundEnabled then break end;
                                        AudioPlayer.Volume = Library.SoundVolume
                                        AudioPlayer.SoundId = Library.SoundVolumeClient
                                        local args = {
                                            [1] = {
                                                ["Pitch"] = 1,
                                                ["MaxDistance"] = 10000,
                                                ["Volume"] = 10,
                                                ["Silenced"] = false,
                                                ["SoundId"] = "rbxassetid://2492364450",
                                                ["Origin"] = v.Character.HumanoidRootPart,
                                                ["Echo"] = true,
                                                ["EmitterSize"] = 40
                                            },
                                            [2] = {
                                                ["Pitch"] = 1,
                                                ["Origin"] = v.Character.HumanoidRootPart,
                                                ["CurrentAmmo"] = 7,
                                                ["AmmoPerMag"] = 8,
                                                ["Volume"] = 10,
                                                ["SoundId"] = "rbxassetid://2492364450",
                                                ["MaxDistance"] = 10000,
                                                ["Enabled"] = true,
                                                ["EmitterSize"] = 10
                                            }
                                        }
                                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PlayAudio"):FireServer(unpack(args))
                                        AudioPlayer.Stopped:Wait()
                                        loop:Wait()
                                    end
                                end)
                            end
                        end
                    end})
                    fe:Toggle({Name = "Decal Exploit",Value = false, Calbback = function(val)
                        Library.DecalExploit = val
                        if val then
                            pcall(function()
                                local tool = lplr.Character:FindFirstChildOfClass("Tool")
                                if tool:FindFirstChild("Setting") then
                                    local lscript = getsenv(tool:FindFirstChild("GunScript_Local"))
                                    task.spawn(function()
                                        for i,v in pairs(workspace:GetChildren()) do
                                            if v:IsA("Part") or v:IsA("MeshPart") then
                                                task.spawn(function()
                                                    while true do
                                                        if not Library.DecalExploit then 
                                                            mod["BulletHoleTexture"][1] =2078626
                                                            break
                                                        end
                                                        lscript.Fire_1(tool:FindFirstChild("GRIP"),{lplr.Character.HumanoidRootPart.CFrame.LookVector})
                                                        loop:Wait()
                                                    end
                                                end)
                                            end
                                        end
                                    end)
                                end
                            end)
                        end
                    end})
                    --[[fe:Toggle({Name = "Decal Spam",Value = false, Calbback = function(val)  
                    end})
                    fe:Label("Sexual Backdoor Exploit")
                    fe:Toggle({Name = "Big Black Cock", Value = false,Callback = function(val)
                        Library.PenisEnabled = val
                        if val then
                            for i,v in pairs(workspace:GetDescendants()) do
                                if v:IsA("")then
                                    
                                end
                            end
                        end
                    end}):ToolTip("You will the only one who have this unless toggle 'everyone' to take effect on everyone")
                    fe:Toggle({Name = "Everyone", Value = false, Callback = function(val)
                        
                    end})]]
    
                end
                local exploit = Rage:Section({Name = "Exploit",Side ="Left"}) do
                    local earrapeloop 
                    exploit:Toggle({Name = "Ear Rape", Value = false, Callback = function(val)
                        earrapeloop = val
                        if val then
                            task.spawn(function()
                                while true do
                                    if not earrapeloop then break end;
                                    for i,v in pairs(Players:GetPlayers()) do
                                        if not earrapeloop then continue end;
                                        if v~= lplr then
                                            pcall(function()  
                                                
                                            end)
                                        end
                                    end
                                    if not earrapeloop then break end;
                                    wait(1)
                                end
                            end)
                        end
                    end})
                    local loopclientlagger
                    exploit:Toggle({Name = "Client Lagger", Value = false, Callback = function(val)
                        game:GetService("NetworkClient"):SetOutgoingKBPSLimit(10e10)
                        loopclientlagger = val
                        if val then
                            for i,v in pairs(Players:GetPlayers()) do
                                if v ~= lplr then 
                                    task.spawn(function()
                                        while true do
                                            if not loopclientlagger then break end;
                                            pcall(function()
                                                for i = 1,20,1 do
                                                    local args = {
                                                        [1] = 10e9,
                                                        [2] = 10e9,
                                                        [3] = 10e9
                                                    }
                                                    pcall(function()
                                                        v.Character:FindFirstChildOfClass("Tool").GunScript_Server.ChangeMagAndAmmo:FireServer(unpack(args))
                                                    end)
                                                    for index,key in pairs(v.Backpack:GetChildren()) do
                                                        pcall(function()
                                                            key.GunScript_Server.ChangeMagAndAmmo:FireServer(unpack(args))
                                                        end)
                                                    end
                                                end
                                            end)
                                            loop:Wait()
                                        end
                                    end)
                                end
                            end
                        end
                    end})
                    local looplagspike
                    exploit:Toggle({Name = "Lag Spike", Value = false, Callback = function(val)
                        game:GetService("NetworkClient"):SetOutgoingKBPSLimit(10e10)
                        looplagspike = val
                        if val then
                            task.spawn(function()
                                while true do
                                    if not looplagspike then break end;
                                    for i = 1,10,1 do
                                        task.spawn(function()
                                            local args = {
                                                [1] = string.rep("Buy LunaCrpt.lua",12)
                                            }
                                            game:GetService("ReplicatedStorage"):WaitForChild("Container"):WaitForChild("MarketplaceItemEvent"):InvokeServer(unpack(args))
                                            
                                        end)
                                    end
                                    loop:Wait()
                                end
                            end)
                        end
                    end})
            end
        end
    end
    --rbxassetid://8598068650
    local args = {
        [1] = "Moved",
        [2] = Vector3.new(6023.82763671875, 17.951801300048828, 1175.643798828125),
        [3] = game:GetService("Workspace").K149967NisseIlene.M1911.K1911.Barrel,
        [4] = {
            ["Size"] = Vector3.new(1000000000, 1000000000, 1000000000)
        }
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("Container"):WaitForChild("FlashlightEvents"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end
