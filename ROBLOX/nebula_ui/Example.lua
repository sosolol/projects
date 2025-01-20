--[[
local Window = Library:Window({})

do 
	local Pages = {
		["Aiming"] = Window:Page({Name = "Aiming", Icon = "rbxassetid://6034509987"});
		["Rage"] = Window:Page({Name = "Anti Aim", Icon = "rbxassetid://17134553802"});
		["Renders"] = Window:Page({Name = "Renders", Icon = "rbxassetid://6031079158"});
		["World"] = Window:Page({Name = "World", Icon = "rbxassetid://6026568213"});
		["Misc"] = Window:Page({Name = "Misc", Icon = "rbxassetid://6031280883"});
		["Players"] = Window:Page({Name = "Playerlist", Icon = "rbxassetid://6034281935"});
		["LocalPlayer"] = Window:Page({Name = "LocalPlayer", Icon = "rbxassetid://6034281935"});
		["Settings"] = Window:Page({Name = "Settings", Icon = "rbxassetid://6031280882"});
	} 
	 
	do -- Aiming
		do
			do 
				local Enabled = Pages["Aiming"]:Section({Name = "Main", Side = "Left", Zindex = 3}); 
				Enabled:Toggle({Name = "Enabled", Flag = "Main Enabled"})
				Enabled:Keybind({Name = "Keybind", Flag = "Silent Bind", Default = Enum.KeyCode.End, Callback = function(Bool)
				end})
			end 

			do -- Silent Aim Multi Section
				local TextBox, Single_HitPart, Multi_HitParts, Jump_Prediction, Air_Part, Delay, Type; 
				
				do -- Silent Aim
					local Silent_Aim, Advanced = Pages["Aiming"]:MultiSection({Sections = {"Main", "Advanced"}, Side = "Left", Zindex = 3})
					do -- Main
						Silent_Aim:Toggle({Name = "Silent Aim", Flag = "Silent Aim"})
						Silent_Aim:Toggle({Name = "Auto Select Target", Flag = "Auto Select Target", Callback = function(Bool) if (Delay and Type) then Type:SetVisible(Bool) Delay:SetVisible(Bool) end end})
						Type = Silent_Aim:List({Name = "Mode", Options = {"Mouse", "Distance"}, Default = "Closest To Cursor Position"}); Type:SetVisible(false)
						Delay = Silent_Aim:Slider({Name = "Delay", Suffix = "ms", Flag = "Auto Select Delay", Min = 0, Max = 1000, Default = 100}); Delay:SetVisible(false)
						Silent_Aim:List({Name = "Prediction Type", Flag = "Prediction Type Silent Aim", Options = {"Auto", "Manual"}, Default = "Manual", Callback = function(Option) if not TextBox then return end; if (Option == "Auto" and TextBox) then TextBox:SetVisible(false) else TextBox:SetVisible(true) end end})
						TextBox = Silent_Aim:Textbox({Name = "Prediction", Flag = "Manual Prediction"})
						Silent_Aim:Toggle({Name = "Use Closest Part", Flag = "Nearest Part", Callback = function(Bool) if (Multi_HitParts and Single_HitPart) then Multi_HitParts:SetVisible(Bool) Single_HitPart:SetVisible(not Bool) end  end})
						Single_HitPart = Silent_Aim:List({Name = "Hit Box Selection", Flag = "Single Hit Part", Options = {"123"}, Default = "HumanoidRootPart"})
						Silent_Aim:Toggle({Name = "Prefer body aim if lethal", Flag = "Silent Aim"})
						Multi_HitParts = Silent_Aim:List({Name = "Hit Box Selection", Flag = "Closest Hit Part",Options = {"123"}, Default = {"HumanoidRootPart"}, Max = 9e9})
						Multi_HitParts:SetVisible(false)
					end 
					 
					do -- Advanced
						Advanced:Toggle({Name = "Look At", Flag = "Look At"})
						Advanced:Toggle({Name = "Auto Fire", Flag = "Auto Fire"})
						Advanced:Toggle({Name = "Spectate", Flag = "Spectate"})
						Advanced:Toggle({Name = "Notify", Flag = "Notify"})
						Advanced:Toggle({Name = "Aim-Viewer Bypass", Flag = "Aim-Viewer Bypass"})
						Advanced:Toggle({Name = "Jump Offset", Flag = "Jump Prediction", Callback = function(Bool)
							if (Jump_Prediction) then 
								Jump_Prediction:SetVisible(Bool)
							end 
						end})
						Jump_Prediction = Advanced:Textbox({Name = "Jump Prediction", Flag = "Manual Offset Value", Placeholder = "Jump Offset"})
						Jump_Prediction:SetVisible(false)
						Advanced:Toggle({Name = "Air Part", Flag = "Air Part", Callback = function(Bool)
							if (Air_Part) then 
								Air_Part:SetVisible(Bool)
							end 
						end})
						
						Air_Part = Advanced:List({Name = "Air Hit-Part", Flag = "Air Hit Part", Options = {"123"}, Default = "RightFoot"})
						Air_Part:SetVisible(false)
					end 
				end 
			end 
		end 
		
		do 
			local TextBox, Single_HitPart, Multi_HitParts, Jump_Prediction, Air_Part, Delay, Mouse_1, Mouse_2, Camera; 
			do
				local Aim_Assist, Advanced = Pages["Aiming"]:MultiSection({Sections = {"Aim Assist", "Advanced"}, Side = "Right"})
				-- Aim Assist
				do 
					Aim_Assist:Toggle({Name = "Enabled", Flag = "Aim Assist Enabled"}) 
					Aim_Assist:List({Name = "Prediction Type", Flag = "Prediction Type", Options = {"Auto", "Manual"}, Default = "Manual", Callback = function(Option) if not TextBox then return end; if (Option == "Auto" and TextBox) then TextBox:SetVisible(false) else TextBox:SetVisible(true) end  end})
					Aim_Assist:Textbox({Name = "Prediction", Flag = "Manual Prediction Aim Assist"})
					Aim_Assist:Toggle({Name = "Use Closest Part", Flag = "Nearest Part Aim Assist", Callback = function(Bool) if (Multi_HitParts and Single_HitPart) then Multi_HitParts:SetVisible(Bool) Single_HitPart:SetVisible(not Bool) end end})
					Single_HitPart = Aim_Assist:List({Name = "Hit-Part", Flag = "Aim Assist Single Hit Part", Options = {"123"}, Default = "HumanoidRootPart"})
					Multi_HitParts = Aim_Assist:List({Name = "Closest Hit Part", Flag = "Aim Assist Closest Hit Part", Options = {"123"}, Default = {"HumanoidRootPart"}, Max = 9e9}); Multi_HitParts:SetVisible(false)
					Aim_Assist:Slider({Name = "Stutter", Suffix = "ms", Min = 0, Max = 100, Default = 0, Flag = "Aim Assist Stutter"})
				end 

				do -- Advanced
					Advanced:Toggle({Name = "Use Mouse", Flag = "Use Mouse", Callback = function(Bool) if (Mouse_1 and Mouse_2 and Camera) then Mouse_1:SetVisible(Bool) Mouse_2:SetVisible(Bool) Camera:SetVisible(not Bool) end end}) 
					Mouse_1 = Advanced:Slider({Name = "Horizontal Smoothing", Suffix = "%", Min = 1, Max = 100, Default = 1, Flag = "Horizontal Smoothing"}); Mouse_1:SetVisible(false)
					Mouse_2 = Advanced:Slider({Name = "Vertical Smoothing", Suffix = "%", Min = 1, Max = 100, Default = 1, Flag = "Vertical Smoothing"}); Mouse_2:SetVisible(false)
					Camera = Advanced:Slider({Name = "Smoothing", Suffix = "%", Min = 1, Max = 100, Default = 1, Flag = "Smoothing"})
					Advanced:Toggle({Name = "Jump Offset", Flag = "Jump Offset Aim Assist", Callback = function(Bool) if (Jump_Prediction) then Jump_Prediction:SetVisible(Bool) end end})
					Jump_Prediction = Advanced:Textbox({Name = "Offset Value", Flag = "Manual Offset Value Aim Assist", Placeholder = "Jump Offset"}); Jump_Prediction:SetVisible(false)
					Advanced:Toggle({Name = "Air Part", Flag = "Air Part Aim Assist", Callback = function(Bool) if (Air_Part) then Air_Part:SetVisible(Bool) end end})
					Air_Part = Advanced:List({Name = "Air Hit-Part", Flag = "Air Hit Part", Options = {"123"}, Default = "RightFoot"}) Air_Part:SetVisible(false)
				end 
			end 	
			 
			do -- Resolver
				local Resolver = Pages["Aiming"]:Section({Name = "Resolver", Zindex = 9999, Side = "Right"}) 	
				Resolver:Toggle({Name = "Resolver", Flag = "Resolver"})
			end 
			 
			do -- Checks
				local Checks = Pages["Aiming"]:Section({Name = "Checks", Side = "Right"}) 	
				Checks:List({Name = "Checks", Flag = "Checks", Options = {"Knocked", "Wall", "Friend", "Grabbed", "ForceField"}, Max = 3})
			end 		
		end 
	end 	
	 
	do -- Rage 
		local Deysnc, Desync_Settings, Desync_Visualize = Pages["Rage"]:MultiSection({Sections = {"Spoofer", "Settings", "Visualize"}, Zindex = 5}) do  

			do -- Visualize
				local Textures, Reflectance; 
				Desync_Visualize:Toggle({Name = "Visualize", Flag = "Desync Visualize"}):Colorpicker({Default = Color3.fromHex("#ffffff"), Flag = "Desync Cham Part Color", Alpha = 0});
				local VisualizeHighlight = Desync_Visualize:Toggle({Name = "Highlight", Flag = "Desync Cham Highlight", Default = true})
				VisualizeHighlight:Colorpicker({Default = Color3.fromHex("#7D0DC3"), Flag = "Desync Cham Fill Color", Alpha = 0.5});
				VisualizeHighlight:Colorpicker({Default = Color3.fromHex("#000000"), Flag = "Desync Cham Outline Color", Alpha = 0});
				Desync_Visualize:List({Name = "Material", Flag = "Desync Cham Material", Options = {"ForceField", "Neon", "Plastic"}, Default = "ForceField", Callback = function(Option)
					if (Textures and Reflectance) then 
						Textures:SetVisible(Option == "ForceField" and true or false)
						Reflectance:SetVisible(Option == "Plastic" and true or false)
					end 
				end});	
				Reflectance = Desync_Visualize:Slider({Name = "Reflectance", Flag = 'Desync Cham Reflectance', Min = 0, Max = 1, Default = 0, Decimals = 0.01, Suffix = ""}) Reflectance:SetVisible(false)
				Textures = Desync_Visualize:List({Name = "Texture", Flag = "Desync Cham Material Texture", Options = {"Web", "Swirl", "Checkers", "CandyCane", "Dots", "Scanning", "Bubbles", "Player FF Texture", "Shield Forcefield", "Water", "None"}, Default = "Swirl"})
			end 
		end 

		local Exploits, AntiLock = Pages["Rage"]:MultiSection({Sections = {"Exploits", "Anti Lock"}, Zindex = 5, Side = "Right"}) do 
			do -- Exploits
				Exploits:Toggle({Name = "Physics Desync", Flag = "Fast Flags"})
				Exploits:Slider({Name = "Amount", Flag = 'Fast Flags Amount', Min = 1, Max = 15, Default = 2, Decimals = 1})
				Exploits:Toggle({Name = "Network Desync", Flag = "Network Desync"})
				Exploits:Slider({Name = "Delay", Flag = 'Network Delay', Suffix = "s", Min = 0.01, Max = 15, Default = 2, Decimals = 0.01})
				Exploits:Toggle({Name = "Destroy Cheaters", Flag = "Destroy Cheaters"}):Keybind({Name = "Destroy Cheaters Key", Flag = "Destroy Cheaters Key", Mode = "Toggle", Callback = function()
				end})
				Exploits:List({Name = "Mode", Flag = "Destroy Cheaters Mode", Options = {"Basic", "Bypass", "Kill"}, Default = "Basic"})
				Exploits:Toggle({Name = "Safe Mode", Flag = "Network Desync"})
			end 

			do -- Anti Lock
				AntiLock:Toggle({Name = "Enabled", Flag = "Anti Lock", Callback = function(Bool)
				end}):Keybind({Name = "Anti Lock", Flag = "Anti Lock Key", Mode = "Toggle", Callback = function(Bool)
				end})
				AntiLock:List({Name = "Type", Flag = "Anti Lock Type", Options = {"Random", "HvH", "Sky", "Velocity Cap"}, Default = "HvH"})
				AntiLock:Slider({Name = "Random Range", Flag = 'Anti Lock Random Range', Min = 0, Max = 100, Default = 0, Decimals = 1, Suffix = "st"})
			end 
		end 
	end 
	 
	do -- Visuals
		do
			local EspSettings, Crosshair, FieldOfView = Pages["Renders"]:MultiSection({Sections = {"Esp", "Crosshair", "Fov"}, Zindex = 5, Side = "Left"}) 
			do 
				
			end 	
			-- 
			do 
				
			end		
			-- 
			do 
			end 
		end 

		do
			local Hit_Effects, Target = Pages["Renders"]:MultiSection({Sections = {"Hit Effects", "Target Visuals"}, Zindex = 5, Side = "Right"}) 
			do 
				local HitCham; 
				local Reflectance;  
				local Textures; 
				Hit_Effects:List({Name = "Hit Marker", Flag = "Hit Marker", Options = {"3D", "2D", "Damage"}, Max = 9e9})
				Hit_Effects:Colorpicker({Nmae = "3D", Default = Color3.fromRGB(255, 0, 0), Transparency = 1, Flag = "3D Color"});
				Hit_Effects:Colorpicker({Nmae = "2D", Default = Color3.fromRGB(255, 0, 0), Transparency = 1, Flag = "2D Color"});
				Hit_Effects:Colorpicker({Nmae = "Damage", Default = Color3.fromRGB(255, 0, 0), Transparency = 1, Flag = "Damage Color"});
				Hit_Effects:Toggle({Name = "Hit Effects", Flag = "Hit Effects"}):Colorpicker({Default = Color3.fromRGB(255,255,255), Flag = "Hit Effect Settings"});
				Hit_Effects:List({Name = "Hit Effects", Flag = "Hit Effect", Options = {--[["Confetti" "Nova", "Sparkle", "Splash", "Slash", "Detailed Slash", "Electric", "Electric 2"}, Default = "Confetti"})
				Hit_Effects:Toggle({Name = "Hit Chams", Flag = "Hit Chams"}):Colorpicker({Default = Color3.fromRGB(255, 0, 0), Transparency = 0.8, Flag = "Hit Chams Settings"});
				local VisualizeHighlight = Hit_Effects:Toggle({Name = "Highlight", Flag = "Hit Cham Highlight", Default = true})
				VisualizeHighlight:Colorpicker({Default = Color3.fromHex("#7D0DC3"), Flag = "Hit Cham Fill Color", Alpha = 0.5});
				VisualizeHighlight:Colorpicker({Default = Color3.fromHex("#000000"), Flag = "Hit Cham Outline Color", Alpha = 0});
				Hit_Effects:List({Name = "Material", Flag = "Hit Cham Material", Options = {"ForceField", "Neon", "Plastic"}, Default = "ForceField", Callback = function(Option)
					if (Textures and Reflectance) then 
						Textures:SetVisible(Option == "ForceField" and true or false)
						Reflectance:SetVisible(Option == "Plastic" and true or false)
					end 
				end});	
				Reflectance = Hit_Effects:Slider({Name = "Reflectance", Flag = 'Hit Cham Reflectance', Min = 0, Max = 1, Default = 0, Decimals = 0.01, Suffix = ""}) Reflectance:SetVisible(false)
				Textures = Hit_Effects:List({Name = "Texture", Flag = "Hit Cham Material Texture", Options = {"Web", "Swirl", "Checkers", "CandyCane", "Dots", "Scanning", "Bubbles", "Player FF Texture", "Shield Forcefield", "Water", "None"}, Default = "Swirl"})					
				Hit_Effects:Toggle({Name = "Hit-Logs", Flag = "Hit Notify"})
				Hit_Effects:Toggle({Name = "Fading", Flag = "Fading"});
				Hit_Effects:Slider({Name = "Fading Time", Flag = 'Fading Time', Min = 0.1, Max = 10.0, Default = 5.0, Decimals = 0.1});
			end 
			-- 
			do 
				local Line = Target:Toggle({Name = "Line", Flag = "Line Enabled"}); Line:Colorpicker({Default = Color3.fromRGB(255,0,0), Flag = "Line Inline Color"}); Line:Colorpicker({Default = Color3.fromRGB(255,0,0), Flag = "Line Outline Color"});
				Target:Slider({Name = "Thickness", Flag = 'Line Thickness', Min = 0, Max = 3, Default = 1, Decimals = 0.01});
				local Highlight = Target:Toggle({Name = "Highlight", Flag = "Highlight Enabled"}); Highlight:Colorpicker({Default = Color3.fromRGB(0,255,0), Alpha = 0.5, Flag = "Highlight Fill Color"}); Highlight:Colorpicker({Default = Color3.fromRGB(0,125,0), Flag = "Highlight Outline Color"});
				local BackTrack = Target:Toggle({Name = "Backtrack", Flag = "Back Track Enabled"}); BackTrack:Colorpicker({Default = Color3.fromRGB(255, 0, 0), alpha = 0.65, Flag = "Back Track Settings"}); 	
				Target:List({Name = "Method", Flag = "Back Track Method", Options = {"Clone", "Follow"}, Default = "Follow"}); 	
				Target:List({Name = "Material", Flag = "Back Track Material", Options = {"Neon", "Plastic", "ForceField"}, Default = "Neon"}); 	
				Target:Toggle({Name = "3D Box", Flag = "3D Box"}):Colorpicker({Default = Color3.fromRGB(255,0,0), Flag = "3D Box Color", Callback = function()  end});	
			end 
		end 
	end 
	 
	do -- World
		do
			local Gun = Pages["World"]:Section({Name = "Gun", Size = 330, Side = "Left"}) do 	
				local TracersColor; 
				Gun:Toggle({Name = "Gun Chams", Flag = "Gun Chams"}):Colorpicker({Default = Color3.fromRGB(255,255,255), Flag = "Gun Cham Color"});
				Gun:Toggle({Name = "Gun Spin", Flag = "Gun Spin"})
				Gun:Slider({Name = "Rate", Flag = 'Tracers Life Time', Min = 0, Max = 10, Default = 1, Decimals = 0.1})
				Gun:Toggle({Name = "Tracers", Flag = "Tracers"}):Colorpicker({Default = Color3.fromRGB(255,255,255), Flag = "Tracers Color"}); 
				Gun:List({Name = "Type", Flag = "Tracers Type", Options = {"Static", "Party"}, Default = "Static"})
				Gun:List({Name = "Texture", Flag = "Tracers Texture", Options = {"Double Helix", "Electric", "Electric + Glow", "Fade", "Glow", "Pulsate", "Red Lazer", "Smoke", "Thin Electric", "Vibrate", "Warp", "scotland dildo"}, Default = "Electric"})
				Gun:Slider({Name = "Curve Start", Flag = 'Curve Size 0', Min = 0, Max = 10, Default = 0, Decimals = 0.1})
				Gun:Slider({Name = "Curve End", Flag = 'Curve Size 1', Min = 0, Max = 10, Default = 0, Decimals = 0.1})
				Gun:Slider({Name = "Life Time", Flag = 'Tracers Life Time', Min = 0, Max = 10, Default = 5, Decimals = 0.1})
				Gun:Slider({Name = "Brightness", Flag = 'Tracers Brightness', Min = 0, Max = 1, Default = 0.99, Decimals = 0.01})
			end	
		end 

		do
			local World = Pages["World"]:Section({Name = "Environment", Size = 330, Side = "Right"}) do 	

			end 
			 
			local Correction = Pages["World"]:Section({Name = "Color Correction Effect", Size = 330, Side = "Right"}) do 	

            end 
		end 
	end 
	 
	do -- Misc
		do
			local Movement = Pages["Misc"]:Section({Name = "Movement", Size = 330, Side = "Left", Zindex = 1000}) do
				Movement:Toggle({Name = "Speed", Flag = "Speed Enabled"}):Keybind({Name = "Speed", Flag = "Speed Key", Mode = "Toggle"})
				Movement:Toggle({Name = "Auto-Jump", Flag = "Auto Jump"})
				Movement:Slider({Name = "Speed", Flag = 'Speed', Min = 0, Max = 100, Default = 20, Decimals = 1})
				Movement:Toggle({Name = "Fly", Flag = "Fly Enabled"}):Keybind({Name = "Fly", Flag = "Fly Key", Mode = "Toggle"})
				Movement:Slider({Name = "Fly", Flag = 'Fly Speed', Min = 0, Max = 100, Default = 20, Decimals = 1})
			end 
			 
			local Camera = Pages["Misc"]:Section({Name = "Camera", Size = 330, Side = "Left", Zindex = 13}) do
				local oldFieldOfView, Amount = workspace.CurrentCamera.FieldOfView, nil;
				Camera:Toggle({Name = "Zoom", Flag = "Zoom", Callback = function(Bool) 
					if (Amount) then 
						Amount:SetVisible(Bool)
					end 
				end}):Keybind({Name = "Zoom", Flag = "Optifine Key", Mode = "Hold", UseKey = true, Callback = function()

				end})
				Amount = Camera:Slider({Name = "Zoom", Flag = 'Zoom Amount', Min = 0, Max = 100, Default = 5, Decimals = 1})
				Camera:Toggle({Name = "Aspect Ratio", Flag = "Aspect Ratio"})
				Camera:Slider({Name = "Vertical", Flag = 'Vertical', Min = 0, Max = 100, Default = 20, Decimals = 1})
				Camera:Slider({Name = "Horizontal", Flag = 'Horizontal', Min = 0, Max = 100, Default = 20, Decimals = 1})
				Camera:Toggle({Name = "Motion Blur", Flag = "Motion Blur"})
				Camera:Slider({Name = "Intensity", Flag = 'Intensity', Min = 0, Max = 100, Default = 15, Decimals = 1})
			end 			
		end 
		
		do
			local Hit_Sounds = Pages["Misc"]:Section({Name = "Hit Sounds", Size = 330, Side = "Right"}) do
				Hit_Sounds:Toggle({Name = "Hit Sounds", Flag = "Hit Sounds"})
				Hit_Sounds:List({Name = "Hit Sounds", Flag = "Hit Sounds Sound", Options = sfx_names, Default = "Neverlose"})
				Hit_Sounds:Slider({Name = "Volume", Flag = 'Hit Sounds Volume', Min = 0.1, Max = 10.0, Default = 5.0, Decimals = 0.1})
				Hit_Sounds:Slider({Name = "Pitch", Flag = 'Hit Sounds Pitch', Min = 0.1, Max = 10.0, Default = 1.0, Decimals = 0.1})
				 
				Hit_Sounds:Toggle({Name = "Shoot Sounds", Flag = "Shoot Sounds"})
				Hit_Sounds:List({Name = "Shoot Sounds", Flag = "Shoot Sounds Sound", Options = Sounds, Default = "Neverlose"})
				Hit_Sounds:Slider({Name = "Volume", Flag = 'Shoot Sounds Volume', Min = 0.1, Max = 10.0, Default = 5.0, Decimals = 0.1})
				Hit_Sounds:Slider({Name = "Pitch", Flag = 'Shoot Sounds Pitch', Min = 0.1, Max = 10.0, Default = 1.0, Decimals = 0.1})
			end
			 
			local IndicatorSettings = Pages["Misc"]:Section({Name = "Indicators", Size = 330, Side = "Right", Zindex = 12}) do
				IndicatorSettings:Toggle({Name = "Target Indicators", Flag = "Target Indicators"})
				IndicatorSettings:Toggle({Name = "Watermark", Flag = "Watermark"})
			end 
		end 
	end 
	 
	do -- Settings
		local Config = Pages["Settings"]:Section({Name = "Config"})
		local ConfigList = Config:List({Name = "Config", Flag = "SettingConfigurationList", Options = {}})
		Config:Textbox({Flag = "SettingsConfigurationName", Name = "Config Name"})
		Config:Button({Name = "Save"})
		Config:Button({Name = "Load"})
		Config:Button({Name = "Delete"})
		Config:Button({Name = "Refresh"})
		Config:Keybind({Name = "Menu Key", Flag = "MenuKey", Ignore = true, UseKey = true, Default = Enum.KeyCode.End, Callback = function(State) Library.UIKey = State end})
		Config:Colorpicker({Name = "Menu Accent", Flag = "MenuAccent", Default = Library.Accent, Callback = function(State) Library:ChangeAccent(State) end})
		Config:Toggle({Name = "Keybind List", Callback = function(state) Library.KeyList:SetVisible(state) end}) 
	end
end]]