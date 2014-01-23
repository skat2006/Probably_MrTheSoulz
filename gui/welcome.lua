local MYFRAME_HEIGHT = 400
local MYFRAME_WIDTH = 600

-- Frame
MyFrame = CreateFrame("Frame")
MyFrame:ClearAllPoints()
MyFrame:EnableMouse(true)
MyFrame:SetMovable(true)
MyFrame:RegisterForDrag("LeftButton")
MyFrame:SetScript("OnDragStart", function(self) self:StartMoving() end)
MyFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
MyFrame:SetClampedToScreen(true)
MyFrame:SetBackdrop({
	bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
	tile = true, tileSize = 16, edgeSize = 16, 
	insets = { left = 4, right = 4, top = 4, bottom = 4 }});
MyFrame:SetBackdropColor(0,0,0,5)
MyFrame:SetHeight(MYFRAME_HEIGHT)
MyFrame:SetWidth(MYFRAME_WIDTH)
MyFrame:SetPoint("CENTER", 0, 0)
 
 -- Tittle
title = CreateFrame("Frame", nil, MyFrame)
title:SetPoint("TOP", 0, 0)
title:SetWidth(MYFRAME_WIDTH)
title:SetHeight(40)
text = title:CreateFontString(nil, "OVERLAY", "MovieSubtitleFont")
text:SetWidth(MYFRAME_WIDTH)
text:SetHeight(40)
text:SetPoint("LEFT",title)
text:SetText("Welcome to MrTheSoulz Profiles")
title:Show()

--Content
MyFrame.Content = CreateFrame("Frame", nil, MyFrame)
MyFrame.Content.texture = MyFrame.Content:CreateTexture()
MyFrame.Content.texture:SetAllPoints()
MyFrame.Content.texture:SetTexture(0,0,0,0.3)
MyFrame.Content:SetHeight(300)
MyFrame.Content:SetWidth(MYFRAME_WIDTH - 10)
MyFrame.Content:SetPoint("CENTER", 0, 0)

--Content.text
title = CreateFrame("Frame", nil, MyFrame.Content)
title:SetPoint("LEFT", 0, 135)
title:SetWidth(300)
title:SetHeight(MYFRAME_WIDTH - 10)
text = title:CreateFontString(nil, "OVERLAY", "GameFontNormal")
text:SetWidth(MYFRAME_WIDTH)
text:SetHeight(40)
text:SetPoint("LEFT",title)
text:SetText("Thank you for choosing my profiles.")
title:Show()

--Content.text2
title = CreateFrame("Frame", nil, MyFrame.Content)
title:SetPoint("LEFT", 0, 115)
title:SetWidth(300)
title:SetHeight(MYFRAME_WIDTH - 10)
text = title:CreateFontString(nil, "OVERLAY", "GameFontNormal")
text:SetWidth(MYFRAME_WIDTH)
text:SetHeight(40)
text:SetPoint("LEFT",title)
text:SetText("You can find settings using the command /mts .")
title:Show()

--Content.text3
title = CreateFrame("Frame", nil, MyFrame.Content)
title:SetPoint("LEFT", 0, 95)
title:SetWidth(300)
title:SetHeight(MYFRAME_WIDTH - 10)
text = title:CreateFontString(nil, "OVERLAY", "GameFontNormal")
text:SetWidth(MYFRAME_WIDTH)
text:SetHeight(40)
text:SetPoint("LEFT",title)
text:SetText("Current Rotations:")
title:Show()

--Content.text3
title = CreateFrame("Frame", nil, MyFrame.Content)
title:SetPoint("LEFT", 0, 75)
title:SetWidth(300)
title:SetHeight(MYFRAME_WIDTH - 10)
text = title:CreateFontString(nil, "OVERLAY", "GameFontNormal")
text:SetWidth(MYFRAME_WIDTH)
text:SetHeight(40)
text:SetPoint("LEFT",title)
text:SetText("\124cff9482C9----> \124cffF58CBAPaladin - Protection \124cff9482C9<----")
title:Show()

--Content.text4
title = CreateFrame("Frame", nil, MyFrame.Content)
title:SetPoint("LEFT", 0, 55)
title:SetWidth(300)
title:SetHeight(MYFRAME_WIDTH - 10)
text = title:CreateFontString(nil, "OVERLAY", "GameFontNormal")
text:SetWidth(MYFRAME_WIDTH)
text:SetHeight(40)
text:SetPoint("LEFT",title)
text:SetText("\124cff9482C9----> \124cffF58CBAPaladin - Holy \124cff9482C9<----")
title:Show()

--Content.text5
title = CreateFrame("Frame", nil, MyFrame.Content)
title:SetPoint("LEFT", 0, 35)
title:SetWidth(300)
title:SetHeight(MYFRAME_WIDTH - 10)
text = title:CreateFontString(nil, "OVERLAY", "GameFontNormal")
text:SetWidth(MYFRAME_WIDTH)
text:SetHeight(40)
text:SetPoint("LEFT",title)
text:SetText("\124cff9482C9----> \124cffC41F3BDeathKnight - Blood \124cff9482C9<----")
title:Show()

--Content.text6
title = CreateFrame("Frame", nil, MyFrame.Content)
title:SetPoint("LEFT", 0, 15)
title:SetWidth(300)
title:SetHeight(MYFRAME_WIDTH - 10)
text = title:CreateFontString(nil, "OVERLAY", "GameFontNormal")
text:SetWidth(MYFRAME_WIDTH)
text:SetHeight(40)
text:SetPoint("LEFT",title)
text:SetText("\124cff9482C9----> \124cffFF7D0ADruid - Restoration \124cff9482C9<----")
title:Show()

--Content.text7
title = CreateFrame("Frame", nil, MyFrame.Content)
title:SetPoint("LEFT", 0, - 5)
title:SetWidth(300)
title:SetHeight(MYFRAME_WIDTH - 10)
text = title:CreateFontString(nil, "OVERLAY", "GameFontNormal")
text:SetWidth(MYFRAME_WIDTH)
text:SetHeight(40)
text:SetPoint("LEFT",title)
text:SetText("\124cff9482C9----> \124cffFF7D0ADruid - Guardian \124cff9482C9<----")
title:Show()

-- Close Button
local button = CreateFrame("Button", nil, MyFrame)
button:SetPoint("BOTTOM", MyFrame, "BOTTOM", 0, 10)
button:SetWidth(100)
button:SetHeight(25)
button:SetText("Close")
button:SetNormalFontObject("GameFontNormal")
button:SetScript("OnClick", function(self) MyFrame:Hide() end)
    -- Button Textures
local closeButton1 = button:CreateTexture()
closeButton1:SetTexture(0,0,0,1)
closeButton1:SetTexCoord(0, 0.625, 0, 0.6875)
closeButton1:SetAllPoints() 
button:SetNormalTexture(closeButton1)
local closeButton2 = button:CreateTexture()
closeButton2:SetTexture(0.5,0.5,0.5,1)
closeButton2:SetTexCoord(0, 0.625, 0, 0.6875)
closeButton2:SetAllPoints()
button:SetHighlightTexture(closeButton2)
local closeButton3 = button:CreateTexture()
closeButton3:SetTexture(0,0,0,1)
closeButton3:SetTexCoord(0, 0.625, 0, 0.6875)
closeButton3:SetAllPoints()
button:SetPushedTexture(closeButton3)