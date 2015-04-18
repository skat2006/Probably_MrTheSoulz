local logo = "|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:15:15|t"

mts_configShamanResto = {
	key = "mtsconfShamanResto",
	profiles = true,
	title = logo.."MrTheSoulz Config",
	subtitle = "Shaman Restoration Settings",
	color = "9482C9",
	width = 250,
	height = 500,
	config = {
		
	-- General
	{ type = 'rule' },
	{ 
		type = 'header', 
		text = "General settings:", 
		align = "center"
	},
		-- Dispels
		{ 
			type = "checkbox", 
			text = "Dispels", 
			key = "Dispels", 
			default = true, 
			desc = "This checkbox enables or disables the use of automatic dispels of everything it can dispel."
		},
		
		{ 
		   	type = "dropdown",
		  	text = "Earth Shield on ...", 
		   	key = "ESo", 
		   	list = {
		       {
		          text = "Tank",
		          key = "1"
		        },
		        {
		          text = "Focus",
		          key = "2"
		        },
		        {
		          text = "Manual",
		          key = "3"
		        }
		    }, 
		   	default = "1", 
		   	desc = "Select target for Earth Shield" 
		},	
	
    -- Survival
    { type = 'rule' },
    { 
    	type = 'header', 
    	text = "Survival settings:", 
    	align = "center"
    },
	    { 
	    	type = "spinner", 
	    	text = "Astral Shift", 
	    	key = "AstralShift", 
	    	default = 50
	    },	

    -- Items
    { type = 'rule' },
    { 
    	type = 'header', 
    	text = "Items settings:", 
    	align = "center"
    },
	    { 
	      	type = "spinner", 
	      	text = "Healthstone", 
	      	key = "Healthstone", 
	      	default = 50 
	    },
	    { 
	    	type = "spinner", 
	    	text = "Trinket 1", 
	    	key = "Trinket1", 
	    	default = 85, 
	    	desc = "Use Trinket when player mana is equal to..." 
	   	}, 
	    { 
	    	type = "spinner", 
	    	text = "Trinket 2", 
	    	key = "Trinket2",
	    	default = 85, 
	    	desc = "Use Trinket when player mana is equal to..." 
	    },
						

	}
}