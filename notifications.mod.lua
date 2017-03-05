--[[
	jNotifications module
	
	
	usage:
	<<<	
	    local jNoti = require(680538702)
		
		
		local not = jNoti.alert(
			UDim2.new(0, 50, 0, 100), -- you can freely position alerts
			"Title", -- self-explainatory
			"Sample Text, will cause scrolling for large walls of text on an Alert", -- body text
			{"Yes", "No", "Maybe"}, -- buttons
			function(text) -- button click callback
			
			end,
			
		)
		
		
		local msg = jNoti.message(
			"bottomright" -- location, "topleft", "bottomright" etc.
			"Title", -- title, duh
			"Sample text, this should be rather short, it will get cut off", -- body text
			3 -- stay time
		)
		
	>>> 
--]]

-- load GUIs beforehand
local insertService = game:GetService("InsertService")

local alertGUI = insertService:LoadAsset(681163571).NotiMenu

local module = {}

print("| jNotifications v0.01")
print("| Written by MadScien1st")
print("| @scientiist")

function module.alert(origin, title, text, buttons, callback)
	local gui = game.Players.LocalPlayer.PlayerGui
	
	game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
	
	
	local self = setmetatable({}, module)
	
	
	self.obj = script.NotiMenu:Clone()
	
	self.obj.Parent = gui
	
	self.obj.Frame.Title.Text = title
	
	
	self.obj.Frame.ScrollingFrame.TextLabel.Text = text
	
	self.obj.Frame.Position = origin
	
	self.obj.Frame.ScrollingFrame.CanvasSize = UDim2.new(0,0,0,self.obj.Frame.ScrollingFrame.TextLabel.TextBounds.Y + 20)
	
	if buttons then
		for inc, obj in pairs(buttons) do
			local this = self.obj.Frame.TextButton:Clone()
			this.Position = UDim2.new(0.05 +((inc-1)*0.22), 0, 0.8, 0)
			this.Text = obj
			this.MouseButton1Up:connect(function()
				callback(obj)
				self:Destroy()
			end)
			this.Parent = self.obj.Frame
		end
	end
	
	self.obj.Frame.TextButton:Destroy()
	
	
	
	self.Destroy = function(self)
		self.obj:Destroy()
		game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
	end
	
	return self
end

return module
