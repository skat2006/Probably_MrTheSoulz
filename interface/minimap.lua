local GetCursorPosition = GetCursorPosition
local InterfaceOptionsFrame_OpenToCategory = InterfaceOptionsFrame_OpenToCategory

mts_minimap = {}

local minimap = mts_minimap

local function reposition()
  minimap.button:SetPoint('TOPLEFT', Minimap, 'TOPLEFT', 52 - (80 * cos(minimap.position)), (80 * sin(minimap.position)) - 52)
end

local function onUpdate()
  local xpos, ypos = GetCursorPosition()
  local xmin, ymin = Minimap:GetLeft(), Minimap:GetBottom()

  xpos = xmin - xpos / UIParent:GetScale() + 70
  ypos = ypos / UIParent:GetScale() - ymin - 70
  minimap.position = math.floor(math.deg(math.atan2(ypos, xpos)))

  reposition()
end

local function onDragStart(self)
  self:LockHighlight()
  self:StartMoving()
  self:SetScript('OnUpdate', onUpdate)
end

local function onDragStop(self)
  self:SetScript('OnUpdate', nil)
  self:StopMovingOrSizing()
  self:UnlockHighlight()

  ProbablyEngine.config.write('mts_minimap_position', minimap.position)
end

local button_moving
local function onClick(self, button)
  if button == 'RightButton' then
    mts_InfoGUI()
  else 
    mts_ConfigGUI()
    mts_ClassGUI()
  end
end

local function onEnter(self)
  GameTooltip:SetOwner( self, 'ANCHOR_BOTTOMLEFT')
  GameTooltip:AddLine('|cff9482C9MrTheSoulz Pack.')
  GameTooltip:AddLine('|cff9482C9Version:|r '..mts.Version)
  GameTooltip:Show()
end

local function onLeave(self)
  GameTooltip:Hide()
end

local function mts_createMinimap()
	local button = CreateFrame('Button', 'MTS_Minimap', Minimap)
	button:SetFrameStrata('MEDIUM')
	button:SetSize(33, 33)
	button:RegisterForClicks('anyUp')
	button:RegisterForDrag('LeftButton', 'RightButton')
    button:SetMovable(true)
	button:SetHighlightTexture('Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight')

	local overlay = button:CreateTexture(nil, 'OVERLAY')
	overlay:SetSize(56, 56)
	overlay:SetTexture('Interface\\Minimap\\MiniMap-TrackingBorder')
	overlay:SetPoint('TOPLEFT')

	local icon = button:CreateTexture(nil, 'BACKGROUND')
	icon:SetSize(21, 21)
	icon:SetTexture('Interface\\AddOns\\Probably_MrTheSoulz\\media\\toggle.blp')
	icon:SetPoint('TOPLEFT', 7, -6)

	button.icon = icon

	button:SetScript('OnDragStart', onDragStart)
	button:SetScript('OnDragStop', onDragStop)
	button:SetScript('OnClick', onClick)
	button:SetScript('OnEnter', onEnter)
	button:SetScript('OnLeave', onLeave)

	minimap.button = button

	minimap.position = ProbablyEngine.config.read('mts_minimap_position', -36)
	reposition()

	button:Show()
end

mts_createMinimap()