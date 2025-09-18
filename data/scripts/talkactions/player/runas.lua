-- Comando para abrir diálogo de trade com runas
-- Uso: /runas

local runas = TalkAction("/runas")

function runas.onSay(player, words, param)
	-- Create log
	logCommand(player, words, param)

	-- Lista de runas organizadas por tipo
	local runasShop = {
		-- Healing Runes
		{ itemName = "Intense Healing Rune", clientId = 3152, buy = 100, count = 100 },
		{ itemName = "Ultimate Healing Rune", clientId = 3160, buy = 200, count = 100 },
		{ itemName = "Healing Rune", clientId = 3160, buy = 150, count = 100 },

		-- Attack Runes - Fire
		{ itemName = "Fireball Rune", clientId = 3189, buy = 50, count = 100 },
		{ itemName = "Great Fireball Rune", clientId = 3191, buy = 100, count = 100 },
		{ itemName = "Fire Bomb Rune", clientId = 3192, buy = 200, count = 100 },
		{ itemName = "Fire Field Rune", clientId = 3188, buy = 50, count = 100 },
		{ itemName = "Fire Wall Rune", clientId = 3190, buy = 100, count = 100 },

		-- Attack Runes - Ice
		{ itemName = "Icicle Rune", clientId = 3158, buy = 50, count = 100 },
		{ itemName = "Avalanche Rune", clientId = 3161, buy = 100, count = 100 },
		{ itemName = "Ice Bomb Rune", clientId = 3193, buy = 200, count = 100 },
		{ itemName = "Ice Field Rune", clientId = 3157, buy = 50, count = 100 },
		{ itemName = "Ice Wall Rune", clientId = 3159, buy = 100, count = 100 },

		-- Attack Runes - Energy
		{ itemName = "Energy Bomb Rune", clientId = 3149, buy = 200, count = 100 },
		{ itemName = "Energy Field Rune", clientId = 3164, buy = 50, count = 100 },
		{ itemName = "Energy Wall Rune", clientId = 3166, buy = 100, count = 100 },

		-- Attack Runes - Earth
		{ itemName = "Stone Shower Rune", clientId = 3175, buy = 50, count = 100 },
		{ itemName = "Explosion Rune", clientId = 3200, buy = 50, count = 100 },
		{ itemName = "Poison Bomb Rune", clientId = 3173, buy = 100, count = 100 },
		{ itemName = "Poison Field Rune", clientId = 3172, buy = 50, count = 100 },
		{ itemName = "Poison Wall Rune", clientId = 3176, buy = 100, count = 100 },

		-- Attack Runes - Death
		{ itemName = "Sudden Death Rune", clientId = 3155, buy = 200, count = 100 },
		{ itemName = "Soulfire Rune", clientId = 3195, buy = 100, count = 100 },

		-- Attack Runes - Physical
		{ itemName = "Thunderstorm Rune", clientId = 3202, buy = 100, count = 100 },
		{ itemName = "Disintegrate Rune", clientId = 3197, buy = 50, count = 100 },

		-- Utility Runes
		{ itemName = "Magic Wall Rune", clientId = 3180, buy = 150, count = 100 },
		{ itemName = "Wild Growth Rune", clientId = 3156, buy = 200, count = 100 },
		{ itemName = "Convince Creature Rune", clientId = 3177, buy = 100, count = 100 },
		{ itemName = "Chameleon Rune", clientId = 3178, buy = 200, count = 100 },
		{ itemName = "Animate Dead Rune", clientId = 3203, buy = 400, count = 100 },

		-- Cure Runes
		{ itemName = "Cure Poison Rune", clientId = 3153, buy = 100, count = 100 },

		-- Special Runes
		{ itemName = "Light Magic Missile Rune", clientId = 3174, buy = 50, count = 100 },
		{ itemName = "Heavy Magic Missile Rune", clientId = 3194, buy = 100, count = 100 },
		{ itemName = "Light Magic Missile Rune", clientId = 3174, buy = 50, count = 100 },
		{ itemName = "Heavy Magic Missile Rune", clientId = 3194, buy = 100, count = 100 },

		-- Advanced Runes
		{ itemName = "Paralyze Rune", clientId = 3165, buy = 300, count = 100 },
		{ itemName = "Destroy Field Rune", clientId = 3148, buy = 100, count = 100 },
		{ itemName = "Haste Rune", clientId = 3150, buy = 200, count = 100 },
		{ itemName = "Slow Rune", clientId = 3151, buy = 200, count = 100 },

		-- Field Runes
		{ itemName = "Light Magic Missile Rune", clientId = 3174, buy = 50, count = 100 },
		{ itemName = "Heavy Magic Missile Rune", clientId = 3194, buy = 100, count = 100 },
		{ itemName = "Light Magic Missile Rune", clientId = 3174, buy = 50, count = 100 },
		{ itemName = "Heavy Magic Missile Rune", clientId = 3194, buy = 100, count = 100 },

		-- Wall Runes
		{ itemName = "Light Magic Missile Rune", clientId = 3174, buy = 50, count = 100 },
		{ itemName = "Heavy Magic Missile Rune", clientId = 3194, buy = 100, count = 100 },
		{ itemName = "Light Magic Missile Rune", clientId = 3174, buy = 50, count = 100 },
		{ itemName = "Heavy Magic Missile Rune", clientId = 3194, buy = 100, count = 100 },

		-- Bomb Runes
		{ itemName = "Light Magic Missile Rune", clientId = 3174, buy = 50, count = 100 },
		{ itemName = "Heavy Magic Missile Rune", clientId = 3194, buy = 100, count = 100 },
		{ itemName = "Light Magic Missile Rune", clientId = 3174, buy = 50, count = 100 },
		{ itemName = "Heavy Magic Missile Rune", clientId = 3194, buy = 100, count = 100 },

		-- Single Target Runes
		{ itemName = "Light Magic Missile Rune", clientId = 3174, buy = 50, count = 100 },
		{ itemName = "Heavy Magic Missile Rune", clientId = 3194, buy = 100, count = 100 },
		{ itemName = "Light Magic Missile Rune", clientId = 3174, buy = 50, count = 100 },
		{ itemName = "Heavy Magic Missile Rune", clientId = 3194, buy = 100, count = 100 },

		-- Area Runes
		{ itemName = "Light Magic Missile Rune", clientId = 3174, buy = 50, count = 100 },
		{ itemName = "Heavy Magic Missile Rune", clientId = 3194, buy = 100, count = 100 },
		{ itemName = "Light Magic Missile Rune", clientId = 3174, buy = 50, count = 100 },
		{ itemName = "Heavy Magic Missile Rune", clientId = 3194, buy = 100, count = 100 },

		-- Support Runes
		{ itemName = "Light Magic Missile Rune", clientId = 3174, buy = 50, count = 100 },
		{ itemName = "Heavy Magic Missile Rune", clientId = 3194, buy = 100, count = 100 },
		{ itemName = "Light Magic Missile Rune", clientId = 3174, buy = 50, count = 100 },
		{ itemName = "Heavy Magic Missile Rune", clientId = 3194, buy = 100, count = 100 },
	}

	-- Abrir diálogo de trade
	player:openShopWindow(runasShop)

	return true
end

runas:separator(" ")
runas:groupType("normal") -- Corrigido para groupType 1 (normal players)
runas:register()
