-- Comando para abrir diálogo de trade com poções
-- Uso: /potions

local potions = TalkAction("/potions")

function potions.onSay(player, words, param)
	-- Create log
	logCommand(player, words, param)

	-- Lista de poções organizadas por tipo
	local potionsShop = {
		-- Health Potions
		{ itemName = "Health Potion", clientId = 266, buy = 50, count = 100 },
		{ itemName = "Strong Health Potion", clientId = 236, buy = 100, count = 100 },
		{ itemName = "Great Health Potion", clientId = 239, buy = 200, count = 100 },
		{ itemName = "Ultimate Health Potion", clientId = 7643, buy = 400, count = 100 },
		{ itemName = "Supreme Health Potion", clientId = 23375, buy = 600, count = 100 },

		-- Mana Potions
		{ itemName = "Mana Potion", clientId = 268, buy = 50, count = 100 },
		{ itemName = "Strong Mana Potion", clientId = 237, buy = 100, count = 100 },
		{ itemName = "Great Mana Potion", clientId = 238, buy = 200, count = 100 },
		{ itemName = "Ultimate Mana Potion", clientId = 23373, buy = 400, count = 100 },

		-- Spirit Potions
		{ itemName = "Great Spirit Potion", clientId = 7642, buy = 200, count = 100 },
		{ itemName = "Ultimate Spirit Potion", clientId = 23374, buy = 400, count = 100 },

		-- Special Potions
		{ itemName = "Antidote Potion", clientId = 8472, buy = 50, count = 100 },
		{ itemName = "Berserk Potion", clientId = 7439, buy = 100, count = 100 },
		{ itemName = "Bullseye Potion", clientId = 7443, buy = 100, count = 100 },
		{ itemName = "Chameleon Potion", clientId = 7440, buy = 100, count = 100 },
		{ itemName = "Creature Illusion Potion", clientId = 7441, buy = 100, count = 100 },
		{ itemName = "Fish Oil", clientId = 7442, buy = 100, count = 100 },
		{ itemName = "Gill Potion", clientId = 7444, buy = 100, count = 100 },
		{ itemName = "Haste Potion", clientId = 7445, buy = 100, count = 100 },
		{ itemName = "Invisibility Potion", clientId = 7446, buy = 100, count = 100 },
		{ itemName = "Levitation Potion", clientId = 7447, buy = 100, count = 100 },
		{ itemName = "Mana Oil", clientId = 7448, buy = 100, count = 100 },
		{ itemName = "Might Potion", clientId = 7449, buy = 100, count = 100 },
		{ itemName = "Oil", clientId = 2874, buy = 20, count = 100 },
		{ itemName = "Poison", clientId = 2806, buy = 50, count = 100 },
		{ itemName = "Shrinking Potion", clientId = 7450, buy = 100, count = 100 },
		{ itemName = "Stamina Potion", clientId = 7451, buy = 100, count = 100 },
		{ itemName = "Stone Skin Potion", clientId = 7452, buy = 100, count = 100 },
		{ itemName = "Strong Poison", clientId = 2806, buy = 100, count = 100 },
		{ itemName = "Stronger Poison", clientId = 2806, buy = 200, count = 100 },
		{ itemName = "Swift Foot Potion", clientId = 7453, buy = 100, count = 100 },
		{ itemName = "Water", clientId = 2874, buy = 10, count = 100 },

		-- Kegs (para players com casas)
		{ itemName = "Health Keg", clientId = 25903, buy = 500, count = 1 },
		{ itemName = "Strong Health Keg", clientId = 25904, buy = 1000, count = 1 },
		{ itemName = "Great Health Keg", clientId = 25905, buy = 2000, count = 1 },
		{ itemName = "Ultimate Health Keg", clientId = 25906, buy = 4000, count = 1 },
		{ itemName = "Supreme Health Keg", clientId = 25907, buy = 6000, count = 1 },

		{ itemName = "Mana Keg", clientId = 25908, buy = 500, count = 1 },
		{ itemName = "Strong Mana Keg", clientId = 25909, buy = 1000, count = 1 },
		{ itemName = "Great Mana Keg", clientId = 25910, buy = 2000, count = 1 },
		{ itemName = "Ultimate Mana Keg", clientId = 25911, buy = 4000, count = 1 },

		{ itemName = "Great Spirit Keg", clientId = 25913, buy = 2000, count = 1 },
		{ itemName = "Ultimate Spirit Keg", clientId = 25914, buy = 4000, count = 1 },

		-- Casks (para players com casas)
		{ itemName = "Health Cask", clientId = 25879, buy = 1000, count = 1 },
		{ itemName = "Strong Health Cask", clientId = 25880, buy = 2000, count = 1 },
		{ itemName = "Great Health Cask", clientId = 25881, buy = 4000, count = 1 },
		{ itemName = "Ultimate Health Cask", clientId = 25882, buy = 8000, count = 1 },
		{ itemName = "Supreme Health Cask", clientId = 25883, buy = 12000, count = 1 },

		{ itemName = "Mana Cask", clientId = 25889, buy = 1000, count = 1 },
		{ itemName = "Strong Mana Cask", clientId = 25890, buy = 2000, count = 1 },
		{ itemName = "Great Mana Cask", clientId = 25891, buy = 4000, count = 1 },
		{ itemName = "Ultimate Mana Cask", clientId = 25892, buy = 8000, count = 1 },

		{ itemName = "Great Spirit Cask", clientId = 25899, buy = 4000, count = 1 },
		{ itemName = "Ultimate Spirit Cask", clientId = 25900, buy = 8000, count = 1 },
	}

	-- Abrir diálogo de trade
	player:openShopWindow(potionsShop)

	return true
end

potions:separator(" ")
potions:groupType("normal") -- Corrigido para groupType 1 (normal players)
potions:register()
