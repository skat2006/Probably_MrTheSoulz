--[[ ///---INFO---////
// Main GUI //
mConfig copyright & thanks to https://github.com/kirk24788/mConfig
Modified by: MTS
Thank Your For Your My ProFiles
I Hope Your Enjoy Them
MTS
]]

local mts_VERSION = "\124cff9482C9*[MTS] \124cffFFFFFFVersion: 0.8.15\124cff9482C9*"
local mConfigVersion = 1
if M_CONFIG_VERSION == nil or MCONFIG_VERSION < mConfigVersion then
local DISPLAYED_OPTIONS = 10
local OPTIONS_HEIGHT = 40
local OPTIONS_WIDTH = 600
MCONFIG_VERSION = mConfigVersion
mConfig = {}
mConfigData = {}
mConfigAllConfigs = {}

local frame = CreateFrame("Frame")
frame:RegisterEvent("VARIABLES_LOADED")
frame:SetScript("OnEvent", function()
    for _,c in pairs(mConfigAllConfigs) do
        if mConfigData[c.addOn] then
            c.values=mConfigData[c.addOn][c.key]
            c:update()
--       else
--            print(c.addOn)
        end
    end
end)

local _nextElementId = 1
local function nextElementId()
    local name = "MCONFIG_ELEMENT_" .. _nextElementId
    _nextElementId = _nextElementId + 1
    return name
end

local function addTooltip(frame, title, text)
    if text and title then
        frame:SetScript("OnEnter",  function (self)
            GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
            GameTooltip:SetText(title)
            GameTooltip:AddLine(text, 1, 1, 1)
            GameTooltip:Show()
        end)

        frame:SetScript("OnLeave",  function (self)
            GameTooltip:Hide()
        end)
    end
end

function mConfig:addText(text, tooltip)

    local optionFrame = CreateFrame("Frame", nil, self.frames.scrollFrame)
    optionFrame:SetSize(OPTIONS_WIDTH, OPTIONS_HEIGHT)
    addTooltip(optionFrame, text, tooltip)

    local optionText = optionFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    optionText:SetPoint("LEFT",optionFrame,20,-6)
    optionText:SetWidth(OPTIONS_WIDTH-40)
    optionText:SetHeight(OPTIONS_HEIGHT)
    optionText:SetText("|cffFFFFFF" ..text)
    optionText:SetJustifyH("CENTER")
    optionText:SetJustifyV("CENTER")
    
    table.insert(self.frames.options, optionFrame)
end

function mConfig:addText2(text, tooltip)

    local optionFrame = CreateFrame("Frame", nil, self.frames.scrollFrame)
    optionFrame:SetSize(OPTIONS_WIDTH, OPTIONS_HEIGHT)
    addTooltip(optionFrame, text, tooltip)

    local optionText = optionFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    optionText:SetPoint("LEFT",optionFrame,20,-6)
    optionText:SetWidth(OPTIONS_WIDTH-40)
    optionText:SetHeight(OPTIONS_HEIGHT)
    optionText:SetText("|cffFFFFFF" ..text)
    optionText:SetJustifyH("LEFT")
    optionText:SetJustifyV("LEFT")
    
    table.insert(self.frames.options, optionFrame)
end

function mConfig:addTitle(text, tooltip)

    local optionFrame = CreateFrame("Frame", nil, self.frames.scrollFrame)
    optionFrame:SetSize(OPTIONS_WIDTH, OPTIONS_HEIGHT)
	optionFrame.texture = optionFrame:CreateTexture()
	optionFrame.texture:SetAllPoints()
	optionFrame.texture:SetTexture(0,0,0,0.5) 
    addTooltip(optionFrame, text, tooltip)

    local optionText = optionFrame:CreateFontString(nil, "OVERLAY", "MovieSubtitleFont")
    optionText:SetPoint("LEFT",optionFrame,0,0)
    optionText:SetWidth(OPTIONS_WIDTH)
    optionText:SetHeight(OPTIONS_HEIGHT)
    optionText:SetText(text)
    optionText:SetJustifyH("CENTER")
    optionText:SetJustifyV("CENTER")
    
    table.insert(self.frames.options, optionFrame)
end

function mConfig:addCheckBox(key, text, tooltip, defaultValue)
    if not defaultValue then defaultValue = false end
    if not self.values[key] then self.values[key] = defaultValue end

    local optionFrame = CreateFrame("Frame", nil, self.frames.scrollFrame)
    optionFrame:SetSize(OPTIONS_WIDTH, OPTIONS_HEIGHT)
    addTooltip(optionFrame, text, tooltip)

    local checkbutton = CreateFrame("CheckButton", nil, optionFrame, "ChatConfigSmallCheckButtonTemplate")
    checkbutton:SetHitRectInsets(4,4,4,4);
    checkbutton:SetPoint("RIGHT",optionFrame,-30,-5)
    --checkbutton.tooltip = tooltip
    checkbutton:SetChecked(defaultValue)
    checkbutton:SetScript("OnClick", function()
        self.values[key] = checkbutton:GetChecked(defaultValue) == 1
    end)
   -- checkbutton:SetWidth(30)
    optionFrame:Show()

    local optionText = optionFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    optionText:SetPoint("LEFT",optionFrame,20,-6)
    optionText:SetWidth(OPTIONS_WIDTH-80)
    optionText:SetHeight(OPTIONS_HEIGHT)
    optionText:SetText("|cffFFFFFF" ..text)
    optionText:SetJustifyH("LEFT")
    
    self.defaults[key] = defaultValue
    table.insert(self.frames.options, optionFrame)
    self.setters[key] = function(v) checkbutton:SetChecked(v) end
    self.update(self)
end

function mConfig:update()
    local numItems = #(self.frames.options)
    FauxScrollFrame_Update(self.frames.scrollFrame, numItems, DISPLAYED_OPTIONS, OPTIONS_HEIGHT)
    local offset = FauxScrollFrame_GetOffset(self.frames.scrollFrame) + 1
    for key,value in pairs(self.values) do
        if self.setters[key] then 
            self.setters[key](value) 
        end
    end
    for line = 1, numItems do
        local option = self.frames.options[line]
        if line < offset then
            option:Hide()
        elseif line == offset then
            option:SetPoint("TOP", self.frames.scrollFrame,0,-5)
            option:Show()
        elseif line >= offset + DISPLAYED_OPTIONS then
            option:Hide()
        else
            option:SetPoint("TOP", self.frames.options[line - 1], "BOTTOM")
            option:Show()
        end
    end
end

function mConfig:Show()
    self.frames.configFrame:Show()
end

function mConfig:Hide()
    self.frames.configFrame:Hide()
end

function mConfig:Toggle()
    if self.frames.configFrame:IsShown() then
        self.frames.configFrame:Hide()
    else
        self.frames.configFrame:Show()
    end
end

function mConfig:get(key)
    return self.values[key]
end

function mConfig:set(key, value)
    self.values[key] = value
    return self:update()
end

function mConfig:defaultValues()
    for k,v in pairs(self.defaults) do
        self.values[k] = v
    end
    return self:update()
end

function mConfig:createConfig(titleText,addOn,key,slashCommands)
    if not key then key = "Default" end
    if not mConfigData[addOn] then mConfigData[addOn] = {} end
    if not mConfigData[addOn][key] then mConfigData[addOn][key] = {} end
    local data = {
        frames={options={}},
        addOn=addOn,
        key=key,
        values=mConfigData[addOn][key],
        defaults={},
        setters={},
    }
    table.insert(mConfigAllConfigs, data)
    setmetatable(data, self)
    self.__index = self
    data.frames.configFrame = CreateFrame("Frame", nil,UIParent)
    data.frames.configFrame:SetPoint("CENTER",UIParent)
    data.frames.configFrame:EnableMouse(true)
    data.frames.configFrame:SetMovable(true)
    data.frames.configFrame:SetWidth(OPTIONS_WIDTH + 60)
    data.frames.configFrame:SetHeight((DISPLAYED_OPTIONS+2) * OPTIONS_HEIGHT + 20)
    data.frames.configFrame:RegisterForDrag("LeftButton")
    data.frames.configFrame:SetScript("OnDragStart", function(self) self:StartMoving() end)
    data.frames.configFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    data.frames.configFrame:SetClampedToScreen(true)
    data.frames.configFrame.texture = data.frames.configFrame:CreateTexture()
    data.frames.configFrame.texture:SetAllPoints()
    data.frames.configFrame.texture:SetTexture(0,0,0,0.7)
    data.frames.configFrame:Hide()
	
	data.frames.logo = CreateFrame("Frame", nil, data.frames.configFrame)
    data.frames.logo:SetPoint("CENTER",data.frames.configFrame)
    data.frames.logo:SetWidth(OPTIONS_WIDTH)
    data.frames.logo:SetHeight(DISPLAYED_OPTIONS * OPTIONS_HEIGHT)
    data.frames.logo:Show()
    data.frames.logo:SetBackdrop({ bgFile = "Interface\\AddOns\\Probably_MrTheSoulz\\media\\splash.tga" })
    local title = CreateFrame("Frame", nil, data.frames.configFrame)
    title:SetPoint("TOP", data.frames.configFrame)
    title:SetWidth(OPTIONS_WIDTH)
    title:SetHeight(OPTIONS_HEIGHT)
    local text = title:CreateFontString(nil, "OVERLAY", "MovieSubtitleFont")
    text:SetWidth(OPTIONS_WIDTH)
    text:SetHeight(OPTIONS_HEIGHT)
    text:SetPoint("LEFT",title)
    text:SetText(titleText)
    title:Show()
  
    data.frames.scrollFrame = CreateFrame("ScrollFrame", "mConfigScrollFrame"..nextElementId(), data.frames.configFrame, "FauxScrollFrameTemplate")
    data.frames.scrollFrame:SetPoint("CENTER",data.frames.configFrame)
    data.frames.scrollFrame:SetWidth(OPTIONS_WIDTH)
    data.frames.scrollFrame:SetHeight(DISPLAYED_OPTIONS * OPTIONS_HEIGHT + 20)
    data.frames.scrollFrame:Show()
    data.frames.scrollFrame.texture = data.frames.scrollFrame:CreateTexture()
	data.frames.scrollFrame.texture:SetAllPoints()
    data.frames.scrollFrame.texture:SetTexture(0,0,0,0.3)
    data.frames.scrollFrame:SetScript("OnVerticalScroll", function(self, offset)
        FauxScrollFrame_OnVerticalScroll(self, offset, OPTIONS_HEIGHT, function() data:update() end)
    end)
	
    mts_Alert_Version = CreateFrame("Frame",nil,UIParent)
    mts_Alert_Version:SetWidth(300)
    mts_Alert_Version:SetHeight(30)
    mts_Alert_Version:Hide()
    mts_Alert_Version:SetPoint("TOP",0,0)
    mts_Alert_Version.text = mts_Alert_Version:CreateFontString(nil,"OVERLAY","MovieSubtitleFont")
    mts_Alert_Version.text:SetAllPoints()
    mts_Alert_Version.text:SetText(mts_VERSION)
    mts_Alert_Version.texture = mts_Alert_Version:CreateTexture()
    mts_Alert_Version.texture:SetAllPoints()
    mts_Alert_Version.texture:SetTexture(0,0,0,0.7)

    --data.frames.scrollFrame:SetScript("OnUpdate", function() data:update() end)

	-- Close Button
        local button = CreateFrame("Button", nil, data.frames.configFrame)
        button:SetPoint("BOTTOM", data.frames.configFrame, "BOTTOM", -100, 10)
        button:SetWidth(100)
        button:SetHeight(25)
        button:SetText("Close")
        button:SetNormalFontObject("GameFontNormal")
        button:SetScript("OnClick", function(self) data.frames.configFrame:Hide(); mts_Alert_Version:Hide() end)
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

    -- Reset Button
        local resetbutton = CreateFrame("Button", nil, data.frames.configFrame)
        resetbutton:SetPoint("BOTTOM", data.frames.configFrame, "BOTTOM", 0, 10)
        resetbutton:SetWidth(100)
        resetbutton:SetHeight(25)
        resetbutton:SetText("Reset")
        resetbutton:SetNormalFontObject("GameFontNormal")
        resetbutton:SetScript("OnClick", function(self) mConfig:defaultValues() end)
        -- Button Textures
        local resetbutton1 = resetbutton:CreateTexture()
        resetbutton1:SetTexture(0,0,0,1)
        resetbutton1:SetTexCoord(0, 0.625, 0, 0.6875)
        resetbutton1:SetAllPoints() 
        resetbutton:SetNormalTexture(resetbutton1)
        local resetbutton2 = resetbutton:CreateTexture()
        resetbutton2:SetTexture(0.5,0.5,0.5,1)
        resetbutton2:SetTexCoord(0, 0.625, 0, 0.6875)
        resetbutton2:SetAllPoints()
        resetbutton:SetHighlightTexture(resetbutton2)
        local resetbutton3 = resetbutton:CreateTexture()
        resetbutton3:SetTexture(0,0,0,1)
        resetbutton3:SetTexCoord(0, 0.625, 0, 0.6875)
        resetbutton3:SetAllPoints()
        resetbutton:SetPushedTexture(resetbutton3)

    -- Reload Button
        local reloadbutton = CreateFrame("Button", nil, data.frames.configFrame)
        reloadbutton:SetPoint("BOTTOM", data.frames.configFrame, "BOTTOM", 100, 10)
        reloadbutton:SetWidth(100)
        reloadbutton:SetHeight(25)
        reloadbutton:SetText("Reload")
        reloadbutton:SetNormalFontObject("GameFontNormal")
        reloadbutton:SetScript("OnClick", function(self) ReloadUI() end)
        -- Button Textures
        local reloadbutton1 = reloadbutton:CreateTexture()
        reloadbutton1:SetTexture(0,0,0,1)
        reloadbutton1:SetTexCoord(0, 0.625, 0, 0.6875)
        reloadbutton1:SetAllPoints() 
        reloadbutton:SetNormalTexture(reloadbutton1)
        local reloadbutton2 = reloadbutton:CreateTexture()
        reloadbutton2:SetTexture(0.5,0.5,0.5,1)
        reloadbutton2:SetTexCoord(0, 0.625, 0, 0.6875)
        reloadbutton2:SetAllPoints()
        reloadbutton:SetHighlightTexture(reloadbutton2)
        local reloadbutton3 = reloadbutton:CreateTexture()
        reloadbutton3:SetTexture(0,0,0,1)
        reloadbutton3:SetTexCoord(0, 0.625, 0, 0.6875)
        reloadbutton3:SetAllPoints()
        reloadbutton:SetPushedTexture(reloadbutton3)
	
    if slashCommands then
        local slashId = "MCONFIG_"..addOn.."_"..key
        if type(slashCommands) == "table" then
            local pos = 1
            for _,slashCommand in pairs(slashCommands) do
                _G["SLASH_"..slashId..pos] = slashCommand
                pos = pos + 1
            end
        else
            _G["SLASH_"..slashId.."1"] = slashCommands
        end
        SlashCmdList[slashId] = function(msg,editbox)
            if data.frames.configFrame:IsShown() then
                data.frames.configFrame:Hide()
				mts_Alert_Version:Hide()
				PlaySoundFile("Interface\\AddOns\\Probably_MrTheSoulz\\media\\menu.mp3", "master")
            else
                data.frames.configFrame:Show()
                data.frames.scrollFrame:Show()
				mts_Alert_Version:Show()
				PlaySoundFile("Interface\\AddOns\\Probably_MrTheSoulz\\media\\menu.mp3", "master")
            end
        end
    end

    return data
end

end