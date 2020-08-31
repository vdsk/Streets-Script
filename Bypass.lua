local Raw = getrawmetatable(game)
local Caller = checkcaller or is_protosmasher_caller or Cer.isCerus
local CallingScript = getcallingscript or get_calling_script
local Closure = newcclosure or read_me or function(Func) return Func end
local CallingMethod = getnamecallmethod or get_namecall_method
local NormalGravity = workspace.Gravity

setreadonly(Raw,false)

local Index = Raw.__index;
Raw.__index = Closure(function(self,Indexed)
	if TpBypass and CallingScript and CallingScript() ~= script and Indexed == "HumanoidRootPart" then 
		return Index(self,"Torso")
	end
	return Index(self,Indexed)
end)

local NewIndex = Raw.__newindex;
Raw.__newindex = Closure(function(self,Property,Value)
	if Caller() then return NewIndex(self,Property,Value) end
	StarterGui:SetCore('ResetButtonCallback',true)
	if Property == "WalkSpeed" and WalkShoot then return 16 end
	if Property == "JumpPower" then return 37.5 end 
	if Property == "HipHeight" then return 0 end 
	if Property == "Health" then return 100 end
	if self == workspace and Property == "Gravity" then return NormalGravity end
	if Property == "CFrame" and self:IsDescendantOf(LP.Character) then return end 
	return NewIndex(self,Property,Value)
end)

local Namecall = Raw.__namecall;
Raw.__namecall = Closure(function(self,...)
local Args = {...}
	if Caller() then 
		if CallingMethod() == "FindFirstChild" and Args[1] == "RealHumanoidRootPart" then 
			Args[1] = "HumanoidRootPart" 
			return Namecall(self,unpack(Args))
		end
		return Namecall(self,...) 
	end 
	if CallingMethod() == "Destroy" or CallingMethod() == "Kick" then 
		if self == LP then return wait(9e9) end
		if tostring(self) == 'BodyGyro' or tostring(self) == 'BodyVelocity' then return wait(9e9) end 
	end
	if CallingMethod() == "BreakJoints" and self == LP.Character then return wait(9e9) end
	if CallingMethod() == "FireServer" then
		if tostring(self) == "Fire" and Aimlock and AimlockTarget then
			return Namecall(self,AimbotToCFrame())
		end 
		if tostring(self) == "Input" and Aimlock and AimlockTarget then 
			Args[2].mousehit = AimbotToCFrame()
			return Namecall(self,unpack(Args))
		end
		if tostring(self.Parent) == "ReplicatedStorage" or Args[1] == "hey" and not tostring(self) == "SayMessageRequest" then 
			return wait(9e9)
		end
		if tostring(self) == "Touch1" and AlwaysGh then
			Args[3] = true
			return Namecall(self,unpack(Args)) 
		end
		if Args[1] == "play" then 
			PlayOnDeath = Args[2]
		elseif Args[1] == "stop" then 
			PlayOnDeath = nil
		end
	end
	if CallingMethod() == "WaitForChild" or CallingMethod() == "FindFirstChild" then 
		if CallingScript and CallingScript() ~= script and TpBypass and Args[1] == "HumanoidRootPart" then
			Args[1] = "Torso"
			return Namecall(self,unpack(Args))
		end
	end
	return Namecall(self,...)
end)

if hookfunction then 
	local OldRemote; OldRemote = hookfunction(Instance.new'RemoteEvent'.FireServer,function(self,...)
		local Args = {...}
		if tostring(self) == "Touch1" and AlwaysGh then 
			Args[3] = true 
			return OldRemote(self,unpack(Args))
		end
		return OldRemote(self,...)
	end)
end 

setreadonly(Raw,true)
