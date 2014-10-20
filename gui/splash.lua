--[[ ///---INFO---////
// Alerts GUI //
Thank Your For Your My ProFiles
I Hope Your Enjoy Them
MTS
]]

local backdrop = {
  -- path to the background texture
  bgFile = "Interface\\AddOns\\Probably_MrTheSoulz\\media\\splash.tga",  
  -- path to the border texture
  edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Gold-Border",
  -- true to repeat the background texture to fill the frame, false to scale it
  tile = false,
  -- size (width or height) of the square repeating background tiles (in pixels)
  tileSize = 0,
  -- thickness of edge segments and square size of edge corners (in pixels)
  edgeSize = 1,
  -- distance from the edges of the frame to those of the background texture (in pixels)
  insets = {
    left = 11,
    right = 12,
    top = 12,
    bottom = 11
  }
  }

mtsSlpash = CreateFrame("Frame", nil,UIParent)
mtsSlpash:SetPoint("CENTER",UIParent)
mtsSlpash:SetWidth(512)
mtsSlpash:SetHeight(256)
mtsSlpash:SetBackdrop(backdrop)
mtsSlpash:Hide()
mtsSlpash.time = 0

local function onUpdate(self,elapsed) 
	if self.time < GetTime() - 2.0 then
		if self:GetAlpha() == 0 then
			self:Hide()
		else 
			self:SetAlpha(self:GetAlpha() - .05)
		end
	end
end

function mtsSlpash()
	self:SetAlpha(1)
	self.time = GetTime() 
	self:Show() 
end

