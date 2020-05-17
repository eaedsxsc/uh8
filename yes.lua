if game:GetService("RunService"):IsClient()then error("Please run as a server script. Use h/ instead of hl/.")end;print("FE Compatibility by WaverlyCole & Fireboltofdeath");print("https://github.com/WaverlyCole/FE-Compatibility-VoidSb-")
local Wrapper = {};Wrapper.Fake = {};Wrapper.Real = {};Wrapper.Data = {};
local sGame = game;local sScript = script;local sOwner = owner;local sInstance = Instance;local sLoadLibrary = LoadLibrary
Wrapper.Event = Instance.new("RemoteEvent");Wrapper.Event.Name = "UserInput";
Wrapper.CreateObject = function(connections, index)
    local proxy = newproxy (true);local meta = getmetatable (proxy);
    local runbind = function (self, i, ...) connections[i]:Fire (...); end;
	while (#connections > 0) do connections[table.remove(connections, 1)] = Instance.new ('BindableEvent');end;
    meta.__index = function (self, i)
        if (i == 'TriggerEvent') then return runbind end;
        return connections[i] and connections[i].Event or index[i];
    end;
    meta.__newindex = index;meta.__metatable = false;return proxy
end;
Wrapper.Mouse = Wrapper.CreateObject({"KeyUp","KeyDown","Button1Down","Button1Up","Move","Button2Down","Button2Up"},{["Target"] = nil;["Hit"] = CFrame.new()})
Wrapper.UserInputService = Wrapper.CreateObject({"InputBegan","InputEnded"},{})
Wrapper.ContextActionService = {Actions={};BindAction = function(self,actionName,Func,touch,...)self.Actions[actionName] = Func and {Name=actionName,Function=Func,Keys={...}} or nil end;UnBindAction = function(self,actionName,Func,touch,...)self.Actions[actionName] = Func and {Name=actionName,Function=Func,Keys={...}} or nil end};
Wrapper.Sandbox = function(...)
  local Unwrap = {...};
  for obi = 1,#Unwrap do
    local Object = Unwrap[obi];
    if (Wrapper.Fake[Object] == nil and Wrapper.Real[Object] == nil) then
      local Type = typeof(Object);local Replacement = Object;
      if (Type == "function") then
		Replacement = function(...)
			local IsRoblox = not (pcall(function() string.dump(Object) end))
			if IsRoblox then
				return Object(Wrapper.Unsandbox(...))
			end
			return Object(Wrapper.Sandbox(...))
		end
	  elseif (Type == "table") then
		Replacement = {};
        setmetatable(Replacement, {
        	__index = function(self, i)
            	return Wrapper.Sandbox(Object[Wrapper.Unsandbox(i)])
        	end,
			__newindex = function(self,i,v)
				Object[Wrapper.Unsandbox(i)] = Wrapper.Unsandbox(v)
			end;
       })
      elseif (Type == "Instance") then
        Replacement = newproxy(true);
        local Mt = getmetatable(Replacement);
		Mt.__namecall = function(self, ...)
            local Pack = {...};local Name = Pack[#Pack];table.remove(Pack, #Pack);
            local Rest = nil;pcall(function()Rest = Object[Name];end);
            for g, x in pairs (Wrapper.InstanceMT["GET"]) do
                if (Object:IsA(g) or g == "Global") then
                    for t, v in pairs(x) do
                        for str in string.gmatch(t .. ",", "(%w+),")  do
                            if (Name == str) then
								if typeof(v) == "function" then
									return Wrapper.Sandbox(v(Wrapper.Unsandbox(self), Wrapper.Unsandbox(unpack(Pack))))
                                else
                                    return v;
								end
                            end
                        end
                    end
                end
            end
            if (Rest == nil) then
				if Wrapper.Sandbox(sGame):GetService(unpack(Pack)) then return Wrapper.Sandbox(sGame):GetService(unpack(Pack))end;
                return Wrapper.Sandbox(Object[Name]);
            elseif (typeof(Rest) == "function") then
                return Wrapper.Sandbox(Rest(Wrapper.Unsandbox(self), Wrapper.Unsandbox(unpack(Pack))))
            end
          	return Wrapper.Sandbox(Object[Name]);
        end
        Mt.__index = function(self, i)
			local Rest = nil;pcall(function()Rest = Object[i];end)
            for g, x in pairs (Wrapper.InstanceMT["GET"]) do
                if (Object:IsA(g) or g == "Global") then
                    for t, v in pairs(x) do
                        for str in string.gmatch(t .. ",", "(%w+),")  do
                            if (i == str) then
								if typeof(v) == "function" then
									return function(...)return Wrapper.Sandbox(v(Wrapper.Unsandbox(self), Wrapper.Unsandbox(...)))end;
                                else
                                    return v;
								end
                            end
                        end
                    end
                end
            end
			if (Object:IsA("Sound") and i == "PlaybackLoudness") then return Wrapper.SoundLoudness[Wrapper.Unsandbox(Object)];end;
            if (Rest == nil) then
				if Wrapper.Sandbox(sGame):GetService(i) then return Wrapper.Sandbox(sGame):GetService(i)end;
                return Wrapper.Sandbox(Object[i]);
            elseif (typeof(Rest) == "function") then
				local isService,Service = pcall(function() return sGame:GetService(i) end)
				if isService and Service then return Wrapper.Sandbox(Service) end
                return function(self, ...)
                    return Wrapper.Sandbox(Rest(Wrapper.Unsandbox(self), Wrapper.Unsandbox(...)))
                end
            end
          	return Wrapper.Sandbox(Object[i]);
        end
		Mt.__newindex = function(self, i, v)
			for g,x in pairs (Wrapper.InstanceMT["SET"]) do 
				if (Object:IsA(g)) then
					for t, v in pairs(x) do 
						for str in string.gmatch( t .. ",", "(%w+),") do 
							if v(Wrapper.Unsandbox(self, i, v)) == true then
								Object[Wrapper.Unsandbox(i)] = Wrapper.Unsandbox(v);return
							end
						end
					end
				end
			end
			Object[Wrapper.Unsandbox(i)] = Wrapper.Unsandbox(v);
        end
        Mt.__tostring = function(self) return tostring(Object) end
      --elseif (Type == "") then -- Etc
      end
      Wrapper.Fake[Object] = Replacement;Wrapper.Real[Replacement] = Object;Unwrap[obi] = Replacement;
    else
      return Wrapper.Fake[Object] or Object;
    end
  end
  return unpack(Unwrap);
end
Wrapper.Unsandbox = function(...)
  local Unsandbox = {...};
  for i,v in pairs (Unsandbox) do Unsandbox[i] = Wrapper.Real[v] or Unsandbox[i]end;
  return unpack(Unsandbox)
end
Wrapper.Services = {
	['contextactionservice'] = Wrapper.ContextActionService;
	["userinputservice"]  = Wrapper.UserInputService;
}
Wrapper.InstanceMT = { 
    ["GET"] = {
		["Global"] = {
			["IsFake,isFake"] = function(self)return true;end;
		};
        ["Player"] = {
			["mouse,Mouse,getMouse,GetMouse"] = function(self)return Wrapper.Mouse;end;
        };
        ["Players"] = {
            ["localPlayer,LocalPlayer"] = Wrapper.Sandbox(owner)
        };
		["DataModel"] = {
			["getService,GetService"] = function(self,service)
				if Wrapper.Services[service:lower()] then return Wrapper.Sandbox(Wrapper.Services[service:lower()])end;
				return Wrapper.Sandbox(sGame:GetService(service))
			end
		};
		["RunService"] = {
            ["renderstepped,renderStepped,RenderStepped"] =  sGame:GetService("RunService").Stepped;
        }
  };
    ["SET"] = {
  }
}
Wrapper.SoundLoudness = {};
Wrapper.Event.OnServerEvent:Connect(function(FiredBy,Input)
	if FiredBy ~= sOwner then return end
	if Input.MouseEvent then
		Wrapper.Mouse.Target = Input.Target;Wrapper.Mouse.Hit = Input.Hit;Wrapper.Mouse:TriggerEvent("Move")
	elseif Input.Sound then
		if Wrapper.SoundLoudness[Input.Sound] then Wrapper.SoundLoudness[Input.Sound] = Input.Loudness end
	else
		local Begin = Input.UserInputState == Enum.UserInputState.Begin
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then return Wrapper.Mouse:TriggerEvent(Begin and "Button1Down" or "Button1Up") end
		if Input.UserInputType == Enum.UserInputType.MouseButton2 then return Wrapper.Mouse:TriggerEvent(Begin and "Button2Down" or "Button2Up") end
		for _,Action in pairs(Wrapper.ContextActionService.Actions) do
			for _,Key in pairs(Action.Keys) do if Key==Input.KeyCode then Action.Function(Action.Name,Input.UserInputState,Input) end end
		end
		Wrapper.Mouse:TriggerEvent(Begin and "KeyDown" or "KeyUp",Input.KeyCode.Name:lower());Wrapper.UserInputService:TriggerEvent(Begin and "InputBegan" or "InputEnded",Input,false)
	end
end);
Wrapper.Event.Parent = NLS([[
		local Player = owner;local Sounds = {};local Event = script:WaitForChild("UserInput");local UserInputService = game:GetService("UserInputService");local Mouse = Player:GetMouse();
		local Input = function(Input,gameProcessedEvent)
			if gameProcessedEvent then return end;
			Event:FireServer({KeyCode=Input.KeyCode,UserInputType=Input.UserInputType,UserInputState=Input.UserInputState})
		end
		Event.OnClientEvent:connect(function(Args)
			if Args[1] == "NewSound" and Args[2]:IsA("Sound") then table.insert(Sounds,Args[2]) end
		end)
		UserInputService.InputBegan:Connect(Input);UserInputService.InputEnded:Connect(Input)
		local Hit,Target;while wait(1/30) do
			for x,Sound in pairs(Sounds) do if Sound.Parent then Event:FireServer({["Sound"]=Sound,["Loudness"]=Sound.PlaybackLoudness}) end; end;
			if Hit ~= Mouse.Hit or Target ~= Mouse.Target then
				Hit = Mouse.Hit;Target = Mouse.Target;Event:FireServer({["MouseEvent"]=true,["Target"]=Target,["Hit"]=Hit})
			end
		end]],sOwner.Character)
Instance = {
	["new"] = function(Type,Parent)
		local Real = sInstance.new(Type,Wrapper.Unsandbox(Parent))
		if Type:lower() == "sound" then
			if not Parent then
				Parent = sOwner.Character 
			end 
			Wrapper.SoundLoudness[Real] = 0;Wrapper.Event:FireClient(sOwner,{"NewSound",Real})
		end
		return Wrapper.Sandbox(Real)
	end
}
LoadLibrary = function(Library)
	if Library == "RbxUtility" then
		return setmetatable({},{
			__tostring = function() return "RbxUtility" end;
			__index = function(self, Index)
				if Index:lower() == "create" then
					return function(Type) return function(Data)
							Data = Data or {};local Inst = Instance.new(Type)
							for x,y in pairs(Data) do Inst[x] = y end
							return Inst
					end;end;
				end
			return sLoadLibrary(Library)[Index]
		end})
	end
	return sLoadLibrary(Library)
end
owner = Wrapper.Sandbox(owner);game = Wrapper.Sandbox(game)workspace = Wrapper.Sandbox(workspace)
Game= game;Workspace = workspace;
toggleTag = false
--//Paste script below this line.
local tool = Instance.new("Tool",owner.Backpack)
local hed = Instance.new("Part",tool)
hed.Name = "Handle"
tool.Name = "star"
equipped = false
sine = 0
change = 1
local bilguit = Instance.new("BillboardGui", hed)
bilguit.Adornee = nil
bilguit.Name = "ModeName"
bilguit.Size = UDim2.new(4, 0, 1.2, 0)
bilguit.StudsOffset = Vector3.new(-8, 8/1.5, 0)
local modet = Instance.new("TextLabel", bilguit)
modet.Size = UDim2.new(10/2, 0, 7/2, 0)
modet.FontSize = "Size8"
modet.TextScaled = true
modet.TextTransparency = 0
modet.BackgroundTransparency = 1 
modet.TextTransparency = 0
modet.TextStrokeTransparency = 0
modet.Font = "Antique"
modet.TextStrokeColor3 = Color3.new(1,0,0)
modet.TextColor3 = Color3.new(0.25,0,0)
modet.Text = "MAYHEM"
local kan = Instance.new("Sound",hed)
kan.Volume = 1.25
kan.TimePosition = 0
kan.PlaybackSpeed = 1
kan.Pitch = 1
kan.SoundId = "rbxassetid://614032233"
kan.Name = "wrecked"
kan.Looped = true
kan:Pause()
tool.Equipped:Connect(function()
	equipped = true
	kan:Resume()
end)
tool.Unequipped:Connect(function()
	equipped = false
	kan:Pause()
end)
ModeOfGlitch = 1
attack = false
storehumanoidWS = 0
hum = {WalkSpeed = 0}
rainbowmode = false
chaosmode = false
MAINRUINCOLOR = BrickColor.new"Really red"
function createBGCircle(size,parent,color)
local bgui = Instance.new("BillboardGui",parent)
bgui.Size = UDim2.new(size, 0, size, 0)
local imgc = Instance.new("ImageLabel",bgui)
imgc.BackgroundTransparency = 1
imgc.ImageTransparency = 0
imgc.Size = UDim2.new(1,0,1,0)
imgc.Image = "rbxassetid://997291547" --997291547,521073910
imgc.ImageColor3 = color
return bgui,imgc
end

function symbolizeBlink(guipar,size,img,color,bonussize,vol,pit,soundid,spar,rotationenabled,rotsp,delay)
local bgui,imgc = createBGCircle(size,guipar,color)
bgui.AlwaysOnTop = true
imgc.Image = "rbxassetid://" ..img
local rrot = math.random(1,2)
CFuncs["Sound"].Create("rbxassetid://" ..soundid, spar, vol,pit)
coroutine.resume(coroutine.create(function()
for i = 0, 24*delay do
swait()
if rotationenabled == true then
if rrot == 1 then
imgc.Rotation = imgc.Rotation + rotsp
elseif rrot == 2 then
imgc.Rotation = imgc.Rotation - rotsp
end
end
bgui.Size = bgui.Size + UDim2.new(1*bonussize/delay,0,1*bonussize/delay,0)
imgc.ImageTransparency = imgc.ImageTransparency + 0.04/delay
end
bgui:Destroy()
end))
end
local Create = function(Object, Parent, Name, Data)
	local Object = Instance.new(Object)
	for Index, Value in pairs(Data or {}) do
		Object[Index] = Value
	end
	Object.Parent = Parent
	Object.Name = Name
	return Object
end
root = hed
CFuncs = {	
	["Part"] = {
		Create = function(Parent, Material, Reflectance, Transparency, BColor, Name, Size)
			local Part = Create("Part"){
				Parent = Parent,
				Reflectance = Reflectance,
				Transparency = Transparency,
				CanCollide = false,
				Locked = true,
				BrickColor = BrickColor.new(tostring(BColor)),
				Name = Name,
				Size = Size,
				Material = Material,
			}
			RemoveOutlines(Part)
			return Part
		end;
	};
	
	["Mesh"] = {
		Create = function(Mesh, Part, MeshType, MeshId, OffSet, Scale)
			local Msh = Create(Mesh){
				Parent = Part,
				Offset = OffSet,
				Scale = Scale,
			}
			if Mesh == "SpecialMesh" then
				Msh.MeshType = MeshType
				Msh.MeshId = MeshId
			end
			return Msh
		end;
	};
	
	["Mesh"] = {
		Create = function(Mesh, Part, MeshType, MeshId, OffSet, Scale)
			local Msh = Create(Mesh){
				Parent = Part,
				Offset = OffSet,
				Scale = Scale,
			}
			if Mesh == "SpecialMesh" then
				Msh.MeshType = MeshType
				Msh.MeshId = MeshId
			end
			return Msh
		end;
	};
	
	["Weld"] = {
		Create = function(Parent, Part0, Part1, C0, C1)
			local Weld = Create("Weld"){
				Parent = Parent,
				Part0 = Part0,
				Part1 = Part1,
				C0 = C0,
				C1 = C1,
			}
			return Weld
		end;
	};

	["Sound"] = {
		Create = function(id, par, vol, pit) 
			coroutine.resume(coroutine.create(function()
				local S = Create("Sound"){
					Volume = vol,
                                        Name = "EffectSoundo",
					Pitch = pit or 1,
					SoundId = id,
					Parent = par or workspace,
				}
				wait() 
				S:play() 
				game:GetService("Debris"):AddItem(S, 10)
			end))
		end;
	};

	["TimeSound"] = {
		Create = function(id, par, vol, pit, timepos) 
			coroutine.resume(coroutine.create(function()
				local S = Create("Sound"){
					Volume = vol,
                                        Name = "EffectSoundo",
					Pitch = pit or 1,
					SoundId = id,
                                        TimePosition = timepos,
					Parent = par or workspace,
				}
				wait() 
				S:play() 
				game:GetService("Debris"):AddItem(S, 10)
			end))
		end;
	};
		["EchoSound"] = {
		Create = function(id, par, vol, pit, timepos,delays,echodelay,fedb,dryl) 
			coroutine.resume(coroutine.create(function()
				local Sas = Create("Sound"){
					Volume = vol,
                    Name = "EffectSoundo",
					Pitch = pit or 1,
					SoundId = id,
                    TimePosition = timepos,
					Parent = par or workspace,
				}
				local E = Create("EchoSoundEffect"){
					Delay = echodelay,
                    Name = "Echo",
					Feedback = fedb,
                    DryLevel = dryl,
					Parent = Sas,
				}
				wait() 
				Sas:play() 
				game:GetService("Debris"):AddItem(Sas, delays)
			end))
		end;
	};

["LongSound"] = {
		Create = function(id, par, vol, pit) 
			coroutine.resume(coroutine.create(function()
				local S = Create("Sound"){
					Volume = vol,
					Pitch = pit or 1,
					SoundId = id,
					Parent = par or workspace,
				}
				wait() 
				S:play() 
				game:GetService("Debris"):AddItem(S, 60)
			end))
		end;
	};
	
	["ParticleEmitter"] = {
		Create = function(Parent, Color1, Color2, LightEmission, Size, Texture, Transparency, ZOffset, Accel, Drag, LockedToPart, VelocityInheritance, EmissionDirection, Enabled, LifeTime, Rate, Rotation, RotSpeed, Speed, VelocitySpread)
			local fp = Create("ParticleEmitter"){
				Parent = Parent,
				Color = ColorSequence.new(Color1, Color2),
				LightEmission = LightEmission,
				Size = Size,
				Texture = Texture,
				Transparency = Transparency,
				ZOffset = ZOffset,
				Acceleration = Accel,
				Drag = Drag,
				LockedToPart = LockedToPart,
				VelocityInheritance = VelocityInheritance,
				EmissionDirection = EmissionDirection,
				Enabled = Enabled,
				Lifetime = LifeTime,
				Rate = Rate,
				Rotation = Rotation,
				RotSpeed = RotSpeed,
				Speed = Speed,
				VelocitySpread = VelocitySpread,
			}
			return fp
		end;
	};

	CreateTemplate = {
	
	};
}

function RecolorThing(one,two,three,four,five,exonetran,exone,extwotran,extwo,secondaryenabled)
CFuncs["EchoSound"].Create("rbxassetid://847061203", root, 1, 1,0,10,0.25,0.25,1)
symbolizeBlink(root,0,2092248396,one.Color,5,3,1,847061203,root,true,10,1)
symbolizeBlink(root,0,2092248396,one.Color,4,0,0,0,root,true,-5,1)
end
function newTheme(ID,timepos,pitch,vol)
local kanz = kan
--kanz:Stop()
kanz.Volume = vol
--kanz.TimePosition = timepos
kanz.PlaybackSpeed = pitch
kanz.Pitch = pitch
kanz.SoundId = ID
kanz.Name = "wrecked"
kanz.Looped = true
--kanz:Play()
--coroutine.resume(coroutine.create(function()
--wait(0.05)
--end))
end

mouse = owner:GetMouse()
function RecolorTextAndRename(name,col1,col2,font)
modet.TextStrokeColor3 = col2
modet.TextColor3 = col1
modet.Font = font
modet.Text = name
end
mutedtog = false
mouse.KeyDown:connect(function(k)
if equipped then
if k == "q" and attack == false and ModeOfGlitch ~= 1 then
--normalmog() ---Disabled due to crashing... only in VSB
ModeOfGlitch = 1
storehumanoidWS = 16
hum.WalkSpeed = 16
rainbowmode = false
chaosmode = false
newTheme("rbxassetid://614032233",48.6,1,1.25)
RecolorTextAndRename("MAYHEM",Color3.new(0.25,0,0),Color3.new(1,0,0),"Antique")
MAINRUINCOLOR = BrickColor.new("Really red")
RecolorThing(MAINRUINCOLOR,MAINRUINCOLOR,MAINRUINCOLOR,MAINRUINCOLOR,MAINRUINCOLOR,1,MAINRUINCOLOR,1,MAINRUINCOLOR,false)
end
if k == "e" and attack == false and ModeOfGlitch ~= 2 then
ModeOfGlitch = 2
storehumanoidWS = 16
hum.WalkSpeed = 16
rainbowmode = false
chaosmode = false
RecolorTextAndRename("PURITY",Color3.new(0,1,1),Color3.new(1,1,1),"Code")
newTheme("rbxassetid://1539245059",0,1,1.25)
MAINRUINCOLOR = BrickColor.new("Toothpaste")
RecolorThing(MAINRUINCOLOR,MAINRUINCOLOR,MAINRUINCOLOR,MAINRUINCOLOR,MAINRUINCOLOR,1,MAINRUINCOLOR,1,MAINRUINCOLOR,true)
end
if k == "r" and attack == false and ModeOfGlitch ~= 3 then
               ModeOfGlitch = 3
storehumanoidWS = 16
hum.WalkSpeed = 16
rainbowmode = false
chaosmode = false
RecolorTextAndRename("CORRUPTION",Color3.new(0,0,0),Color3.new(0.35,0,1),"Antique")
newTheme("rbxassetid://1283869370",58.15,0.98,1.25)
MAINRUINCOLOR = BrickColor.new("Royal purple")
RecolorThing(MAINRUINCOLOR,MAINRUINCOLOR,MAINRUINCOLOR,MAINRUINCOLOR,MAINRUINCOLOR,1,MAINRUINCOLOR,1,MAINRUINCOLOR,true)
end
if k == "t" and attack == false and ModeOfGlitch ~= 4 then
               ModeOfGlitch = 4
storehumanoidWS = 16
hum.WalkSpeed = 16
rainbowmode = false
chaosmode = true
RecolorTextAndRename("CHAOS",Color3.new(0,0,0),Color3.new(1,1,1),"Arcade")
newTheme("rbxassetid://1369263130",0,1.01,1.25)
MAINRUINCOLOR = BrickColor.new("Black")
RecolorThing(MAINRUINCOLOR,MAINRUINCOLOR,MAINRUINCOLOR,MAINRUINCOLOR,MAINRUINCOLOR,1,MAINRUINCOLOR,1,MAINRUINCOLOR,true)
end
if k == "y" and attack == false and ModeOfGlitch ~= 5 then
               ModeOfGlitch = 5
storehumanoidWS = 16
hum.WalkSpeed = 16
rainbowmode = false
chaosmode = false
RecolorTextAndRename("DIVINITY",Color3.new(1,1,1),Color3.new(1,1,0.5),"SciFi")
newTheme("rbxassetid://661079869",0,1.02,1.25)
MAINRUINCOLOR = BrickColor.new("Bright yellow")
RecolorThing(MAINRUINCOLOR,MAINRUINCOLOR,MAINRUINCOLOR,MAINRUINCOLOR,MAINRUINCOLOR,1,MAINRUINCOLOR,1,MAINRUINCOLOR,true)
end
if k == "u" and attack == false and ModeOfGlitch ~= 6 then
               ModeOfGlitch = 6
storehumanoidWS = 100
hum.WalkSpeed = 100
rainbowmode = false
chaosmode = false
RecolorTextAndRename("EQUINOX",Color3.new(0,0,0),Color3.new(1,1,1),"Fantasy")
newTheme("rbxassetid://1347011178",0,1.01,1.25)
MAINRUINCOLOR = BrickColor.new("White")
RecolorThing(MAINRUINCOLOR,BrickColor.new("Really black"),MAINRUINCOLOR,MAINRUINCOLOR,MAINRUINCOLOR,1,MAINRUINCOLOR,1,MAINRUINCOLOR,true)
end
if k == "f" and attack == false and ModeOfGlitch ~= 8 then
               ModeOfGlitch = 8
storehumanoidWS = 140
hum.WalkSpeed = 140
rainbowmode = false
chaosmode = false
RecolorTextAndRename("DESTINY",Color3.new(1,1,1),BrickColor.new("Alder").Color,"Code")
newTheme("rbxassetid://1495032271",0,1.01,1.25)
MAINRUINCOLOR = BrickColor.new("Alder")
RecolorThing(MAINRUINCOLOR,MAINRUINCOLOR,MAINRUINCOLOR,MAINRUINCOLOR,MAINRUINCOLOR,1,MAINRUINCOLOR,1,MAINRUINCOLOR,true)
end
if k == "g" and attack == false and ModeOfGlitch ~= 9 then
               ModeOfGlitch = 9
storehumanoidWS = 150
hum.WalkSpeed = 150
rainbowmode = false
chaosmode = false
RecolorTextAndRename("INFESTATION",Color3.new(0,1,0),Color3.new(0.8,1,0.5),"Bodoni")
newTheme("rbxassetid://708334127",0,1.01,1.25)
MAINRUINCOLOR = BrickColor.new("Br. yellowish green")
RecolorThing(MAINRUINCOLOR,BrickColor.new("Lime green"),MAINRUINCOLOR,MAINRUINCOLOR,MAINRUINCOLOR,1,MAINRUINCOLOR,1,MAINRUINCOLOR,true)
end
if k == "m" and attack == false and ModeOfGlitch == 8 and ModeOfGlitch ~= 8889 then
               ModeOfGlitch = 8889
storehumanoidWS = 180
hum.WalkSpeed = 180
rainbowmode = false
chaosmode = false
RecolorTextAndRename("CALAMITY",BrickColor.new("Alder").Color,BrickColor.new("Lilac").Color,"Antique")
newTheme("rbxassetid://1359036559",0,1.01,1.25)
MAINRUINCOLOR = BrickColor.new("Lilac")
RecolorThing(MAINRUINCOLOR,BrickColor.new("Alder"),MAINRUINCOLOR,MAINRUINCOLOR,MAINRUINCOLOR,1,MAINRUINCOLOR,1,MAINRUINCOLOR,true)
end
if k == "n" and attack == false and ModeOfGlitch == 1 and ModeOfGlitch ~= 55469696922 then
               ModeOfGlitch = 55469696922
storehumanoidWS = 275
hum.WalkSpeed = 275
rainbowmode = false
chaosmode = false
RecolorTextAndRename("NANODEATH",Color3.new(0.25,0,0.1),BrickColor.new("Hot pink").Color,"Antique")
newTheme("rbxassetid://582020393",0,1.005,1.25)
MAINRUINCOLOR = BrickColor.new("Hot pink")
RecolorThing(MAINRUINCOLOR,MAINRUINCOLOR,MAINRUINCOLOR,MAINRUINCOLOR,MAINRUINCOLOR,1,MAINRUINCOLOR,1,MAINRUINCOLOR,true)
end
if k == "n" and attack == false and ModeOfGlitch == 2 and ModeOfGlitch ~= 4367677813 then
               ModeOfGlitch = 4367677813
storehumanoidWS = 225
hum.WalkSpeed = 225
rainbowmode = false
chaosmode = false
RecolorTextAndRename("SHD",Color3.new(0.75,0.9,1),BrickColor.new("Pink").Color,"Arcade")
newTheme("rbxassetid://363284685",0,1.01,1.25)
MAINRUINCOLOR = BrickColor.new("Baby blue")
RecolorThing(MAINRUINCOLOR,BrickColor.new("Pink"),MAINRUINCOLOR,MAINRUINCOLOR,MAINRUINCOLOR,1,MAINRUINCOLOR,1,MAINRUINCOLOR,true)
end
if k == "n" and attack == false and ModeOfGlitch == 8 and ModeOfGlitch ~= 9999999921111 then
               ModeOfGlitch = 9999999921111
storehumanoidWS = 300
hum.WalkSpeed = 300
rainbowmode = false
chaosmode = false
RecolorTextAndRename("OMEGA",BrickColor.new("Really black").Color,BrickColor.new("Bright bluish green").Color,"SciFi")
newTheme("rbxassetid://643309199",0,1.01,1.25)
MAINRUINCOLOR = BrickColor.new("Bright bluish green")
RecolorThing(MAINRUINCOLOR,BrickColor.new("Really black"),MAINRUINCOLOR,MAINRUINCOLOR,MAINRUINCOLOR,1,MAINRUINCOLOR,1,MAINRUINCOLOR,true)
end
if k == "n" and attack == false and ModeOfGlitch == 4 and ModeOfGlitch ~= 999999999556 then
               ModeOfGlitch = 999999999556
storehumanoidWS = 500
hum.WalkSpeed = 500
rainbowmode = false
chaosmode = false
RecolorTextAndRename("CRAZED",BrickColor.new("Really black").Color,BrickColor.new("Navy blue").Color,"Code")
newTheme("rbxassetid://719008519",0,1.02,1.25)
MAINRUINCOLOR = BrickColor.new("Navy blue")
RecolorThing(MAINRUINCOLOR,BrickColor.new("Really black"),MAINRUINCOLOR,MAINRUINCOLOR,MAINRUINCOLOR,1,MAINRUINCOLOR,1,MAINRUINCOLOR,true)
end
if k == "n" and attack == false and ModeOfGlitch == 5 and ModeOfGlitch ~= 1264532489 then
               ModeOfGlitch = 1264532489
storehumanoidWS = 250
hum.WalkSpeed = 250
rainbowmode = false
chaosmode = false
RecolorTextAndRename("FALLENX",Color3.new(0.5,1,1),BrickColor.new("Deep orange").Color,"Antique")
newTheme("rbxassetid://1505487022",0,1.01,1.25)
MAINRUINCOLOR = BrickColor.new("Pastel green")
RecolorThing(MAINRUINCOLOR,MAINRUINCOLOR,MAINRUINCOLOR,MAINRUINCOLOR,MAINRUINCOLOR,1,MAINRUINCOLOR,1,MAINRUINCOLOR,true)
end
if k == "l" and mutedtog == false then
mutedtog = true
kan.Volume = 0
elseif k == "l" and mutedtog == true then
mutedtog = false
kan.Volume = 1.25
end
if k == "p" and toggleTag == false then
toggleTag = true
modet.TextTransparency = 0
modet.TextStrokeTransparency = 0
elseif k == "p" and toggleTag == true then
toggleTag = false
modet.TextTransparency = 1
modet.TextStrokeTransparency = 1
end
end
end)
game:GetService("RunService").Heartbeat:Connect(function()
	sine=sine+change
	modet.Rotation = -5 * math.cos(sine/32)
end)
