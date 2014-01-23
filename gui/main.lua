-- //////////////////////-----------------------------------------INFO-----------------------------------//////////////////////////////
--															   //Main frame//
--													  Thank Your For Your My ProFiles
--														  I Hope Your Enjoy Them
--																   MTS


--mConfig copyright & thanks to https://github.com/kirk24788/mConfig

mtsConfigData = {}

mtsConfigAllData = {}

local DISPLAYED_OPTIONS = 10
local OPTIONS_HEIGHT = 40
local OPTIONS_WIDTH = 600
mtsConfig_VERSION = mtsConfigVersion
mtsConfig = {}

local function testmtsConfig()
    local veryLongText = " Oh Lord, won't you buy me a Mercedes Benz? My friends all drive Porsches, I must make amends. Worked hard all my lifetime, no help from my friends,So Lord, won't you buy me a Mercedes Benz ? "
    local testConfig = mtsConfig:createConfig("mtsConfig Test","mtsConfig","Default",{"/mc"})
    testConfig:addCheckBox("checkTest", "CheckBox Text: ".. veryLongText, "CheckBox Tooltip Text", false)
    testConfig:addTextBox("textTest", "TextBox Text: ".. veryLongText, "TextBox Tooltip Text", "giulia")
    testConfig:addNumericBox("numericTest", "NumericBox Text: ".. veryLongText, "NumericBox Tooltip Text", 42)
    testConfig:addText("Short Text - no tooltip")
    testConfig:addText("Text Text: ".. veryLongText, "Text Segment Test")
    testConfig:addSlider("sliderText", "Slider Text: ".. veryLongText, "Slider Tooltip Text", 1, 10, 4, 1)
    testConfig:addButton("Button Text: Ignores Width!", "Button Tooltip Text", function(cfg) print("You pressed the Button! (Config @" .. tostring(cfg) .. ")") end)
    testConfig:addDropDown("dropdownTest", "Drop Down Text: " .. veryLongText, "DropDown Tooltip", {"alpha", "beta", "gamma"}, 2)
    testConfig:addDropDown("dropdownNamedTest", "Drop Down Named Keys", "DropDown Tooltip 2", {ALPHA="alpha", BETA="beta", GAMMA="gamma"}, "ALPHA")
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("VARIABLES_LOADED")
frame:SetScript("OnEvent", function()
    for _,c in pairs(mtsConfigAllData) do
        if mtsConfigData[c.addOn] then
            c.values=mtsConfigData[c.addOn][c.key]
            c:update()
        end
    end
end)

local _nextElementId = 1
local function nextElementId()
    local name = "mtsConfig_ELEMENT_" .. _nextElementId
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

function mtsConfig:addButton(text,tooltip,fn)
    local button = CreateFrame("Button", nil, self.frames.scrollFrame)
    button:SetNormalFontObject("GameFontNormal")
    button:SetSize(OPTIONS_WIDTH, OPTIONS_HEIGHT)
    button:SetText(text)
    addTooltip(button, text, tooltip)
    if fn then
        button:SetScript("OnClick", function() fn(self.values) end)
    end
    
    table.insert(self.frames.options, button)
    
    self:update()
end

function mtsConfig:addText(text, tooltip)

    local optionFrame = CreateFrame("Frame", nil, self.frames.scrollFrame)
    optionFrame:SetSize(OPTIONS_WIDTH, OPTIONS_HEIGHT)
	optionFrame.texture = optionFrame:CreateTexture()
	optionFrame.texture:SetAllPoints()
	optionFrame.texture:SetTexture(0,0,0,0.5) 
    addTooltip(optionFrame, text, tooltip)

    local optionText = optionFrame:CreateFontString(nil, "OVERLAY", "MovieSubtitleFont")
    optionText:SetPoint("LEFT",optionFrame,20,-6)
    optionText:SetWidth(OPTIONS_WIDTH-40)
    optionText:SetHeight(OPTIONS_HEIGHT)
    optionText:SetText(text)
    optionText:SetJustifyH("CENTER")
    optionText:SetJustifyV("CENTER")
    
    table.insert(self.frames.options, optionFrame)
end

function mtsConfig:addCheckBox(key, text, tooltip, defaultValue)
    if not defaultValue then defaultValue = false end
    if self.values[key] == nil then self.values[key] = defaultValue end

    local optionFrame = CreateFrame("Frame", nil, self.frames.scrollFrame)
    optionFrame:SetSize(OPTIONS_WIDTH, OPTIONS_HEIGHT)
    addTooltip(optionFrame, text, tooltip)

    local checkbutton = CreateFrame("CheckButton", nil, optionFrame, "ChatConfigSmallCheckButtonTemplate")
    checkbutton:SetHitRectInsets(4,4,4,4);
    checkbutton:SetPoint("RIGHT",optionFrame,-30,-5)
    checkbutton:SetChecked(defaultValue)
    checkbutton:SetScript("OnClick", function()
        self.values[key] = checkbutton:GetChecked(defaultValue) == 1
    end)
    optionFrame:Show()

    local optionText = optionFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    optionText:SetPoint("LEFT",optionFrame,20,-6)
    optionText:SetWidth(OPTIONS_WIDTH-80)
    optionText:SetHeight(OPTIONS_HEIGHT)
    optionText:SetText(text)
    optionText:SetJustifyH("LEFT")
    
    self.defaults[key] = defaultValue
    table.insert(self.frames.options, optionFrame)
    self.setters[key] = function(v) checkbutton:SetChecked(v) end
    self.update(self)
end

function mtsConfig:addTextBox(key, text, tooltip, defaultValue)
    if not defaultValue then defaultValue = "" end
    if not self.values[key] then self.values[key] = defaultValue end

    local optionFrame = CreateFrame("Frame", nil, self.frames.scrollFrame)
    optionFrame:SetSize(OPTIONS_WIDTH, OPTIONS_HEIGHT)
    addTooltip(optionFrame, text, tooltip)
    optionFrame:Show()
    
    local textbox = CreateFrame("EditBox",nextElementId() , optionFrame, "InputBoxTemplate" );
    textbox:SetWidth(120)
    textbox:SetHeight(40)
    textbox:SetPoint("RIGHT",optionFrame,-20,-8)
    textbox:SetText(defaultValue)
    textbox:SetAutoFocus(false) 
    textbox:SetScript("OnTextChanged", function()
        self.values[key] = textbox:GetText() 
    end)
    getglobal(textbox:GetName().."Middle"):ClearAllPoints()
    getglobal(textbox:GetName().."Middle"):SetPoint("LEFT",getglobal(textbox:GetName().."Left"), "RIGHT", 0, 0)
    getglobal(textbox:GetName().."Middle"):SetPoint("RIGHT",getglobal(textbox:GetName().."Right"), "LEFT", 0, 0)
    textbox:ClearAllPoints()
    textbox:SetPoint("RIGHT",optionFrame,-20,-8)

    local optionText = optionFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    optionText:SetPoint("LEFT",optionFrame,20,-6)
    optionText:SetWidth(OPTIONS_WIDTH-180)
    optionText:SetHeight(OPTIONS_HEIGHT)
    optionText:SetText(text)
    optionText:SetJustifyH("LEFT")
    
    self.defaults[key] = defaultValue
    self.setters[key] = function(v) textbox:SetText(v) end
    table.insert(self.frames.options, optionFrame)
    self:update()
end

function mtsConfig:addNumericBox(key, text, tooltip, defaultValue)
    if not defaultValue then defaultValue = 0 end
    if not self.values[key] then self.values[key] = defaultValue end

    local optionFrame = CreateFrame("Frame", nil, self.frames.scrollFrame)
    optionFrame:SetSize(OPTIONS_WIDTH, OPTIONS_HEIGHT)
    addTooltip(optionFrame, text, tooltip)
    optionFrame:Show()

    local textbox = CreateFrame("EditBox", nextElementId(), optionFrame, "InputBoxTemplate" );
    textbox:SetWidth(60)
    textbox:SetHeight(40)
    textbox:SetText(defaultValue)
    textbox:SetAutoFocus(false) 
    textbox:SetScript("OnTextChanged", function()
        self.values[key] = textbox:GetNumber()
    end)
    getglobal(textbox:GetName().."Middle"):ClearAllPoints()
    getglobal(textbox:GetName().."Middle"):SetPoint("LEFT",getglobal(textbox:GetName().."Left"), "RIGHT", 0, 0)
    getglobal(textbox:GetName().."Middle"):SetPoint("RIGHT",getglobal(textbox:GetName().."Right"), "LEFT", 0, 0)
    textbox:ClearAllPoints()
    textbox:SetPoint("RIGHT",optionFrame,-20,-8)
    
    

    local optionText = optionFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    optionText:SetPoint("LEFT",optionFrame,20,-6)
    optionText:SetWidth(OPTIONS_WIDTH-120)
    optionText:SetHeight(OPTIONS_HEIGHT)
    optionText:SetText(text)
    optionText:SetJustifyH("LEFT")
    
    self.defaults[key] = defaultValue
    self.setters[key] = function(v) textbox:SetText(v) end
    table.insert(self.frames.options, optionFrame)

    self:update()
end

function mtsConfig:addSlider(key, text, tooltip, minValue, maxValue, defaultValue,stepSize)
    if not defaultValue then defaultValue = minValue end
    if not stepSize then stepSize = 1 end
    if not self.values[key] then self.values[key] = defaultValue end

    local optionFrame = CreateFrame("Frame", nil, self.frames.scrollFrame)
    optionFrame:SetSize(OPTIONS_WIDTH, OPTIONS_HEIGHT)
    addTooltip(optionFrame, text, tooltip)
    optionFrame:Show()


    local optionText = optionFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    optionText:SetPoint("LEFT",optionFrame,20,-6)
    optionText:SetWidth(OPTIONS_WIDTH-180)
    optionText:SetHeight(OPTIONS_HEIGHT)
    optionText:SetText(text .. "|r |cffffffff (" .. (math.floor(self.values[key]*10)/10) .. ")|r")
    optionText:SetJustifyH("LEFT")

    local slider = CreateFrame("Slider", nextElementId(), optionFrame, "OptionsSliderTemplate")
    slider:SetScale(1)
    slider:SetMinMaxValues(minValue,maxValue)
    slider.minValue, slider.maxValue = slider:GetMinMaxValues()
    slider:SetValue(self.values[key])
    slider:SetValueStep(stepSize)
    slider:SetWidth(120)
    slider:EnableMouse(true)
    slider:SetPoint("RIGHT",optionFrame,-20,-8)
    getglobal(slider:GetName() .. 'Low'):SetText(lowText)
    getglobal(slider:GetName() .. 'High'):SetText(HighText)
    getglobal(slider:GetName() .. 'Text'):SetText(title)
    slider:SetScript("OnValueChanged", function()
        self.values[key] = slider:GetValue() 
        optionText:SetText(text .. "|r |cffffffff (" .. (math.floor(self.values[key]*10)/10) .. ")|r")
    end)
    
    self.defaults[key] = defaultValue
    self.setters[key] = function(v) slider:SetValue(v) end
    table.insert(self.frames.options, optionFrame)
    
    self:update()
end

function mtsConfig:addDropDown(key, text, tooltip, values, defaultValue)
    if not defaultValue then defaultValue = 1 end
    if not self.values[key] then self.values[key] = defaultValue end

    local optionFrame = CreateFrame("Frame", nil, self.frames.scrollFrame)
    optionFrame:SetSize(OPTIONS_WIDTH, OPTIONS_HEIGHT)
    addTooltip(optionFrame, text, tooltip)
    optionFrame:Show()


    local optionText = optionFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    optionText:SetPoint("LEFT",optionFrame,20,-6)
    optionText:SetWidth(OPTIONS_WIDTH-180)
    optionText:SetHeight(OPTIONS_HEIGHT)
    optionText:SetText(text)
    optionText:SetJustifyH("LEFT")

    local dropdown = CreateFrame("Frame", nextElementId(), optionFrame, "UIDropDownMenuTemplate")
    local InitializeDropdown = function()
        local info = UIDropDownMenu_CreateInfo()
        local configValues = self.values
        for k,v in pairs(values) do
                info.text = v;
                info.value = k;
                info.func  = function(self)
                    UIDropDownMenu_SetSelectedValue(dropdown, self.value)
                    configValues[key] = self.value
                    UIDropDownMenu_SetText(dropdown, v)
                end
                info.checked = nil
                info.notCheckable = 1
                UIDropDownMenu_AddButton(info, 1);
        end
    end

    dropdown:SetPoint("RIGHT",optionFrame, 0,-8)
    UIDropDownMenu_SetWidth(dropdown, 110);
    UIDropDownMenu_JustifyText(dropdown, "LEFT");
    UIDropDownMenu_Initialize(dropdown, InitializeDropdown)
    self.defaults[key] = defaultValue
    self.setters[key] = function(v) 
        UIDropDownMenu_SetSelectedValue(dropdown, v)
        for k,text in pairs(values) do
            if k == v then UIDropDownMenu_SetText(dropdown, text) end
        end
    end
    self.setters[key](defaultValue)
    table.insert(self.frames.options, optionFrame)
    
    self:update()
end

function mtsConfig:update()
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

function mtsConfig:Show()
    self.frames.configFrame:Show()
end

function mtsConfig:Hide()
    self.frames.configFrame:Hide()
end

function mtsConfig:Toggle()
    if self.frames.configFrame:IsShown() then
        self.frames.configFrame:Hide()
    else
        self.frames.configFrame:Show()
    end
end

function mtsConfig:get(key)
	if not self.values[key] then 
		if not self.defaults[key] then
			print("mtsConfig error: ".. key.." not found")
			return 0
		else
			return self.defaults[key]
		end
	end
    return self.values[key]
end
function mtsConfig:set(key, value)
    self.values[key] = value
    return self:update()
end
function mtsConfig:defaultValues()
    for k,v in pairs(self.defaults) do
        self.values[k] = v
    end
    return self:update()
end




function mtsConfig:createConfig(titleText,addOn,key,slashCommands)
    if not key then key = "Default" end
    if not mtsConfigData[addOn] then mtsConfigData[addOn] = {} end
    if not mtsConfigData[addOn][key] then mtsConfigData[addOn][key] = {} end
    local data = {
        frames={options={}},
        addOn=addOn,
        key=key,
        values=mtsConfigData[addOn][key],
        defaults={},
        setters={},
    }
    table.insert(mtsConfigAllData, data)
    setmetatable(data, self)
    self.__index = self
    data.frames.configFrame = CreateFrame("Frame", nil,UIParent)
    data.frames.configFrame:SetPoint("CENTER",UIParent)
    data.frames.configFrame:EnableMouse(true)
    data.frames.configFrame:SetMovable(true)
    data.frames.configFrame:SetWidth(OPTIONS_WIDTH + 75)
    data.frames.configFrame:SetHeight((DISPLAYED_OPTIONS+2) * OPTIONS_HEIGHT)
    data.frames.configFrame:RegisterForDrag("LeftButton")
    data.frames.configFrame:SetScript("OnDragStart", function(self) self:StartMoving() end)
    data.frames.configFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    data.frames.configFrame:SetClampedToScreen(true)
	data.frames.configFrame:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
		tile = true, tileSize = 16, edgeSize = 16, 
		insets = { left = 4, right = 4, top = 4, bottom = 4 }});
	data.frames.configFrame:SetBackdropColor(0,0,0,5);
    data.frames.configFrame:Hide()
	
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
  
    data.frames.scrollFrame = CreateFrame("ScrollFrame", "mtsConfigScrollFrame"..nextElementId(), data.frames.configFrame, "FauxScrollFrameTemplate")
    data.frames.scrollFrame:SetPoint("CENTER", data.frames.configFrame)
    data.frames.scrollFrame:SetWidth(OPTIONS_WIDTH + 10)
    data.frames.scrollFrame:SetHeight(DISPLAYED_OPTIONS * OPTIONS_HEIGHT)
	data.frames.scrollFrame.texture = data.frames.scrollFrame:CreateTexture()
	data.frames.scrollFrame.texture:SetAllPoints()
    data.frames.scrollFrame.texture:SetTexture(0,0,0,0.3)
    data.frames.scrollFrame:Show()
    data.frames.scrollFrame:SetScript("OnVerticalScroll", function(self, offset)
        FauxScrollFrame_OnVerticalScroll(self, offset, OPTIONS_HEIGHT, function() data:update() end)
    end)


    local button = CreateFrame("Button", nil, data.frames.configFrame)
    button:SetPoint("BOTTOM", data.frames.configFrame, "BOTTOM", - 100, 10)
    button:SetWidth(100)
    button:SetHeight(25)
    button:SetText("Close")
    button:SetNormalFontObject("GameFontNormal")
    button:SetScript("OnClick", function(self) data.frames.configFrame:Hide() end)
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
	
	local versionButton = CreateFrame("Button", nil, data.frames.configFrame)
    versionButton:SetPoint("BOTTOM", data.frames.configFrame, "BOTTOM", 100 , 10)
    versionButton:SetWidth(100)
    versionButton:SetHeight(25)
    versionButton:SetText("Version")
    versionButton:SetNormalFontObject("GameFontNormal")
    versionButton:SetScript("OnClick", function(self) mtsAlert:message("\124cff9482C9*MrTheSoulz Version: 3.0.0*") end)
    local versionButton1 = versionButton:CreateTexture()
    versionButton1:SetTexture(0,0,0,1)
    versionButton1:SetTexCoord(0, 0.625, 0, 0.6875)
    versionButton1:SetAllPoints() 
    versionButton:SetNormalTexture(versionButton1)
    local versionButton2 = versionButton:CreateTexture()
    versionButton2:SetTexture(0.5,0.5,0.5,1)
    versionButton2:SetTexCoord(0, 0.625, 0, 0.6875)
    versionButton2:SetAllPoints()
    versionButton:SetHighlightTexture(versionButton2)
    local versionButton3 = versionButton:CreateTexture()
    versionButton3:SetTexture(0,0,0,1)
    versionButton3:SetTexCoord(0, 0.625, 0, 0.6875)
    versionButton3:SetAllPoints()
    versionButton:SetPushedTexture(versionButton3)
    
    if slashCommands then
        local slashId = "mtsConfig_"..addOn.."_"..key
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
            else
                data.frames.configFrame:Show()
                data.frames.scrollFrame:Show()
            end
        end
    end

    return data
end