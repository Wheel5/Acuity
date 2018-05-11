Acuity = Acuity or { }
local Acuity = Acuity

function Acuity.setupMenu()
	local LAM = LibStub("LibAddonMenu-2.0")

	local panelData = {
		type = "panel",
		name = Acuity.name,
		displayName = Acuity.name,
		author = "Wheels",
		version = ""..Acuity.version,
		registerForRefresh = true
	}

	LAM:RegisterAddonPanel(Acuity.name.."Options", panelData)

	local options = {
		{
			type = "header",
			name = "Positioning"
		},
		{
			type = "checkbox",
			name = "Lock UI",
			tooltip = "Unlock to position timer in desired location",
			getFunc = function() return true end,
			setFunc = function(value)
				if not value then
					EVENT_MANAGER:UnregisterForEvent(Acuity.name.."Hide", EVENT_RETICLE_HIDDEN_UPDATE)
					AcuityFrame:SetHidden(false)
					AcuityFrame:SetMovable(true)
					AcuityFrame:SetMouseEnabled(true)
				else
					EVENT_MANAGER:RegisterForEvent(Acuity.name.."Hide", EVENT_RETICLE_HIDDEN_UPDATE, Acuity.hideFrame)
					AcuityFrame:SetHidden(IsReticleHidden())
					AcuityFrame:SetMovable(false)
					AcuityFrame:SetMouseEnabled(false)
				end
			end
		},
		{
			type = "header",
			name = "Options"
		},
		{
			type = "slider",
			name = "Text Size",
			tooltip = "Size of the displayed timer",
			min = 20,
			max = 100,
			getFunc = function() return Acuity.savedVars.timerSize end,
			setFunc = function(value)
				Acuity.savedVars.timerSize = value
				Acuity.setFontSize(value)
			end
		},
		{
			type = "checkbox",
			name = "Only Display In Combat",
			tooltip = "Only displays timer when the player is in combat",
			getFunc = function() return Acuity.savedVars.passiveHide end,
			setFunc = function(value)
				Acuity.savedVars.passiveHide = value
				Acuity.hideOutOfCombat()
			end
		},
	}

	LAM:RegisterOptionControls(Acuity.name.."Options", options)
end