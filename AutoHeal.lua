local Players,UserInput = game:GetService'Players',game:GetService'UserInputService'
local LP = Players.LocalPlayer
local Debounce = false 

local PartTable  = {
    ['Burger'] = workspace:FindFirstChild'Burger | $15':FindFirstChildOfClass'Part'.CFrame + Vector3.new(0,0.5,0);
    ['Drink'] = workspace:FindFirstChild'Drink | $15':FindFirstChildOfClass'Part'.CFrame + Vector3.new(0,0.5,0);
}

local function Heal()
    if Debounce then return end
    LP.Character.HumanoidRootPart.CFrame = CFrame.new(math.random(20,45),0,0)
    wait()
    repeat  
        LP.Character.HumanoidRootPart.CFrame = PartTable['Burger']
        game:GetService'RunService'.Heartbeat:wait()
    until LP.Backpack:FindFirstChild'Burger' or LP.Character:FindFirstChild'KO' or LP.Character.Humanoid.Health <= 0 
    repeat 
        LP.Character.HumanoidRootPart.CFrame = PartTable['Drink']
        game:GetService'RunService'.Heartbeat:wait()
    until LP.Backpack:FindFirstChild'Drink' or LP.Character:FindFirstChild'KO' or LP.Character.Humanoid.Health <= 0 
    local Children = LP.Backpack:GetChildren() 
    for i = 1,#Children do 
        if Children[i].Name == "Drink" or Children[i].Name == "Burger" then 
            Children[i].Parent = LP.Character
            Children[i]:Activate()
            repeat wait() until not LP.Character:FindFirstChildOfClass'Tool'
        end
    end
end 

UserInput.InputBegan:Connect(function(Key,Chatting)
    if Key.KeyCode == Enum.KeyCode.H and not Chatting then 
        Heal()
        Debounce = true 
        repeat wait() until workspace:FindFirstChild'Burger | $15' and workspace:FindFirstChild'Drink | $15' 
        Debounce = false 
    end
end)
