assert(readfile,"You need atleast readfile to use this script my god")
getgenv().Players = game:GetService'Players'
getgenv().TeleportService = game:GetService'TeleportService'
getgenv().ReplicatedStorage = game:GetService'ReplicatedStorage' 
getgenv().StarterGui = game:GetService'StarterGui'
getgenv().TweenService = game:GetService'TweenService'
getgenv().UserInput = game:GetService'UserInputService'
getgenv().RunService = game:GetService'RunService'
getgenv().Lighting = game:GetService'Lighting'
getgenv().CoreGui = game:GetService'CoreGui'
getgenv().HttpService = game:GetService'HttpService'
getgenv().MarketplaceService = game:GetService'MarketplaceService'
getgenv().LP = Players.LocalPlayer or Players.PlayerAdded:Wait()
getgenv().Mouse = LP:GetMouse()
getgenv().GetChar = function() return LP.Character or LP.CharacterAdded:Wait() end
GetChar():WaitForChild('Humanoid',10) -- allows auto-execution
local PlayerTable,Commands,KeyTable,UrlEncoder = {},{},{['w'] = false;['a'] = false;['s'] = false;['d'] = false;['Shift'] = false;['Control'] = false;},{['0'] = "%30";['1'] = "%31";['2'] = "%32";['3'] = "%33"; ['4'] = "%34";['5'] = "%35";['6'] = "%36";['7'] = "%37";['8'] = "%38";['9'] = "%39";[' '] = "%20";}
local NormalWS,NormalJP,NormalHH = GetChar().Humanoid.WalkSpeed,GetChar().Humanoid.JumpPower,GetChar().Humanoid.HipHeight
local AimLock,GodMode,AutoDie,AliasesEnabled,Noclipping,AutoFarm,ItemEsp,WalkShoot,flying,AutoStomp = false,false,false,true,false,false,false,false,false,false
local BlinkSpeed,SpawnWS,SpawnJP,SpawnHH,SpawnSprint,SpawnCrouch,ClockTime,PlayOnDeath,AimlockTarget
local AirWalk = Instance.new'Part'
local Cframe = Instance.new("Frame",CoreGui.RobloxGui)
local CText,CmdFrame,MainFrame,DmgIndicator = Instance.new("TextBox",Cframe),Instance.new("Frame",Cframe),Instance.new('Frame',CoreGui.RobloxGui),Instance.new('TextLabel',LP.PlayerGui.Chat.Frame)
local ScrollingFrame,SearchBar,Credits = Instance.new('ScrollingFrame',MainFrame),Instance.new('TextBox',MainFrame),Instance.new('TextLabel',MainFrame)
local BulletColour,ItemEspColour,EspColour = ColorSequence.new(Color3.new(144,0,0)),Color3.fromRGB(200,200,200),Color3.fromRGB(200,200,200)
local ShiftSpeed,ControlSpeed,WalkSpeed = 25,8,16
local UseDraw,DrawingT = pcall(assert,Drawing,'test')

if UseDraw then 
	DrawingT = Drawing.new'Text'
	DrawingT.Visible = true
	DrawingT.Center = true 
	DrawingT.Size = 15
	DrawingT.Position = Vector2.new((workspace.CurrentCamera.ViewportSize.X / 2) - 450, (workspace.CurrentCamera.ViewportSize.Y - 125))
	DrawingT.Color = Color3.new(144,144,144)
	DrawingT.Text = "Current WalkSpeed: "..GetChar().Humanoid.WalkSpeed.."\nSprinting Speed: "..ShiftSpeed.."\nCrouching Speed: "..ControlSpeed.."\nJumpPower: "..GetChar().Humanoid.JumpPower.."\nFlying: "..tostring(flying).."\nNoclipping: "..tostring(Noclipping).."\nAimlock Target: "..tostring(AimlockTarget)
end 

if workspace:FindFirstChild'Armoured Truck' then
	PartTable = {
		['Burger'] = workspace:FindFirstChild'Burger | $15';
		['Drink'] = workspace:FindFirstChild'Drink | $15';
		['Ammo'] = workspace:FindFirstChild'Buy Ammo | $25';
		['Pipe'] = workspace:FindFirstChild'Pipe | $100';
		['Machete'] = workspace:FindFirstChild'Machete | $70';
		['SawedOff'] = workspace:FindFirstChild'Sawed Off | $150';
		['Spray'] = workspace:FindFirstChild'Spray | $20';
		['Uzi'] = workspace:FindFirstChild'Uzi | $150';
		['Glock'] = workspace:FindFirstChild'Glock | $200';
	}
    workspace["Armoured Truck"]:Destroy()
elseif workspace:FindFirstChild'TPer' then 
    workspace['TPer']:Destroy()
end

LP.PlayerGui.Chat.Frame.ChatChannelParentFrame.Visible = true
LP.PlayerGui.Chat.Frame.ChatBarParentFrame.Position = LP.PlayerGui.Chat.Frame.ChatChannelParentFrame.Position + UDim2.new(UDim.new(),LP.PlayerGui.Chat.Frame.ChatChannelParentFrame.Size.Y)
--^ Ty to Jayy#0648 for this "Hack" for bringing back normal chat 
local SettingsTable = {
   Keys = {};
   ClickTpKey = "";
}

-- Hotkey start

local function savesettings()
    writefile("CyrusStreetsAdminSettings",HttpService:JSONEncode(SettingsTable))
    local SettingsToSave = HttpService:JSONDecode(readfile("CyrusStreetsAdminSettings"))
    Keys = SettingsToSave.Keys
    ClickTpKey = SettingsToSave.ClickTpKey
end 

getgenv().updateSettings = function()
    local New = { 
        Keys = Keys;
		ClickTpKey = ClickTpKey;
    }
    writefile("CyrusStreetsAdminSettings",HttpService:JSONEncode(New))
end

local function runsettings()
    local SettingsToRun = HttpService:JSONDecode(readfile("CyrusStreetsAdminSettings"))
    Keys = SettingsToRun.Keys
    ClickTpKey = SettingsToRun.ClickTpKey
end

local Work,Error = pcall(readfile,"CyrusStreetsAdminSettings")

if not Work then 
    savesettings()
else
    runsettings()
end

-- Hotkey end 

-- Bypass Start

local gamememe = getrawmetatable or getmetatable or debug.getmetatable
gamememe = gamememe(game) -- did this for exploits that can't index nil values (Calamari for example/see setreadonly aswell)
local Closure,Caller = hide_me or newcclosure or function(Function) return Function end,checkcaller or is_protosmasher_caller or Cer.isCerus
local name,index,nindex = gamememe.__namecall,gamememe.__index,gamememe.__newindex

if setreadonly then
	setreadonly(gamememe,false)
elseif make_writeable then -- had to switch this for sentinel support since it can't index nil values (SAME WITH CALAMARI)
	make_writeable(gamememe)
end 

gamememe.__newindex = Closure(function(self,Property,b)
	if not Caller() then
		if self == GetChar():WaitForChild('Humanoid',10) then 
			StarterGui:SetCore('ResetButtonCallback',true)
			if Property == "WalkSpeed" then 
				if WalkShoot then 
					return 
				end 
			end 
			if Property == "Health" or Property == "JumpPower" or Property == "HipHeight" then 
				return 
			end
		end
		if Property == "CFrame" and self.Name == "HumanoidRootPart" or self.Name == "Torso" then
	       	return 
	    end
	end
	return nindex(self,Property,b)
end)

gamememe.__namecall = Closure(function(self,...)
	if not Caller() then
		local Arguments = {...}
		if getnamecallmethod() == "Destroy" then 
	       	if tostring(self) == 'BodyGyro' or tostring(self) == 'BodyVelocity' then
				return invalidfunctiongang(self,...)
			end 
		end
		if getnamecallmethod() == "BreakJoints" and self == GetChar() then
			return invalidfunctiongang(self,...)
		end
		if getnamecallmethod() == "FireServer" then 
	    	if self.Name == "lIII" or tostring(self.Parent) == "ReplicatedStorage" then 
				return wait(9e9)
			end
			if Arguments[1] == "hey" then 
					return wait(9e9)
				end
			end
			if Arguments[1] == "play" then
			local TempTable = {}
			tostring(Arguments[2]):gsub('.',function(Char)
					if UrlEncoder[Char] then 
						table.insert(TempTable,UrlEncoder[Char])
					else 
					table.insert(TempTable,Char)
				end
			end)
			Arguments[2] = table.concat(TempTable,"")
			PlayOnDeath = Arguments[2]
			return name(self,unpack(Arguments))
		end
		if Arguments[1] == "stop" then 
			PlayOnDeath = nil 
		end
		if tostring(self.Name) == "Fire" and AimlockTarget and AimLock then
			return name(self,AimlockTarget.Head.CFrame + AimlockTarget.Torso.Velocity / 5)
		end
	end
	return name(self,...)
end)

-- Bypass End

getgenv().notif = function(title,message,length,icon)
	StarterGui:SetCore("SendNotification",{['Title'] = title;['Text'] = message;['Duration'] = length;['Icon'] = icon;})
end

getgenv().Teleport = function(Part)
if not type(Part) == "CFrame" then return end 
if not GetChar():FindFirstChild'HumanoidRootPart' then 
	notif("STOP USING AIDEZ YOU STUPID NIGGER","fuck you!",5,"rbxassetid://1281284684") 
	return 
end 
	if _G.DoYouHaveBfgBypass then 
		GetChar().HumanoidRootPart.CFrame = Part
	else
		local Play = TweenService:Create(GetChar().HumanoidRootPart, TweenInfo.new(3.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),{CFrame = Part})
		Play:play()
	end
end

local function UziStats()
	local Child = LP.PlayerGui:GetChildren()
	local UziAmount,ClipsAmount,AmmoAmount,Damage = 0,0,0,0
	for i = 1,#Child do
		if Child[i].Name == "Uzi" and Child[i].Clips and Child[i].Ammo then 
			UziAmount = UziAmount + 1 
			ClipsAmount = ClipsAmount + Child[i].Clips.Value
			AmmoAmount = AmmoAmount + Child[i].Ammo.Value
		end
	end 
	local ZetoxUzi = LP.Backpack:FindFirstChild'Zetox Uzi' or GetChar():FindFirstChild'Zetox Uzi'
	ZetoxUzi.ToolTip = "Zetox Uzi | Clips "..tostring(ClipsAmount / UziAmount).." | Damage "..tostring(UziAmount * 20).." | Ammo "..tostring(AmmoAmount / UziAmount).." | Uzi Amount "..tostring(UziAmount)
end

local function hasItem(Player,Item)
    if type(Item) == "boolean" then
        local Tool = Player.Character:FindFirstChildOfClass'Tool'
        if Tool then 
            return Tool.Name
        else
            return 'none'
        end
    end
    if Player.Backpack:FindFirstChild(Item) or Player.Character:FindFirstChild(Item) then
        return 'yes' 
    else
        return 'no'
    end
end 

local function LegacyEsp(Player)
if not Player.Character or not Player.Character:FindFirstChild'Head' then return end 
	local Esp1 = Instance.new("BillboardGui",Player.Character)
	local Text = Instance.new("TextLabel",Esp1)
	Esp1.Adornee = Player.Character.Head
	Esp1.Name = "[ESP]"..Player.Name
	Esp1.Size = UDim2.new(0,100,0,100)
	Esp1.StudsOffset = Vector3.new(0,1,0)
	Esp1.AlwaysOnTop = true
	Text.BackgroundTransparency = 1
	Text.Position = UDim2.new(0,0,0,0)
	Text.Size = UDim2.new(1,0,0,40)
	Text.TextStrokeTransparency = 0.5
	Text.TextSize = 15
	local PCChild = Player.Character:GetChildren()
	RunService.Stepped:Connect(function()
		pcall(function()
			if Player.Character:FindFirstChild'Head' and GetChar():FindFirstChild'Head' then 
				Text.Text = Player.Name.." Position: "..math.floor((GetChar().Head.Position - Player.Character.Head.Position).magnitude)
				Text.TextStrokeColor3 = EspColour
				Text.TextColor3 = EspColour
			end
		end)
	end)
	return Esp1
end 

local EspTable = {} 
local function espPlayer(Player,Method)
if not Player.Character or not Player.Character:FindFirstChild'Head' then return end
	if not UseDraw or Method == "Legacy" then
		local Esp1 = LegacyEsp(Player)
		local CAdded;
		CAdded = Player.CharacterAdded:Connect(function(C)
			if table.find(EspTable,Player.UserId) then 
				C:WaitForChild('Head',10)
				Esp1 = LegacyEsp(Player)
			else 
				CAdded:Disconnect()
			end
		end)
	else 
		local RelativePos = workspace.CurrentCamera:WorldToViewportPoint(Player.Character.Head.Position)
		local Square,Text = Drawing.new'Square',Drawing.new'Text'
		Square.Position = Vector2.new(RelativePos.X, RelativePos.Y)
		Square.Size = Vector2.new(5,5)
		Square.Visible = true
		Square.Filled = true
		Square.Color = Color3.new(125,0,0)
		Text.Position = Square.Position + Vector2.new(0,10)
		Text.Visible = true
		PlayerTable[#PlayerTable + 1] = {Square,Player,Text}
	end 
end

local function GrabThing(Thing)
if not PartTable then 
	notif("Can't tp to "..Thing,"as you are not playing normal streets!",5,"rbxassetid://1281284684") return 
end 
local Anim = Instance.new'Animation'
Anim.AnimationId = "rbxassetid://188632011"
local Track = GetChar().Humanoid:LoadAnimation(Anim)
GetChar().HumanoidRootPart.CFrame = GetChar().HumanoidRootPart.CFrame * CFrame.new(math.random(20,45),0,math.random(1,5))
wait()
	repeat  
		Track:play(.1,1,1)
		GetChar().HumanoidRootPart.CFrame = PartTable[Thing]:FindFirstChildOfClass'Part'.CFrame + Vector3.new(0,0.5,0)
		game:GetService'RunService'.Heartbeat:wait()
	until PartTable[Thing]:FindFirstChildOfClass'Part'.BrickColor == BrickColor.new'Bright red' or GetChar():FindFirstChild'KO' or GetChar().Humanoid.Health == 0
	return true
end 

getgenv().FireGun = function(Tool)
	if AimlockTarget and AimLock then
		Tool.Fire:FireServer(AimlockTarget.Head.CFrame + AimlockTarget.Torso.Velocity/5)
	else
		Tool.Fire:FireServer(Mouse.Hit)
	end
end

local OnlyAimLock,AimDebounce,LoopAimLock = false,false,false 
local function Button1Down()
local MTarget = Mouse.Target
	if GetChar():FindFirstChild'Zetox Btools' then 
		Mouse.Target:Destroy()
	end
	if BfgOn and GetChar():FindFirstChild'Uzi' then
		local BChild = LP.Backpack:GetChildren()
		for i = 1,#BChild do 
			if BChild[i].Name == "Uzi" then 
				BChild[i].Parent = GetChar()
				FireGun(BChild[i])
				if MinigunMode then wait() end 
			end
		end
	end
	if NormalBfg then 
		local CChild = GetChar():GetChildren()
		for i = 1,#CChild do 
			if CChild[i]:FindFirstChild'Fire' then 
				FireGun(CChild[i])
				if MinigunMode then wait() end 
			end
		end
	end
	if MultiUzi and GetChar():FindFirstChild'Zetox Uzi' then
		local PChild = LP.PlayerGui:GetChildren()
		for i = 1,#PChild do 
			if PChild[i].Name == "Uzi" then 
				PChild[i].Grip = CFrame.new(0,0,-6)
				PChild[i].Parent = LP.Backpack
				PChild[i].Parent = GetChar()
				FireGun(PChild[i])
				UziStats()
				PChild[i].Parent = LP.PlayerGui
				if MinigunMode then wait() end 
			end
		end
	end
	local Player = Players:GetPlayerFromCharacter(MTarget.Parent) or Players:GetPlayerFromCharacter(MTarget.Parent.Parent)
	if Mouse.Target and Player and Player.Character and Player.Character:FindFirstChild'Humanoid' and AimLock and not OnlyAimLock and not AimDebounce then 
		AimDebounce = true 
		AimlockTarget = Player.Character
		Player.CharacterRemoving:Connect(function()
			if not LoopAimLock then 
				AimlockTarget = nil
				OnlyAimLock = false
			end
		end)
		AimlockTarget.ChildAdded:Connect(function(T)
			if T.Name == "KO" and not LoopAimLock and AimlockTarget.Name == T.Parent.Name then
				AimlockTarget = nil
				OnlyAimLock = false 
			end
		end)
		A = Player.CharacterAdded:Connect(function(a)
			if AimlockTarget.Name == Player.Name then 
				AimlockTarget = a
			else 
				A:Disconnect()
			end
		end)
		notif("AimlockTarget","has been set to "..AimlockTarget.Name,5,"rbxassetid://1281284684")
		wait(3)
		AimDebounce = false 
	end
end

local function Button2Down()
if Mouse.Target then 
	local Target = Mouse.Target.Parent 
	if Target:FindFirstChild'Lock' and Target:FindFirstChild'Click' and Target:FindFirstChild'Locker' then 
		if Target.Locker.Value then 
				Target.Lock.ClickDetector:FindFirstChildOfClass'RemoteEvent':FireServer()
				Target.Click.ClickDetector:FindFirstChildOfClass'RemoteEvent':FireServer()
			else
				Target.Click.ClickDetector:FindFirstChildOfClass'RemoteEvent':FireServer()
				Target.Lock.ClickDetector:FindFirstChildOfClass'RemoteEvent':FireServer()
			end
		end
	end
end

local function b(Text)
	DmgIndicator.Visible = true 
	DmgIndicator.Text = Text
	wait(5)
	DmgIndicator.Text = "" 
	DmgIndicator.Visible = false 
end 

local function Char(Plr)
local Tool = Plr:FindFirstChildOfClass'Tool'
	if Tool:FindFirstChild'Fire' then 
		return 'shot you',Tool
	else 
		return 'hit you',Tool
	end
end 

local function ColourChanger(T)
	if T:IsA'Trail' then
		T.Color = BulletColour
	end
	if T:IsA'ObjectValue' and T.Name == "creator" and not Debounce then
		local Thing = T.Value
		local Method,Tool = Char(Thing)
        b(Thing.Name.." has "..Method.." from "..math.floor((GetChar().Head.Position - Thing.Head.Position).magnitude).." studs with a "..Tool.Name)
		if Tool.Name == "Shotty" then 
			Debounce = true 
			wait(0.7)
			Debounce = false 
		end 
	end
end

getgenv().AddCommand = function(CommandF,Name,Alias,Help)
	Commands[#Commands + 1] = {['Function'] = CommandF,['Name'] = Name,['Alias'] = Alias,['Help'] = Help}
end

getgenv().FindCommand = function(Command,Help)
	for i = 1,#Commands do 
		if Commands[i].Name:lower() == Command or AliasesEnabled and table.find(Commands[i].Alias,Command) then
			return Help and Commands[i].Name.." "..Commands[i].Help or Commands[i].Function
		end
	end
end

getgenv().CheckCommand = function(Chat)
	local Arguments = string.split(Chat," ")
	local NCommand = FindCommand(table.remove(Arguments,1):lower())
	if NCommand then 
		local Work,Error = pcall(NCommand,Arguments)
		if not Work then 
			wait(0.5)
			ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("There was an error with this command, I have set it to your clipboard. Send it to Cy (with the command you used) and it should be fixed next update.","All")
			if setclipboard then 
				setclipboard(Error)
			else 
				print(Error)
			end
		end
	end
end

getgenv().PlrFinder = function(Plr)
local NewPlr,Player = Plr:lower(),Players:GetPlayers()
if #NewPlr == 2 and NewPlr == "me" then return LP end 
if NewPlr == "all" then return Player end 
	for i = 1,#Player do 
		if Player[i].Name:lower():sub(1,#NewPlr) == NewPlr then 
			return Player[i]
		end
	end
end

local function Style(Style,Amount)
local CChild,BChild = GetChar():GetChildren(),LP.Backpack:GetChildren()
for i = 1,#CChild do if CChild[i]:IsA'Tool' then CChild[i].Parent = LP.Backpack end end 
	for i = 1,#BChild do
		if Style == "void" then
			Amount = Amount or 0.6
			BChild[i].Grip = CFrame.Angles(0,0.6,Amount * i)
		elseif Style == "shield1" then 
			BChild[i].Grip = CFrame.Angles(1 * i,1.5,0)
		elseif Style == "wormhole" then 
			BChild[i].Grip = CFrame.Angles(5,50*i,0) + Vector3.new(0,0,0.6)
		elseif Style == "circle" then
			Amount = Amount or 100
			BChild[i].Grip = CFrame.Angles(30,Amount*i,0) + Vector3.new(10,0.5,0.6)
		elseif Style == "sphere" then 
			BChild[i].Grip = CFrame.Angles(5*i,2*i,7*i) + Vector3.new(0,5,0)
		elseif Style == "storm" then 
			BChild[i].Grip = CFrame.Angles(5*i,2040/i,2*i/i*10)
		elseif Style == "shield2" then 
			BChild[i].Grip = CFrame.Angles(5,200*i,2*i)
		elseif Style == "deathcircle" then 
			BChild[i].Grip = CFrame.Angles(0.1/i*i,200*i,0) + Vector3.new(0,0,5)
		end 
	end 
end

local JustDoubleJumped = false 
local function HumanoidState(Old,New)
	if New == Enum.HumanoidStateType.Landed and JustDoubleJumped then 
		local Anim = Instance.new'Animation'
		Anim.AnimationId = "rbxassetid://129423030" 
		local AnimTrack = GetChar().Humanoid:LoadAnimation(Anim)
		wait(0.3)
		AnimTrack:play()
		JustDoubleJumped = false
	elseif New == Enum.HumanoidStateType.FallingDown or New == Enum.HumanoidStateType.PlatformStanding and NoGh or flying then
      	GetChar().Humanoid.PlatformStand = false
     	GetChar().Humanoid.Sit = false
		GetChar().Humanoid:ChangeState(10)
  	end
end

local function DoubleJump()
	if GetChar() and GetChar().Humanoid and DoubleJumpEnabled then
	    GetChar().Humanoid:ChangeState(3)
	    local Anim = Instance.new'Animation'
	    Anim.AnimationId = "rbxassetid://229782914"
	    local AnimTrack = GetChar().Humanoid:LoadAnimation(Anim)
	    AnimTrack:play(.1,1,1.5)
		JustDoubleJumped = true
	end
end

getgenv().find = function(Item)
  for i,v in pairs(workspace:GetChildren()) do 
      if v.Name == "RandomSpawner" and v:FindFirstChild'Model' then
      local Handle = v.Model.Handle
        if Item == "Cash" and Handle:FindFirstChildOfClass'MeshPart' and string.find(Handle:FindFirstChildOfClass'MeshPart'.MeshId,"511726060") then
          return v
        elseif Item == "Shotty" and Handle:FindFirstChild'Fire' and string.find(Handle.Fire.SoundId,"142383762") then 
          return v
        elseif Item == "Sawed Off" and Handle:FindFirstChild'Fire' and string.find(Handle.Fire.SoundId,"219397110") then 
          return v 
        elseif Item == "Uzi" and Handle:FindFirstChild'Fire' and string.find(Handle.Fire.SoundId,"328964620") then 
          return v 
        elseif Item == "All" then 
          return v
      end
    end
  end
end

local function uselessfunction(Thing)
if not Thing:FindFirstChild'Model' then return end 
local Handle = Thing.Model.Handle
	if Handle:FindFirstChildOfClass'MeshPart' and string.find(Handle:FindFirstChildOfClass'MeshPart'.MeshId,"511726060") then
		return "Cash"
	elseif Handle:FindFirstChild'Fire' and string.find(Handle.Fire.SoundId,"142383762") then 
		return "Shotty"
	elseif Handle:FindFirstChild'Fire' and string.find(Handle.Fire.SoundId,"219397110") then 
		return "Sawed Off"
	elseif Handle:FindFirstChild'Fire' and string.find(Handle.Fire.SoundId,"328964620") then 
		return "Uzi"
	end
end

local function addBillBoardGui(Item)
	local Itemx = uselessfunction(Item)
	if not Itemx then return end 
	local Esp1 = Instance.new("BillboardGui",Item)
	local Text = Instance.new("TextLabel",Esp1)
	Esp1.Adornee = Item
	Esp1.Name = "ItemEsp"..Itemx
	Esp1.Size = UDim2.new(0,100,0,100)
	Esp1.StudsOffset = Vector3.new(0,1,0)
	Esp1.AlwaysOnTop = true
	Text.BackgroundTransparency = 1
	Text.Position = UDim2.new(0,0,0,0)
	Text.Size = UDim2.new(1,0,0,40)
	Text.TextColor3 = ItemEspColour
	Text.TextStrokeTransparency = 0.5
	Text.TextSize = 15
	Text.TextStrokeColor3 = ItemEspColour
	Text.Text = Itemx
end 	

workspace.ChildAdded:Connect(function(Part)
	if Part.Name == "RandomSpawner" then
		if AutoFarm then 
			farm("Cash")
		end
		if ItemEsp then 
			addBillBoardGui(Part)
		end
	end
end)


getgenv().farm = function(Item)
  for i,v in pairs(workspace:GetChildren()) do 
	if v.Name == "RandomSpawner" then 
		if find(Item) and type(find(Item)) == "userdata" then 
			Teleport(find(Item).CFrame)
			if not _G.DoYouHaveBfgBypass then 
				wait(3)
			else 
				wait()
			end
		else 
			notif("Farm "..Item,"None of "..Item.." on the map",5,"rbxassetid://1281284684")
			break;
	   	end
      end
   end
end

local UziDebounce = false 
local function MultiUzireload(Part)
	if Part.Parent.Name == "Buy Ammo | $25" and GetChar():FindFirstChild'Zetox Uzi' and LP.PlayerGui:FindFirstChild'Uzi' and not UziDebounce then
		local ActualUzi,LowestAmmo,Child,UziDebounce = nil,math.huge,LP.PlayerGui:GetChildren(),true
		for i = 1,#Child do 
			if Child[i].Name == "Uzi" and Child[i].Clips and Child[i].Clips.Value < LowestAmmo then 
				LowestAmmo = Child[i].Clips.Value 
				ActualUzi = Child[i]
			end
		end
		ActualUzi.Parent = LP.Backpack
		ActualUzi.Parent = GetChar()
		repeat wait() until Part.BrickColor == BrickColor.new'Bright red'
		ActualUzi.Parent = LP.PlayerGui
		UziDebounce = false 
	end
end

AddCommand(function()
	AliasesEnabled = not AliasesEnabled
end,"usealias",{},"Turns on / off Aliases")

AddCommand(function(Arguments)
	MainFrame.Visible = not MainFrame.Visible 
end,"help",{"commands","cmds"},"Gives you the commands help info")

AddCommand(function()
	local Btool = Instance.new('Tool',LP.Backpack)
	Btool.Name = "Zetox Btools" 
end,"btools",{},"Gives you Btools")

AddCommand(function()
	local Children = LP.PlayerGui.HUD:GetChildren()
	for i = 1,#Children do
		if Children[i]:IsA'Frame' then 
			Children[i].Active = not Children[i].Active 
			Children[i].Draggable = not Children[i].Draggable
		end
	end
end,"draggablegui",{},"Makes the HP/KO/Stamina bar draggable")

AddCommand(function()
	NoGh = not NoGh
	notif("Nogh","Has been set to "..tostring(NoGh),5,nil) 
end,"nogroundhit",{"nogh","antigh","antigroundhit"},"Makes it so you can't be ground hit")

AddCommand(function()
	GodMode = not GodMode
	GetChar():BreakJoints()
end,"godmode",{"god"},"Gods your player (Breaks tools)")

AddCommand(function(Arguments)
	local Tool = GetChar():FindFirstChildOfClass'Tool'
    if Tool then
        Tool.Parent = LP.Backpack
        Tool.Grip = CFrame.new(Arguments[1] or 0,Arguments[2] or 0,Arguments[3] or 0) + Vector3.new(Arguments[4] or 0,Arguments[5] or 0,Arguments[6] or 0)
        Tool.Parent = GetChar()
    else 
        notif("NO TOOLS","ONE TOOL IS NEEDED",5,nil)
    end
end,"grippos",{"grip"},"[1 2 3 4 5 6] - changes grip pos to the arguments you set (First 3 are CFrame,last 3 are Vector)")

AddCommand(function(Arguments)
local GDesc = game:GetDescendants()
	for i = 1,Arguments[1] or 50 do 
		for i = 1,#GDesc do 
			if GDesc[i]:IsA'Tool' and GDesc[i]:FindFirstChild'Click' then 
				GDesc[i].Click:FireServer()
				wait()
			end
		end
	end
end,"spamclick",{},"spams the Click remote and makes annoying sounds")

AddCommand(function()
local WChild = workspace:GetChildren()
	for i = 1,#WChild do 
		if WChild[i].Name == "Door" and WChild[i]:FindFirstChild'Click' and WChild[i]:FindFirstChild'Lock' then
			WChild[i].Lock.ClickDetector:FindFirstChildOfClass'RemoteEvent':FireServer()
			WChild[i].Click.ClickDetector:FindFirstChildOfClass'RemoteEvent':FireServer()
			wait()
		end
	end
end,"doors",{},"locks/unlocks doors")

local SpamDelay,SpamMessage,Spamming = 1,"Cyrus' Admin Or No Admin",false 
AddCommand(function(Arguments)
	if Arguments[1] then 
		SpamMessage = table.concat(Arguments," ")
	end 
	Spamming = not Spamming 
end,"spam",{},"Spams a message you set")

AddCommand(function(Arguments)
	SpamDelay = Arguments[1] or 1 
end,"spamdelay",{},"Delays the spam for [amount] Default: 1 second")

AddCommand(function()
local GDesc = game:GetDescendants()
	for i = 1,10 do 
		for i = 1,#GDesc do 
			if GDesc[i]:IsA'Tool' and GDesc[i]:FindFirstChild'Click' then 
				GDesc[i].Click:FireServer()
			end
		end
	end
end,"muteallradios",{"muteradios"},"Mutes all radios (does not loop)")

AddCommand(function(Arguments)
	Normalwalk = true
	WalkShoot = true 
	GetChar().Humanoid.WalkSpeed = Arguments[1]
	WalkSpeed = Arguments[1]
end,"speed",{"ws"},"Changes your Humanoids WalkSpeed")

AddCommand(function()
	WalkShoot = not WalkShoot
end,"walkshoot",{},"Allows you to turn on / off walk shooting")

AddCommand(function(Arguments)
	Normalwalk = false
	ControlSpeed = Arguments[1]
end,"crouchspeed",{"cspeed"},"Changes your Crouching speed")

AddCommand(function(Arguments)
	Normalwalk = false
	ShiftSpeed = Arguments[1]
end,"sprintspeed",{"sspeed"},"Changes your sprinting speed")

AddCommand(function(Arguments)
	GetChar().Humanoid.HipHeight = Arguments[1]
end,"hipheight",{"hh"},"Changes your Humanoids HipHeight")

AddCommand(function(Arguments)
	GetChar().Humanoid.JumpPower = Arguments[1]
end,"jumppower",{"jp"},"Changes your Humanoids JumpPower")

AddCommand(function(Arguments)
	if not Arguments[1] then 
		TeleportService:TeleportToPlaceInstance(game.PlaceId,game.JobId)
	end
end,"rejoin",{"rj"},"Rejoins your CURRENT game server")

AddCommand(function(Arguments)
	if not Arguments[1] then 
		GetChar():BreakJoints()
	end
end,"reset",{"re"},"SUICIDE IS PAINLESS IT BRINGS ON MANY CHANGES")

AirWalk.Anchored = true 
AirWalk.Size = Vector3.new(5,1,5)
AirWalk.Transparency = 1 
AirWalk.Material = "Neon"
AddCommand(function(Arguments)
	AirWalkOn = not AirWalkOn 
	AirWalk.Parent = AirWalkOn and workspace or not AirWalkOn and nil 
end,"airwalk",{},"Allows you to float in the air")

local NeverSitting = false 
AddCommand(function()
NeverSitting = not NeverSitting
	if NeverSitting then
		local toParent = workspace:GetDescendants()
		for i = 1,#toParent do 
			if toParent[i]:IsA'Seat' then 
				toParent[i].Parent = CoreGui
			end
		end
	else
		local toParent = CoreGui:GetChildren()
		for i = 1,#toParent do 
			if toParent[i]:IsA'Seat' then 
				toParent[i].Parent = workspace
			end
		end
	end
end,"neversit",{"nsit"},"Never sit")

AddCommand(function()
	AutoDie = not AutoDie
end,"autodie",{"autoreset"},"When Ko'ed auto kills you")

AddCommand(function()
	Noclipping = not Noclipping
	notif("Command: Noclip: on","Noclip has been set to "..tostring(Noclipping),5,"rbxassetid://1281284684")
end,"noclip",{},"Allows you to walk through walls")

AddCommand(function(Arguments)
	local Player = PlrFinder(Arguments[1])
	if Player and Player.Character and Player.Character:FindFirstChild'Head' and Player ~= LP then 
		Teleport(Player.Character.Head.CFrame)
	end 
end,"goto",{"to"},"Teleports you to the selected player")

AddCommand(function(Arguments)
	if Arguments[1] and tonumber(Arguments[1]) then 
		ClockTime = Arguments[1]
	end
end,"time",{},"Changes the time to the number you set")

AddCommand(function(Arguments)
	Blinking = not Blinking
	if Blinking then 
		BlinkSpeed = Arguments[1] or 3
	end 
end,"blink",{"blinkspeed"},"Another form of speed, Uses CFrame")

AddCommand(function(Arguments)
	if Arguments[1] then
		Arguments[1] = Arguments[1]:lower()
		if Arguments[1] == "banland" then 
			TeleportService:Teleport(4669040)
		elseif Arguments[1] == "normalstreets" then 
			TeleportService:Teleport(455366377)
		elseif Arguments[1] == "uzi" then 
			GrabThing("Uzi")
		elseif Arguments[1] == "machete" then 
			GrabThing("Machete")
		elseif Arguments[1] == "spray" then 
			GrabThing("Spray")
		elseif Arguments[1] == "sawed" or Arguments[1] == "sawedoff" then 
			GrabThing("SawedOff")
		elseif Arguments[1] == "pipe" then 
			GrabThing("Pipe")
		elseif Arguments[1] == "glock" then 
			GrabThing("Glock")
		elseif PartTable and Arguments[1] == "sand" or Arguments[1] == "sandbox" then
			Teleport(CFrame.new(-178.60614013672,3.2000000476837,-117.21733093262))
		elseif PartTable and Arguments[1] == "prison" or Arguments[1] == "jail" or Arguments[1] == "whereblacksgoaftertheyattempttorobsaidbank" then 
			Teleport(CFrame.new(-978.74725341797,3.199854850769,-78.541763305664))
		elseif PartTable and Arguments[1] == "gas" or Arguments[1] == "gasstation" then 
			Teleport(CFrame.new(99.135276794434,18.599975585938,-73.462348937988))
		elseif PartTable and Arguments[1] == "court" or Arguments[1] == "basketballcourt" then 
			Teleport(CFrame.new( -191.56864929199,3,223.43171691895))
		elseif PartTable and Arguments[1] == "beach" then 
			Teleport(CFrame.new(-663.97521972656,1.8657279014587,-369.04748535156))
		elseif PartTable and Arguments[1] == "bank" or Arguments[1] == "whatblacksrob" then
			Teleport(CFrame.new(-270.44195556641,4.8757019042969,133.12774658203))
		end
	end
end,"tpto",{"tp"},"Teleports to places [banland/normalstreets/uzi/machete/spray/sawed/sawedoff/pipe/sand/prison/gas/court/beach/bank]")

AddCommand(function(Arguments)
local function fly(Speed)
local Head = GetChar():WaitForChild('Head',10)
if not Head then return end 
	flying = true
	local HadAirwalk = AirWalkOn
    local BodyGyro,BodyPos = Instance.new('BodyGyro',Head),Instance.new('BodyPosition',Head)
    BodyPos.maxForce = Vector3.new(9e9,9e9,9e9)
    BodyPos.Position = Head.Position
    BodyGyro.maxTorque = Vector3.new(9e9,9e9,9e9)
    BodyGyro.CFrame = Head.CFrame
    pcall(function()
      repeat wait()
		GetChar().Humanoid.PlatformStand = true
        local Pos = BodyGyro.CFrame - BodyGyro.CFrame.p + BodyPos.Position
        if not KeyTable['w'] and not KeyTable['a'] and not KeyTable['s'] and not KeyTable['d'] then 
          Speed = Speed
        elseif KeyTable['w'] then
          Pos = Pos + workspace.Camera.CoordinateFrame.lookVector * Speed
        elseif KeyTable['a'] then 
          Pos = Pos * CFrame.new(-Speed, 0, 0)
        elseif KeyTable['s'] then 
          Pos = Pos - workspace.Camera.CoordinateFrame.lookVector * Speed 
        elseif KeyTable['d'] then 
          Pos = Pos * CFrame.new(Speed, 0, 0)
        end 
        BodyPos.Position = Pos.p
        BodyGyro.CFrame = workspace.Camera.CoordinateFrame
		GetChar().Humanoid.PlatformStand = false
		GetChar().Humanoid:ChangeState(10)
		if not AirWalkOn then 
			CheckCommand("airwalk")
		end
		until not flying or GetChar().Humanoid.Health == 0
		if not HadAirwalk then 
			CheckCommand("airwalk")
		end
		if BodyGyro and BodyPos then 
			BodyGyro:Destroy()
			BodyPos:Destroy()
		end
        GetChar().Humanoid.PlatformStand = false 
      end)
  end
	if not flying then
  		fly(Arguments[1] and tonumber(Arguments[1]) or 10)
	else 
		flying = false 
	end
end,"fly",{"f"},"Allows you to be like a bird")

AddCommand(function(Arguments)
	if Arguments[1] then 
		if string.lower(Arguments[1]) == "ws" or string.lower(Arguments[1]) == "speed" then 
			GetChar():FindFirstChildWhichIsA'Humanoid'.WalkSpeed = Arguments[2]
			SpawnWS = Arguments[2] or NormalWS
		elseif string.lower(Arguments[1]) == "jp" or string.lower(Arguments[1]) == "jumppower" then 
			GetChar():FindFirstChildWhichIsA'Humanoid'.JumpPower = Arguments[2]
            SpawnJP = Arguments[2] or NormalJP
        elseif string.lower(Arguments[1]) == "hh" or string.lower(Arguments[1]) == "hipheight" then
         GetChar():FindFirstChildWhichIsA'Humanoid'.HipHeight = Arguments[2] 
			SpawnHH = Arguments[2] or NormalHH
		end
	end
end,"loop",{},"[Ws/Speed/Jp/JumpPower/HH/HipHeight/]")

AddCommand(function(Arguments)
	if Arguments[1] then
	local v = PlrFinder(Arguments[1])
		if v then 
			if not Arguments[2] then
				notif(v.Name,"Is on "..v.OsPlatform.." and is "..v.AccountAge.." days old",5,nil)
	      	elseif Arguments[2] and Arguments[2]:lower() == "os" or Arguments[2]:lower() == "operatingsystem" then 
				notif(v.Name,"is on "..v.OsPlatform,5,nil)
	      	elseif Arguments[2] and Arguments[2]:lower() == "age" or Arguments[2]:lower() == "accountage" or Arguments[2]:lower() == "accage" then 
				notif(v.Name,"has the account age of "..v.AccountAge,5,nil)
			end
		end
	else
		notif(LP.Name,"you are on "..LP.OsPlatform.."(duh) and your Account Age is "..LP.AccountAge,5,nil)
	end
end,"playerinfo",{"info"},"PlayerInfo/Info [Player] [Os/OperatingSystem/AccAge/Age/Accountage/none]")

local AntiAim = false 
AddCommand(function()
	if AntiAim then 
		local Tracks = GetChar().Humanoid:GetPlayingAnimationTracks()
		for i = 1,#Tracks do 
			if string.find(Tracks[i].Animation.AnimationId,"215384594") then 
				Tracks[i]:Stop()
			end
		end
	else
		local Anim = Instance.new'Animation'
		Anim.AnimationId = "rbxassetid://215384594"
		GetChar().Humanoid:LoadAnimation(Anim):play(5,45,250)
	end
	AntiAim = not AntiAim
end,"antiaim",{},"breaks shitty aimbots lol")

AddCommand(function()
if not PartTable then notif("Sorry,","This command only works on streets.",5,nil) return end 
math.randomseed(os.time())
	local Car = workspace.Cars:GetDescendants()
	for i = 1,#Car do
		local i = math.random(1,#Car)
		if Car[i]:IsA'VehicleSeat' and Car[i].Name == "Drive" and not Car[i].Occupant then 
			GetChar().HumanoidRootPart.CFrame = Car[i].CFrame
		end
	end
end,"bringcar",{},"Brings a car (Streets only)")

AddCommand(function(Arguments)
	if Arguments[1] and Arguments[2] then
		for Index,Key in pairs(Keys) do
		if Key:match("[%a%d]+$") == Arguments[1]:lower() then
				table.remove(Keys,Index)
			end
		end
		local hotkeyKEY = string.sub(Arguments[1], 1, 3)
		table.remove(Arguments, 1)
		local hotkeyCMD = table.concat(Arguments, " ")
		table.insert(Keys, hotkeyCMD.."||"..hotkeyKEY)
		updateSettings()
	end
end,"hotkey",{"key"},"Hotkeys a command to a key")

AddCommand(function()
if not PartTable then notif("Sorry,","This command only works on streets.",5,nil) return end 
	if GrabThing("Burger") then
		local Hamborger = LP.Backpack:FindFirstChild'Burger'
		if Hamborger then 
			Hamborger.Parent = GetChar()
			Hamborger:Activate() -- CHEEMS
		end
	end
	if GrabThing("Drink") then
		local Drink = LP.Backpack:FindFirstChild'Drink'
		if Drink then 
			Drink.Parent = GetChar()
			Drink:Activate()
		end 
	end
end,"heal",{"h"},"Heals you")

AddCommand(function()
	if not PartTable then notif("Sorry,","This command only works on streets.",5,nil) return end 
	if not GetChar():FindFirstChildOfClass'Tool' then notif("Tool needed","Hold a gun",5,nil) return end 
	GrabThing("Ammo")
end,"reload",{"r"},"Gives your current gun ammo")

AddCommand(function()
	DoubleJumpEnabled = not DoubleJumpEnabled
	notif("Command: DoubleJump","has been set to "..tostring(DoubleJumpEnabled),5,"rbxassetid://1281284684")
end,"doublejump",{},"Allows you to jump infitely")

AddCommand(function(Arguments)
	if Arguments[1] then
		for Index,Key in pairs(Keys) do
		if Key:match("[%a%d]+$") == Arguments[1]:lower() then
				table.remove(Keys,Index)
			end
		end
	end
end,"removekey",{"rkey"},"Removes a hotkey to a command")

AddCommand(function()
	Keys = {}
	ClickTpKey = ""
	updateSettings()
end,"removeallhotkeys",{"removeallkeys"},"Removes all hotkeys")

AddCommand(function(Arguments)
	if Arguments[1] then
		Arguments[1] = Arguments[1]:lower()
		if Arguments[1] == "outline" then 
			Cframe.BackgroundColor3 = Color3.new(Arguments[2] or 0,Arguments[3] or 0,Arguments[4] or 0)
		elseif Arguments[1] == "text" then 
			CText.BackgroundColor3 = Color3.new(Arguments[2] or 0,Arguments[3] or 0,Arguments[4] or 0)
		elseif Arguments[1] == "background" then 
			CmdFrame.BackgroundColor3 = Color3.new(Arguments[2] or 0,Arguments[3] or 0,Arguments[4] or 0)
		elseif Arguments[1] == "damageindicator" then 
			DmgIndicator.TextColor3 = Color3.new(Arguments[2] or 0,Arguments[3] or 0,Arguments[4] or 0)
		elseif Arguments[1] == "cmds" then 
			local Child = CmdFrame:GetChildren() 
			for i = 1,#Child do 
				if Child[i]:IsA'TextLabel' then 
					Child[i].BackgroundColor3 = Color3.new(Arguments[2] or 0,Arguments[3] or 0,Arguments[4] or 0)
				end
			end
		elseif Arguments[1] == "bullet" then
			BulletColour = ColorSequence.new(Color3.new(Arguments[2] or 0,Arguments[3] or 0,Arguments[4] or 0))
		elseif Arguments[1] == "values" then 
			DrawingT.Color = Color3.new(Arguments[2] or 0,Arguments[3] or 0,Arguments[4] or 0)
		elseif Arguments[1] == "itemesp" then
			ItemEspColour = Color3.new(Arguments[2] or 0,Arguments[3] or 0,Arguments[4] or 0)
		elseif Arguments[1] == "esp" then 
			EspColour = Color3.new(Arguments[2] or 0,Arguments[3] or 0,Arguments[4] or 0)
		else
			notif("Command: Colour","Colour: [BackGround/Text/Outline/cmds/damageindicator/bullet/values/itemesp/esp] [rgb]",5,"rbxassetid://1281284684")
		end
	end
end,"colour",{"color"},"Changes elements colours Colour [BackGround/Text/Outline/cmds/damageindicator/bullet/values/itemesp/esp]")

AddCommand(function(Arguments)
	if Arguments[1] then
		ClickTpKey = string.sub(Arguments[1],1,1)
		updateSettings()
	end
end,"clicktp",{"ctp"},"Allows you to teleport around the map with a Key")

AddCommand(function(Arguments)
if Arguments[1] then 
	local Plr = PlrFinder(Arguments[1]) 
		if Plr and Plr.Character then
			workspace.CurrentCamera.CameraSubject = Plr.Character
		end
	end
end,"view",{},"Allows you to look through a players vision")

AddCommand(function()
	workspace.CurrentCamera.CameraSubject = GetChar()
end,"unview",{},"Brings you back to your normal vision")

AddCommand(function(Arguments)
if not _G.DoYouHaveBfgBypass then notif("Command: Style","This is only for people with BFG bypass. Use the grip command.",5,"rbxassetid://1281284684") return end 
	if Arguments[1] then 
		Style(Arguments[1]:lower(),tonumber(Arguments[2]))
	end
end,"style",{},"Styles your BFG (Bfg bypass users only)")

AddCommand(function(Arguments)
	if Arguments[1] then 
		if Arguments[1]:lower() ~= "minigun" and not _G.DoYouHaveBfgBypass then 
			notif("Command: BFG","This mode is only for people with BFG bypass.",5,"rbxassetid://1281284684")
		else
			if Arguments[1]:lower() == "allbfg" then 
				NormalBfg = not NormalBfg
			end
			if Arguments[1]:lower() == "minigun" then 
				MinigunMode = not MinigunMode
			end
		end
	else 
		if _G.DoYouHaveBfgBypass then 
			BfgOn = not BfgOn 
		else
			MultiUzi = not MultiUzi 
		end
	end
end,"bfg",{},"Turns on BFG (Bfg [allbfg/minigun] - minigun makes your bfg not all shoot at once")

local HR;
AddCommand(function(Arguments)
	if HR then
		local CFramex = HR.CFrame
		HR:Destroy()
		HR = nil
		wait(0.5)
		Teleport(CFramex)
		workspace.CurrentCamera.CameraSubject = GetChar()
	else 
		local old = GetChar().HumanoidRootPart.CFrame
		HR = GetChar().HumanoidRootPart:Clone()
		HR.Parent = GetChar()
		workspace.CurrentCamera.CameraSubject = GetChar().Head
		HR.CFrame = CFrame.new(10000,0,10000)
		HR.CFrame = old
	end
end,"fblink",{},"Allows you to \"blink\" around the map")

AddCommand(function(Arguments)
	if Arguments[1] then 
        if Arguments[1]:lower() == "cash" then 
          farm("Cash")
        elseif Arguments[1]:lower() == "shotty" then 
          farm("Shotty")
        elseif Arguments[1]:lower() == "uzi" then 
          farm("Uzi")
        elseif Arguments[1]:lower() == "katana" then 
          farm("Katana")
        elseif Arguments[1]:lower() == "sawed off" or Arguments[1]:lower() == "sawed" then 
          farm("Sawed Off")
        elseif Arguments[1]:lower() == "all" then 
		  farm("All")
		elseif Arguments[1]:lower() == "auto" then 
			if not AutoFarm then
				farm("Cash")
			end
			local WChild = workspace:GetDescendants() 
			for i = 1,#WChild do
				if WChild[i]:IsA'Seat' then 
					WChild[i]:Destroy()
				end
			end
			AutoFarm = not AutoFarm
      	end
    end
end,"farm",{},"Grabs you stuff around the map (farm [shotty/cash/uzi/katana/sawed/all/auto] - auto is for cash")

AddCommand(function()
	ItemEsp = not ItemEsp
	if ItemEsp then 
		local ChildrenInMyAttic = workspace:GetChildren()
		for i = 1,#ChildrenInMyAttic do 
			if ChildrenInMyAttic[i].Name == "RandomSpawner" then 
				addBillBoardGui(ChildrenInMyAttic[i])
			end
		end
	else 
		local WChild = workspace:GetChildren()
		for i = 1,#WChild do
		local BBGui = WChild[i]:FindFirstChildOfClass'BillboardGui'
			if WChild[i].Name == "RandomSpawner" and BBGui then 
				BBGui:Destroy()
			end
		end
	end 
end,"itemesp",{},"Allows you to see where all the spawners are on the map through walls")

AddCommand(function(Arguments)
	if Arguments[1] then 
		local Plr = PlrFinder(Arguments[1])
		if Plr and Plr.Character and Plr ~= LP then 
			AimLock = true 
			AimlockTarget = Plr.Character
			OnlyAimLock = true 
			Plr.CharacterRemoving:Connect(function()
				if not LoopAimLock then 
					AimlockTarget = nil
					OnlyAimLock = false
				end
			end)
			Plr.Character.ChildAdded:Connect(function(T)
				if T.Name == "KO" and not LoopAimLock then
					AimlockTarget = nil
					OnlyAimLock = false 
				end
			end)
			Plr.CharacterAdded:Connect(function(a)
				if AimlockTarget.Name == Plr.Name then 
					AimlockTarget = Plr.Character 
				end
			end)
			notif("AimlockTarget","has been set to "..AimlockTarget.Name,5,"rbxassetid://1281284684")
		end
	else 
		OnlyAimLock = false 
		AimLock = not AimLock
		notif("Aimlock","has been set to "..tostring(AimLock),5,"rbxassetid://1281284684")
	end
end,"aimlock",{"aim"},"Shoots your gun that is titled 75 degrees at the selected person (Aimlock [Player/nil/loop] - if nil click players to set the aimlock target to them (loop makes it so when they respawn it still locks on)")

AddCommand(function()
	LoopAimLock = not LoopAimLock
	AimLock = true 
	notif("Command: LoopLock","has been set to "..tostring(LoopAimLock),5,"rbxassetid://1281284684")
end,"aimlockloop",{},"Loops/Unloops Aimlock")

AddCommand(function(Arguments)
	if Arguments[1] then 
		if Arguments[1] == "all" then 
			local Players_ = Players:GetPlayers() 
			for i = 1,#Players_ do 
				if Players_[i] ~= LP then
					table.insert(EspTable,Players_[i].UserId)
					if not UseDraw or Arguments[2] and Arguments[2]:lower() == "legacy" then 
						espPlayer(Players_[i],"Legacy")
					else 
						espPlayer(Players_[i])
					end
				end
			end
		else 
			local Player = PlrFinder(Arguments[1])
			if not Player then return end 
			if Player ~= LP then
				table.insert(EspTable,Player.UserId)
				if not UseDraw or Arguments[2] and Arguments[2]:lower() == "legacy" then 
					espPlayer(Player,"Legacy")
				else
					espPlayer(Player)
				end
			end
		end
	end
end,"esp",{},"allows you to see the player through walls (Esp [plr] legacy for the old esp (will default if you do NOT have drawing api)")

AddCommand(function(Arguments)
	if Arguments[1] then 
	local Player = PlrFinder(Arguments[1])
	if not Player then return end
	local A = workspace:GetDescendants()
	table.remove(EspTable,Player.UserId)
		for i = 1,#A do
			if string.sub(A[i].Name, 1, 5) == "[ESP]" then
				if string.sub(A[i].Name, 6) == Player.Name then
					A[i]:Destroy()
				end
			end
		end
		for i = 1,#PlayerTable do 
			if PlayerTable[i][2].Name == Player.Name then 
				PlayerTable[i][1]:Remove()
				PlayerTable[i][3]:Remove()
				PlayerTable[i][2] = nil 
				PlayerTable[i] = nil 
			end
		end
	else
		local A = workspace:GetDescendants()
		EspTable = {}
		for i = 1,#A do
			if string.sub(A[i].Name, 1, 5) == "[ESP]" then
				A[i]:Destroy()
			end
		end
		for i = 1,#PlayerTable do
			PlayerTable[i][1]:Remove()
			PlayerTable[i][3]:Remove()
			PlayerTable[i][2] = nil 
			PlayerTable[i] = nil 
		end
	end
end,"unesp",{},"Removes the esp on the player")

AddCommand(function()
	wait(0.5)
	ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Made by NotCyrusAtAll(Alt: Periius) | Join the cord at UVgdNXP","All")
end,"advertise",{},"Advertises my discord lol")

AddCommand(function()
	GetChar():FindFirstChildOfClass'Tool'.Parent = workspace.Terrain
end,"droptool",{"drop"},"Drops your current tool")

AddCommand(function(Arguments)
	if Arguments[1] then 
		loadstring(table.concat(Arguments," "))()
	end 
end,"luacode",{"lua"},"Allows you to execute the Lua code you input")

AddCommand(function()
	AutoStomp = not AutoStomp
end,"autostomp",{},"Turns On/Off AutoStomp")

AddCommand(function()
	if GetChar()['Right Arm'] then 
		GetChar()['Right Arm']:Destroy()
	end
end,"antikill",{},"Turns on Anti FE kill for your current life")

AddCommand(function(Arguments)
	local Player = PlrFinder(Arguments[1])
	if Player and Player.Character then 
		local PlayerChild = Player.Character:GetDescendants() 
		for i = 1,#PlayerChild do
			local v = PlayerChild[i]
			if v:IsA'Sound' and v.Name == "SoundX" then
				notif("Stole the Audio","From "..Player.Name.." check your exploits workspace folder",5,nil)
				writefile("AudioLog From "..Player.Name.." "..math.random(1,99)..".txt","Stolen ID: "..v.SoundId:match"%d+".." From: "..Player.Name)
			end
		end
	end 
end,"steal",{},"Steals a persons audio")

AddCommand(function(Arguments)
local Player = PlrFinder(Arguments[1])
	if Player then 
		local FindDecal = workspace:FindFirstChild(Player.Name.."Spray")
		if FindDecal and FindDecal:FindFirstChildOfClass'Decal' then 
			writefile("DecalLog From "..Player.Name.." "..math.random(1,99)..".txt","Stolen Decal: "..tostring(FindDecal.Decal.Texture:match"%d+").." From: "..Player.Name)
			notif("Stole the Decal","From "..Player.Name.." check your exploits workspace folder",5,nil)
		end
	end
end,"decalsteal",{},"Steals a persons decal")

AddCommand(function()
	AntiAfk = not AntiAfk
	notif("Command: AntiAfk","has been set to "..tostring(AntiAfk),5,"rbxassetid://1281284684")
end,"antiafk",{},"Stops you from being kicked from \"AFK\"")

local function checkHp(Plr)
	return Plr:FindFirstChildOfClass'Humanoid' and Plr.Humanoid.Health or "No Humanoid"
end

local function Stepped()
	if Noclipping then 
		local CDescendant = GetChar():GetDescendants() 
		for i = 1,#CDescendant do 
			if CDescendant[i]:IsA'Part' then 
				CDescendant[i].CanCollide = false
			end
		end
	end
	if ClockTime then 
		Lighting.ClockTime = ClockTime 
	end
	if AutoStomp then
		local Players = Players:GetPlayers()
		for i = 1,#Players do
			if Players[i] ~= LP and Players[i].Character and Players[i].Character:FindFirstChild'Head' and Players[i].Character:FindFirstChild'Torso' and not Players[i]:IsFriendsWith(LP.UserId) then
				if (GetChar().HumanoidRootPart.Position - Players[i].Character.Torso.Position).magnitude < 50  and Players[i].Character:FindFirstChild'KO' and Players[i].Character.Humanoid.Health > 0 and not GetChar():FindFirstChild'KO' and GetChar().Humanoid.Health > 0  and not Players[i]:FindFirstChild'Dragged' then
					GetChar().HumanoidRootPart.CFrame = CFrame.new(Players[i].Character.Torso.Position)
					LP.Backpack.ServerTraits.Finish:FireServer(LP.Backpack:FindFirstChild'Punch')
				end
			end
		end
	end
	if NormalBfg then 
		local BChild = LP.Backpack:GetChildren()
		for i = 1,#BChild do 
			if BChild[i]:FindFirstChild'Fire' then 
				BChild[i].Parent = GetChar() 
			end
		end
	end
	if AirWalkOn then 
		GetChar().Humanoid.HipHeight = 0
		AirWalk.CFrame = GetChar().HumanoidRootPart.CFrame * CFrame.new(0,-3.5,0)
	end
	for i = 1,#PlayerTable do
        if PlayerTable[i] and PlayerTable[i][2] and PlayerTable[i][2].Character and PlayerTable[i][2].Character:FindFirstChild'Head' and GetChar():FindFirstChild'Head' then 
            local RelativePos,OnScreen = workspace.CurrentCamera:WorldToViewportPoint(PlayerTable[i][2].Character.Head.Position)
            PlayerTable[i][1].Visible = OnScreen
            PlayerTable[i][1].Position = Vector2.new(RelativePos.X,RelativePos.Y)
            PlayerTable[i][3].Visible = OnScreen
			PlayerTable[i][3].Position = PlayerTable[i][1].Position + Vector2.new(0,10)
			PlayerTable[i][3].Color = EspColour
            if (GetChar().Head.Position - PlayerTable[i][2].Character.Head.Position).magnitude <= 100 then 
                PlayerTable[i][3].Text = PlayerTable[i][2].Name.." | Position: "..math.floor((GetChar().Head.Position - PlayerTable[i][2].Character.Head.Position).magnitude).." | Health: "..checkHp(PlayerTable[i][2].Character).."\nOperating System: "..PlayerTable[i][2].osPlatform.."\nHas: Glock "..hasItem(PlayerTable[i][2],"Glock").." | Shotty "..hasItem(PlayerTable[i][2],"Shotty").." | Vest "..hasItem(PlayerTable[i][2],"BulletResist").."\nCurrent Tool: "..hasItem(PlayerTable[i][2],true)
            else 
                PlayerTable[i][3].Text = PlayerTable[i][2].Name.." | Position: "..math.floor((GetChar().Head.Position - PlayerTable[i][2].Character.Head.Position).magnitude).."\nHealth: "..checkHp(PlayerTable[i][2].Character).."\nOperating System: "..PlayerTable[i][2].osPlatform
			end
		else 
			PlayerTable[i][1].Visible = false 
			PlayerTable[i][3].Visible = false 
        end
    end
end

local function CChildAdded(Thing)
	if Thing.Name == "KO" and AutoDie then 
		GetChar():BreakJoints()
	end
end

local function BChildAdded(Thing)
	if Thing.Name == "Uzi" and MultiUzi then 
		wait()
		if not LP.Backpack:FindFirstChild'Zetox Uzi' and not GetChar():FindFirstChild'Zetox Uzi' then
			local Tool = Instance.new('Tool',LP.Backpack)
			Tool.RequiresHandle = false 
			Tool.CanBeDropped = false 
			Tool.Name = "Zetox Uzi"
			Tool.Equipped:Connect(UziStats)
		end
		Thing.Parent = LP.PlayerGui
	end
	if string.find(Thing.Name:lower(),"cash") then
		wait()
		Thing.Parent = GetChar()
		Thing:Activate()
	end
end

local function PlayerGuiChildAdded(Thing)
	if Thing.Name == "Uzi" then 
		UziStats()
	end
end


Cframe.BackgroundColor3 = Color3.new(0.666667,0,0)
Cframe.BackgroundTransparency = 0.20000000298023
Cframe.BorderSizePixel = 0
Cframe.Position = UDim2.new(0, 0, 1, 0)
Cframe.Size = UDim2.new(0, 270, 0, 35)
Cframe.Name = math.random(1,3000000)

CText.BackgroundColor3 = Color3.new(0,0.000738177,0.000738177)
CText.BorderSizePixel = 0
CText.Position = UDim2.new(0, 5, 0, 5)
CText.Size = UDim2.new(0, 260, 0, 25)
CText.Font = Enum.Font.SourceSansLight
CText.Text = ""
CText.TextColor3 = Color3.new(1, 1, 1)
CText.TextScaled = true
CText.TextSize = 14
CText.TextWrapped = true
CText.Name = math.random(1,3000000)

CmdFrame.BackgroundColor3 = Color3.new(0, 0.000738177, 0.000738177)
CmdFrame.BorderSizePixel = 0
CmdFrame.Position = UDim2.new(0, 0, -4, 0)
CmdFrame.Size = UDim2.new(1, 0, 4, 0)
CmdFrame.Visible = false

local function Create(Text)
if not Text then return end
	local CmdList = Instance.new("TextLabel",CmdFrame)
	CmdList.BackgroundColor3 = Color3.new(0.666667, 0, 0)
	CmdList.BackgroundTransparency = 0.20000000298023
	CmdList.BorderSizePixel = 0
	CmdList.Position = UDim2.new(-10, 0, 0, 0)
	CmdList.Size = UDim2.new(1, 0, 0, 20)
	CmdList.Font = Enum.Font.SourceSansLight
	CmdList.Text = Text
	CmdList.TextColor3 = Color3.new(0.952941, 0.952941, 0.952941)
	CmdList.TextScaled = true
	CmdList.TextWrapped = true
end

local function Changed()
pcall(function() 
	if CText.Text ~= "" then
		CmdFrame.Visible = true
		local PositionMatch = 0
		for _,cmd in pairs(CmdFrame:GetChildren()) do
				if string.find(string.lower(cmd.Text),string.lower(CText.Text)) then
					cmd.Position = UDim2.new(0, 0, 0, 2 + (PositionMatch * 20))
					PositionMatch = PositionMatch + 1
					if cmd.Position == UDim2.new(0, 0, 0, 142) then
						cmd.Position = UDim2.new(-10, 0, 0, 0)
						PositionMatch = PositionMatch - 1
					end
				else
					cmd.Position = UDim2.new(-10, 0, 0, 0)
				end
			end
		else
			CmdFrame.Visible = false
		end
	end)
end

MainFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
MainFrame.BackgroundTransparency = 0.250
MainFrame.BorderColor3 = Color3.fromRGB(53,2,2)
MainFrame.BorderSizePixel = 8
MainFrame.Position = UDim2.new(0,695,0,297)
MainFrame.Size = UDim2.new(0,495,0,431)
MainFrame.AnchorPoint = Vector2.new(0,0)
MainFrame.Visible = false 
MainFrame.Active = true 
MainFrame.Draggable = true 

ScrollingFrame.BackgroundColor3 = Color3.fromRGB(53,2,2)
ScrollingFrame.BackgroundTransparency = 0.400
ScrollingFrame.BorderColor3 = Color3.fromRGB(0,0,0)
ScrollingFrame.BorderSizePixel = 5
ScrollingFrame.Position = UDim2.new(0.0880542845,0,0.126374945,0)
ScrollingFrame.Size = UDim2.new(0,411,0,348)

SearchBar.BackgroundColor3 = Color3.fromRGB(53,2,2)
SearchBar.BackgroundTransparency = 0.400
SearchBar.BorderColor3 = Color3.fromRGB(0,0,0)
SearchBar.BorderSizePixel = 5
SearchBar.Position = UDim2.new(0.0880542994,0,0.0598471165,0)
SearchBar.Size = UDim2.new(0,411,0,28)
SearchBar.Font = Enum.Font.SourceSansBold
SearchBar.PlaceholderColor3 = Color3.fromRGB(255,255,255)
SearchBar.Text = "Search"
SearchBar.TextColor3 = Color3.fromRGB(135, 135, 135)
SearchBar.TextSize = 24.000

Credits.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Credits.BackgroundTransparency = 0.250
Credits.BorderColor3 = Color3.fromRGB(53, 2, 2)
Credits.BorderSizePixel = 5
Credits.Position = UDim2.new(-0.00101006031,0,0.948468387,0)
Credits.Size = UDim2.new(0,187,0,22)
Credits.Font = Enum.Font.SourceSansBold
Credits.Text = "UI Design by !fishgang Karma#9669"
Credits.TextColor3 = Color3.fromRGB(255,255,255)
Credits.TextSize = 14.000

DmgIndicator.BackgroundColor3 = Color3.fromRGB(0,0,0)
DmgIndicator.BackgroundTransparency = 0.700
DmgIndicator.BorderSizePixel = 3
DmgIndicator.Position = UDim2.new(0,0,1.00488257,0)
DmgIndicator.Size = UDim2.new(0,385,0,50)
DmgIndicator.Font = Enum.Font.SourceSans
DmgIndicator.Text = ''
DmgIndicator.TextColor3 = Color3.fromRGB(184,0,3)
DmgIndicator.TextScaled = true
DmgIndicator.TextSize = 30.000
DmgIndicator.TextWrapped = true
DmgIndicator.Visible = false 

local function CreateCommand(Pos,Text)
	local ActualCommands = Instance.new('TextLabel',ScrollingFrame)
	ActualCommands.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
	ActualCommands.BackgroundTransparency = 0.200
	ActualCommands.BorderColor3 = Color3.fromRGB(53, 2, 2)
	ActualCommands.Position = Pos
	ActualCommands.Size = UDim2.new(0, 382, 0, 20)
	ActualCommands.Font = Enum.Font.SourceSansBold
	ActualCommands.Text = Text
	ActualCommands.TextColor3 = Color3.fromRGB(255, 255, 255)
	ActualCommands.TextSize = 14.000
	ActualCommands.TextScaled = true 
	ActualCommands.TextWrapped = true
end

SearchBar.Changed:Connect(function()
local Index = 0
	if SearchBar.Text then
		for _,v in pairs(ScrollingFrame:GetChildren()) do
			if not string.find(v.Text:lower(),SearchBar.Text:lower()) then
				v.Visible = false
			else
				v.Visible = true
				Index = Index + 1
				v.Position = UDim2.new(0.0150422715,0,0.0127776451,0 + (Index * 20))
			end
		end
	end
end)

LP.CharacterAdded:Connect(function()
	GetChar():WaitForChild('Humanoid',10)
	ChildAddedEvent = GetChar().ChildAdded:Connect(CChildAdded)
	PlayerGuiChildAddedEvent = LP.PlayerGui.ChildAdded:Connect(PlayerGuiChildAdded)
	BackpackAddedEvent = LP.Backpack.ChildAdded:Connect(BChildAdded)
	HumanoidStateChangedEvent = GetChar().Humanoid.StateChanged:Connect(HumanoidState)
	MultiUziReload = GetChar()['Left Leg'].Touched:Connect(MultiUzireload)
	HumanoidCAdded = GetChar().Humanoid.DescendantAdded:Connect(ColourChanger)
	GetChar().Humanoid.WalkSpeed = SpawnWS or NormalWS
    GetChar().Humanoid.JumpPower = SpawnJP or NormalJP
	GetChar().Humanoid.HipHeight = SpawnHH or NormalHH
	if PlayOnDeath then
		local Tool = LP.Backpack:WaitForChild('BoomBox',10)
		if Tool then 
			Tool.Parent = GetChar() 
			Tool:FindFirstChildOfClass'RemoteEvent':FireServer("play",PlayOnDeath)
			Tool.Parent = LP.Backpack
		end
	end
	if GodMode and GetChar():FindFirstChild'Right Leg' then 
		GetChar()['Right Leg']:Destroy()
	end
end)

LP.CharacterRemoving:Connect(function()
	ChildAddedEvent:Disconnect()
	PlayerGuiChildAddedEvent:Disconnect()
	BackpackAddedEvent:Disconnect()
	HumanoidStateChangedEvent:Disconnect()
	MultiUziReload:Disconnect()
	HumanoidCAdded:Disconnect()
	HR = nil
	flying = false
end)

UserInput.InputBegan:Connect(function(Key)
if UserInput:GetFocusedTextBox() then return end
	if Key.KeyCode == Enum.KeyCode.LeftControl then
		if AirWalkOn then 
			AirWalk.Size = Vector3.new(0,-1,0)
		end
		if Normalwalk and ControlSpeed == 8 then return end
		GetChar().Humanoid.WalkSpeed = ControlSpeed
	end
	if Key.KeyCode == Enum.KeyCode.LeftShift then 
		if Normalwalk and ShiftSpeed == 25 then return end 
		GetChar().Humanoid.WalkSpeed = ShiftSpeed
	end
	if Key.KeyCode == Enum.KeyCode.W then 
		KeyTable['w'] = true 
	end
	if Key.KeyCode == Enum.KeyCode.A then 
		KeyTable['a'] = true 
	end
	if Key.KeyCode == Enum.KeyCode.S then 
		KeyTable['s'] = true 
	end
	if Key.KeyCode == Enum.KeyCode.D then 
		KeyTable['d'] = true 
	end
	if Key.KeyCode == Enum.KeyCode.Space and AirWalkOn then 
		GetChar().HumanoidRootPart.CFrame = GetChar().HumanoidRootPart.CFrame + Vector3.new(0,5,0)
	end
	if Key.KeyCode == Enum.KeyCode.Quote then 
		CText:CaptureFocus()
		Cframe:TweenPosition(UDim2.new(0.015,0,0.95,0),"Out","Elastic",0.5,true)
		wait()
		CText.Text = ""
		UserInput.TextBoxFocusReleased:Wait()
		local Command = CText.Text
		CText.Text = ""
		CheckCommand(Command)
		Cframe:TweenPosition(UDim2.new(0.015,0,1,0),"Out","Quad",0.5,true)
	end
	if ClickTpKey and ClickTpKey ~= "" and Key.KeyCode == Enum.KeyCode[ClickTpKey:upper()] and Mouse.Target then
		if (Mouse.Hit.Position - GetChar().HumanoidRootPart.Position).magnitude < 50 then 
			GetChar().HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.p + Vector3.new(0,5,0))
		else
			Teleport(CFrame.new(Mouse.Hit.p + Vector3.new(0,5,0)))
		end
	end
	for _,v in pairs(Keys) do 
		if Enum.KeyCode[v:match'[%a%d]+$':upper()] == Key.KeyCode then 
			CheckCommand(v:match'^[%w%s]+')
		end
	end
end)

UserInput.InputEnded:Connect(function(Key)
if UserInput:GetFocusedTextBox() then return end
	if Key.KeyCode == Enum.KeyCode.LeftControl then
		if AirWalkOn then
			AirWalk.Size = Vector3.new(5,1,5)
		end 
		if Normalwalk and ControlSpeed == 8 then return end
		GetChar().Humanoid.WalkSpeed = WalkSpeed
	end
	if Key.KeyCode == Enum.KeyCode.W then 
		KeyTable['w'] = false
	end
	if Key.KeyCode == Enum.KeyCode.A then 
		KeyTable['a'] = false 
	end
	if Key.KeyCode == Enum.KeyCode.S then 
		KeyTable['s'] = false 
	end
	if Key.KeyCode == Enum.KeyCode.D then 
		KeyTable['d'] = false 
	end
	if Key.KeyCode == Enum.KeyCode.LeftShift and ShiftSpeed then
		if Normalwalk and ShiftSpeed == 25 then return end 
		GetChar().Humanoid.WalkSpeed = WalkSpeed
	end
end)

Players.PlayerRemoving:Connect(function(Plr)
	if AimlockTarget and Plr == Players:GetPlayerFromCharacter(AimlockTarget) then
		AimlockTarget = nil
	end 
    for i = 1,#PlayerTable do 
        if PlayerTable[i] and PlayerTable[i][2] == Plr then 
            PlayerTable[i][1]:Remove()
            PlayerTable[i][3]:Remove()
            PlayerTable[i][2] = nil 
			PlayerTable[i] = nil 
        end
    end
end)

CText.FocusLost:Connect(function(Enter)
	Cframe:TweenPosition(UDim2.new(0.015, 0, 1, 0),"Out","Quad",0.5,true)
	if Enter then 
		local Command = CText.Text
		CText.Text = ""
		CheckCommand(Command)
	end
end)

ChildAddedEvent = GetChar().ChildAdded:Connect(CChildAdded)
BackpackAddedEvent = LP.Backpack.ChildAdded:Connect(BChildAdded)
PlayerGuiChildAddedEvent = LP.PlayerGui.ChildAdded:Connect(PlayerGuiChildAdded)
HumanoidStateChangedEvent = GetChar().Humanoid.StateChanged:Connect(HumanoidState)
HumanoidCAdded = GetChar().Humanoid.DescendantAdded:Connect(ColourChanger)
MultiUziReload = GetChar()['Left Leg'].Touched:Connect(MultiUzireload)
Mouse.Button1Down:Connect(Button1Down)
Mouse.Button2Down:Connect(Button2Down)
LP.Chatted:Connect(CheckCommand)
UserInput.JumpRequest:Connect(DoubleJump)
CText.Changed:Connect(Changed)
RunService.Stepped:Connect(Stepped)

spawn(function()
	while true do
		if GetChar():FindFirstChildOfClass'Humanoid' and UseDraw then 
			DrawingT.Text = "Current WalkSpeed: "..GetChar().Humanoid.WalkSpeed.."\nSprinting Speed: "..ShiftSpeed.."\nCrouching Speed: "..ControlSpeed.."\nJumpPower: "..GetChar().Humanoid.JumpPower.."\nFlying: "..tostring(flying).."\nNoclipping: "..tostring(Noclipping).."\nAimlock Target: "..tostring(AimlockTarget)
		end
		if Blinking then 
			if KeyTable['w'] then 
				GetChar().HumanoidRootPart.CFrame = GetChar().HumanoidRootPart.CFrame + GetChar().HumanoidRootPart.CFrame.lookVector * BlinkSpeed
			end 
			if KeyTable['s'] then 
				GetChar().HumanoidRootPart.CFrame = GetChar().HumanoidRootPart.CFrame - GetChar().HumanoidRootPart.CFrame.lookVector * BlinkSpeed
			end
		end
		wait()
	end
end)

if PartTable then 
	spawn(function()
		while wait() do 
			if GetChar().Humanoid.HipHeight > 0 or AirWalkOn and GetChar().Humanoid.FloorMaterial == Enum.Material.Neon and not GetChar().Humanoid.Sit or flying then 
				local JP = GetChar().Humanoid.JumpPower
				GetChar().Humanoid.JumpPower = 1.5
				GetChar().Humanoid:ChangeState(3)
				wait(0.2)
				GetChar().Humanoid.JumpPower = JP
			end
		end
	end)
end

spawn(function()
	while wait(SpamDelay) do 
		if Spamming and SpamMessage then 
			ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(SpamMessage,"All")
		end
	end 
end)

spawn(function()
	while wait(10) do 
		if AntiAfk then 
			keypress(0x20)
		end
	end
end)

local FileDir,isFolder,makeFolder = syn_io_listdir or list_files,syn_io_isfolder or isfolder,syn_io_makefolder or makefolder

if FileDir and isFolder and makeFolder then 
	if not isFolder'CyAdminPlugins' then 
		makeFolder('CyAdminPlugins')
	end 
	for _,v in pairs(FileDir'CyAdminPlugins') do 
		local WorkingFile = loadfile(v)
		if not WorkingFile then
			ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("There was a syntax error (sadly can\'t output it as loadfile is gay)","All")
		else 
			local Work,Error = pcall(WorkingFile) 
			if not Work then 
				ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Runtime Error"..Error,"All")
			end
		end
	end
end 

for i = 1,#Commands do
	Create(Commands[i].Name.." "..Commands[i].Help)
	CreateCommand(UDim2.new(0.0150422715,0,0.0127776451,0 + (i * 20)),Commands[i].Name.." "..Commands[i].Help)
end
