local logo = "|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:15:15|t"

mts_configWarrFury = {
	key = "mtsconfigWarrFury",
	profiles = true,
	title = logo.."MrTheSoulz Config",
	subtitle = "Warrior Fury Settings",
	color = "C79C6E",
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

			-- NOTHING IN HERE YET...

		{ type = "spacer" },
		{ type = 'rule' },
		{ 
			type = "header", 
			text = "Survival Settings", 
			align = "center" 
		},
			
			-- Survival Settings:
			{ 
				type = "dropdown",
				text = "Shout", 
				key = "Shout", 
				list = {
			    	{
			          text = "Battle Shout",
			          key = "Battle Shout"
			        },
			        {
			          text = "Commanding Shout",
			          key = "Commanding Shout"
			    	},
		    	}, 
		    	default = "Battle Shout", 
		    	desc = "Select what buff to use." 
		    },
			{
				type = "spinner",
				text = "Rallying Cry - HP",
				key = "RallyingCry",
				width = 50,
				min = 0,
				max = 100,
				default = 15,
				step = 5
			},
			{
				type = "spinner",
				text = "Die by the Sword - HP",
				key = "DBTS",
				width = 50,
				min = 0,
				max = 100,
				default = 25,
				step = 5
			},
			{
				type = "spinner",
				text = "Impending Victory - HP",
				key = "IVT",
				width = 50,
				min = 0,
				max = 100,
				default = 100,
				step = 5
			},
			{
				type = "spinner",
				text = "Enraged Regeneration - HP",
				key = "ERG",
				width = 50,
				min = 0,
				max = 100,
				default = 60,
				step = 5
			},

	}
}