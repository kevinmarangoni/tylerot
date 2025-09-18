local talkaction = TalkAction("/questmaster")

function talkaction.onSay(player, words, param)

	local param = param:lower()

	if param == "help" then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "=== COMANDOS DE QUEST MASTER ===\n")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "/questmaster unlock - Libera todas as quests para o jogador")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "/questmaster complete - Completa todas as quests para o jogador")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "/questmaster reset - Reseta todas as quests para o jogador")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "/questmaster status - Mostra o status das quests do jogador")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "/questmaster target <nome> - Aplica o comando em outro jogador")
		return true
	end

	local targetPlayer = player
	if param:find("target ") then
		local targetName = param:sub(8) -- Remove "target " do início
		targetPlayer = Player(targetName)
		if not targetPlayer then
			player:sendCancelMessage("Jogador '" .. targetName .. "' não foi encontrado online.")
			return false
		end
		param = param:sub(1, 7) -- Pega apenas o comando (unlock, complete, reset, status)
	end

	if param == "unlock" then
		-- Libera todas as quests
		unlockAllQuests(targetPlayer)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Todas as quests foram liberadas para " .. targetPlayer:getName() .. "!")
		if targetPlayer ~= player then
			targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, player:getName() .. " liberou todas as quests para você!")
		end

	elseif param == "complete" then
		-- Completa todas as quests
		completeAllQuests(targetPlayer)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Todas as quests foram completadas para " .. targetPlayer:getName() .. "!")
		if targetPlayer ~= player then
			targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, player:getName() .. " completou todas as quests para você!")
		end

	elseif param == "reset" then
		-- Reseta todas as quests
		resetAllQuests(targetPlayer)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Todas as quests foram resetadas para " .. targetPlayer:getName() .. "!")
		if targetPlayer ~= player then
			targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, player:getName() .. " resetou todas as quests para você!")
		end

	elseif param == "status" then
		-- Mostra o status das quests
		showQuestStatus(player, targetPlayer)

	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Uso correto: /questmaster <unlock|complete|reset|status> [target <nome>]")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Use /questmaster help para ver todos os comandos disponíveis.")
	end

	return true
end

function unlockAllQuests(player)
	-- Lista de todas as quests principais do servidor
	local questStorages = {
		-- U7_2 - The Queen of the Banshees
		{10072, 1}, -- QuestLine
		{10073, 1}, -- FirstSeal
		{10075, 1}, -- SecondSeal
		{10077, 1}, -- ThirdSeal
		{10080, 1}, -- FourthSeal
		{10082, 1}, -- FifthSeal
		{10085, 1}, -- SixthSeal
		{10087, 1}, -- LastSeal

		-- U7_4 - The Ancient Tombs
		{10091, 1}, -- Ashmunrah
		{10092, 1}, -- Diprath
		{10093, 1}, -- Thalas

		-- U7_6 - The Ape City
		{10094, 1}, -- Chor
		{10095, 1}, -- Fibula
		{10096, 1}, -- Casks
		{10097, 1}, -- Dworc

		-- U7_8 - Outfits
		{10098, 1}, -- Beggar Outfits
		{10099, 1}, -- Hunter Outfits
		{10100, 1}, -- Mage and Summoner Outfits
		{10101, 1}, -- Nobleman Outfits
		{10102, 1}, -- Warrior Outfits

		-- U8_0 - Barbarian Arena
		{10103, 1}, -- Greenhorn
		{10104, 1}, -- Scrapper
		{10105, 1}, -- Warlord

		-- U8_1 - Secret Service
		{10106, 1}, -- CGB Mission 01
		{10107, 1}, -- TBI Mission 02
		{10108, 1}, -- AVIN Mission 02
		{10109, 1}, -- CGB Mission 02
		{10110, 1}, -- TBI Mission 03
		{10111, 1}, -- TBI Mission 04
		{10112, 1}, -- CGB Mission 04
		{10113, 1}, -- AVIN Mission 05
		{10114, 1}, -- CGB Mission 05
		{10115, 1}, -- Mission 07

		-- U8_2 - The Inquisition
		{10116, 1}, -- Mission 01
		{10117, 1}, -- Mission 02
		{10118, 1}, -- Mission 03
		{10119, 1}, -- Mission 04
		{10120, 1}, -- Mission 05
		{10121, 1}, -- Mission 06
		{10122, 1}, -- Mission 07
		{10123, 1}, -- Mission 08
		{10124, 1}, -- Mission 09
		{10125, 1}, -- Mission 10

		-- U8_4 - In Service of Yalahar
		{10126, 1}, -- Mission 01
		{10127, 1}, -- Mission 02
		{10128, 1}, -- Mission 03
		{10129, 1}, -- Mission 04
		{10130, 1}, -- Mission 05
		{10131, 1}, -- Mission 06
		{10132, 1}, -- Mission 07
		{10133, 1}, -- Mission 08
		{10134, 1}, -- Mission 09
		{10135, 1}, -- Mission 10

		-- U8_5 - Killing in the Name of
		{10136, 1}, -- Mission 01
		{10137, 1}, -- Mission 02
		{10138, 1}, -- Mission 03
		{10139, 1}, -- Mission 04
		{10140, 1}, -- Mission 05
		{10141, 1}, -- Mission 06
		{10142, 1}, -- Mission 07
		{10143, 1}, -- Mission 08
		{10144, 1}, -- Mission 09
		{10145, 1}, -- Mission 10

		-- U8_6 - Wrath of the Emperor
		{10146, 1}, -- Mission 01
		{10147, 1}, -- Mission 02
		{10148, 1}, -- Mission 03
		{10149, 1}, -- Mission 04
		{10150, 1}, -- Mission 05
		{10151, 1}, -- Mission 06
		{10152, 1}, -- Mission 07
		{10153, 1}, -- Mission 08
		{10154, 1}, -- Mission 09
		{10155, 1}, -- Mission 10
		{10156, 1}, -- Mission 11
		{10157, 1}, -- Mission 12

		-- U8_54 - The New Frontier
		{10158, 1}, -- Mission 01
		{10159, 1}, -- Mission 02
		{10160, 1}, -- Mission 03
		{10161, 1}, -- Mission 04
		{10162, 1}, -- Mission 05
		{10163, 1}, -- Mission 06
		{10164, 1}, -- Mission 07
		{10165, 1}, -- Mission 08
		{10166, 1}, -- Mission 09
		{10167, 1}, -- Mission 10

		-- U9_60 - Bigfoot's Burden
		{10168, 1}, -- Quest Line
		{10169, 1}, -- Rank

		-- U10_20 - Spike Task Quest
		{10170, 1}, -- Spike Fame Points

		-- U10_50 - Oramond Quest
		{10171, 1}, -- To Take Roots
		{10172, 1}, -- The Ancient Sewers

		-- U10_90 - Ferumbras Ascension
		{10173, 1}, -- Crystal 1
		{10174, 1}, -- Crystal 2
		{10175, 1}, -- Crystal 3
		{10176, 1}, -- Crystal 4
		{10177, 1}, -- Crystal 5
		{10178, 1}, -- Crystal 6
		{10179, 1}, -- Crystal 7
		{10180, 1}, -- Crystal 8
		{10181, 1}, -- All Crystals
		{10182, 1}, -- Ferumbras Essence

		-- U11_40 - Cults of Tibia
		{10183, 1}, -- Minotaurs Boss Access
		{10184, 1}, -- Minotaurs Access
		{10185, 1}, -- MotA Access Investigation
		{10186, 1}, -- MotA Access Gareth
		{10187, 1}, -- MotA Access Denominator
		{10188, 1}, -- Barkless Trial Access
		{10189, 1}, -- Barkless Tar Access
		{10190, 1}, -- Barkless Sulphur Access
		{10191, 1}, -- Barkless Access
		{10192, 1}, -- Barkless Boss Access
		{10193, 1}, -- Life Access
		{10194, 1}, -- Misguided Access
		{10195, 1}, -- Final Boss Access

		-- U11_80 - The Secret Library
		{10196, 1}, -- Small Islands Turtle

		-- Example Quest (do arquivo canary)
		{10001, 1}, -- Example Quest Example
	}

	-- Aplica todas as storages de quest
	for _, storageData in ipairs(questStorages) do
		local storageId, value = table.unpack(storageData)
		player:setStorageValue(storageId, value)
	end

	-- Atualiza o questlog
	player:sendQuestLog()
end

function completeAllQuests(player)
	-- Lista de todas as quests principais do servidor com valores de conclusão
	local questStorages = {
		-- U7_2 - The Queen of the Banshees
		{10072, 22}, -- QuestLine (completo)
		{10073, 1}, -- FirstSeal
		{10075, 1}, -- SecondSeal
		{10077, 1}, -- ThirdSeal
		{10080, 1}, -- FourthSeal
		{10082, 1}, -- FifthSeal
		{10085, 1}, -- SixthSeal
		{10087, 1}, -- LastSeal
		{10090, 1}, -- FinalBattle

		-- U7_4 - The Ancient Tombs
		{10091, 1}, -- Ashmunrah
		{10092, 1}, -- Diprath
		{10093, 1}, -- Thalas

		-- U7_6 - The Ape City
		{10094, 1}, -- Chor
		{10095, 1}, -- Fibula
		{10096, 1}, -- Casks
		{10097, 1}, -- Dworc

		-- U7_8 - Outfits
		{10098, 10}, -- Beggar Outfits (completo)
		{10099, 10}, -- Hunter Outfits (completo)
		{10100, 10}, -- Mage and Summoner Outfits (completo)
		{10101, 10}, -- Nobleman Outfits (completo)
		{10102, 10}, -- Warrior Outfits (completo)

		-- U8_0 - Barbarian Arena
		{10103, 1}, -- Greenhorn
		{10104, 1}, -- Scrapper
		{10105, 1}, -- Warlord

		-- U8_1 - Secret Service
		{10106, 1}, -- CGB Mission 01
		{10107, 1}, -- TBI Mission 02
		{10108, 1}, -- AVIN Mission 02
		{10109, 1}, -- CGB Mission 02
		{10110, 1}, -- TBI Mission 03
		{10111, 1}, -- TBI Mission 04
		{10112, 1}, -- CGB Mission 04
		{10113, 1}, -- AVIN Mission 05
		{10114, 1}, -- CGB Mission 05
		{10115, 1}, -- Mission 07

		-- U8_2 - The Inquisition
		{10116, 1}, -- Mission 01
		{10117, 1}, -- Mission 02
		{10118, 1}, -- Mission 03
		{10119, 1}, -- Mission 04
		{10120, 1}, -- Mission 05
		{10121, 1}, -- Mission 06
		{10122, 1}, -- Mission 07
		{10123, 1}, -- Mission 08
		{10124, 1}, -- Mission 09
		{10125, 1}, -- Mission 10

		-- U8_4 - In Service of Yalahar
		{10126, 1}, -- Mission 01
		{10127, 1}, -- Mission 02
		{10128, 1}, -- Mission 03
		{10129, 1}, -- Mission 04
		{10130, 1}, -- Mission 05
		{10131, 1}, -- Mission 06
		{10132, 1}, -- Mission 07
		{10133, 1}, -- Mission 08
		{10134, 1}, -- Mission 09
		{10135, 1}, -- Mission 10

		-- U8_5 - Killing in the Name of
		{10136, 1}, -- Mission 01
		{10137, 1}, -- Mission 02
		{10138, 1}, -- Mission 03
		{10139, 1}, -- Mission 04
		{10140, 1}, -- Mission 05
		{10141, 1}, -- Mission 06
		{10142, 1}, -- Mission 07
		{10143, 1}, -- Mission 08
		{10144, 1}, -- Mission 09
		{10145, 1}, -- Mission 10

		-- U8_6 - Wrath of the Emperor
		{10146, 1}, -- Mission 01
		{10147, 1}, -- Mission 02
		{10148, 1}, -- Mission 03
		{10149, 1}, -- Mission 04
		{10150, 1}, -- Mission 05
		{10151, 1}, -- Mission 06
		{10152, 1}, -- Mission 07
		{10153, 1}, -- Mission 08
		{10154, 1}, -- Mission 09
		{10155, 1}, -- Mission 10
		{10156, 1}, -- Mission 11
		{10157, 1}, -- Mission 12

		-- U8_54 - The New Frontier
		{10158, 1}, -- Mission 01
		{10159, 1}, -- Mission 02
		{10160, 1}, -- Mission 03
		{10161, 1}, -- Mission 04
		{10162, 1}, -- Mission 05
		{10163, 1}, -- Mission 06
		{10164, 1}, -- Mission 07
		{10165, 1}, -- Mission 08
		{10166, 1}, -- Mission 09
		{10167, 1}, -- Mission 10

		-- U9_60 - Bigfoot's Burden
		{10168, 30}, -- Quest Line (completo)
		{10169, 30}, -- Rank (máximo)

		-- U10_20 - Spike Task Quest
		{10170, 100}, -- Spike Fame Points (máximo)

		-- U10_50 - Oramond Quest
		{10171, 1}, -- To Take Roots
		{10172, 1}, -- The Ancient Sewers

		-- U10_90 - Ferumbras Ascension
		{10173, 1}, -- Crystal 1
		{10174, 1}, -- Crystal 2
		{10175, 1}, -- Crystal 3
		{10176, 1}, -- Crystal 4
		{10177, 1}, -- Crystal 5
		{10178, 1}, -- Crystal 6
		{10179, 1}, -- Crystal 7
		{10180, 1}, -- Crystal 8
		{10181, 1}, -- All Crystals
		{10182, 1}, -- Ferumbras Essence

		-- U11_40 - Cults of Tibia
		{10183, 1}, -- Minotaurs Boss Access
		{10184, 1}, -- Minotaurs Access
		{10185, 1}, -- MotA Access Investigation
		{10186, 1}, -- MotA Access Gareth
		{10187, 1}, -- MotA Access Denominator
		{10188, 1}, -- Barkless Trial Access
		{10189, 1}, -- Barkless Tar Access
		{10190, 1}, -- Barkless Sulphur Access
		{10191, 1}, -- Barkless Access
		{10192, 1}, -- Barkless Boss Access
		{10193, 1}, -- Life Access
		{10194, 1}, -- Misguided Access
		{10195, 1}, -- Final Boss Access

		-- U11_80 - The Secret Library
		{10196, 1}, -- Small Islands Turtle

		-- Example Quest (do arquivo canary)
		{10001, 1}, -- Example Quest Example
	}

	-- Aplica todas as storages de quest com valores de conclusão
	for _, storageData in ipairs(questStorages) do
		local storageId, value = table.unpack(storageData)
		player:setStorageValue(storageId, value)
	end

	-- Atualiza o questlog
	player:sendQuestLog()
end

function resetAllQuests(player)
	-- Lista de todas as quests principais do servidor
	local questStorages = {
		-- U7_2 - The Queen of the Banshees
		10072, 10073, 10075, 10077, 10080, 10082, 10085, 10087, 10090,

		-- U7_4 - The Ancient Tombs
		10091, 10092, 10093,

		-- U7_6 - The Ape City
		10094, 10095, 10096, 10097,

		-- U7_8 - Outfits
		10098, 10099, 10100, 10101, 10102,

		-- U8_0 - Barbarian Arena
		10103, 10104, 10105,

		-- U8_1 - Secret Service
		10106, 10107, 10108, 10109, 10110, 10111, 10112, 10113, 10114, 10115,

		-- U8_2 - The Inquisition
		10116, 10117, 10118, 10119, 10120, 10121, 10122, 10123, 10124, 10125,

		-- U8_4 - In Service of Yalahar
		10126, 10127, 10128, 10129, 10130, 10131, 10132, 10133, 10134, 10135,

		-- U8_5 - Killing in the Name of
		10136, 10137, 10138, 10139, 10140, 10141, 10142, 10143, 10144, 10145,

		-- U8_6 - Wrath of the Emperor
		10146, 10147, 10148, 10149, 10150, 10151, 10152, 10153, 10154, 10155, 10156, 10157,

		-- U8_54 - The New Frontier
		10158, 10159, 10160, 10161, 10162, 10163, 10164, 10165, 10166, 10167,

		-- U9_60 - Bigfoot's Burden
		10168, 10169,

		-- U10_20 - Spike Task Quest
		10170,

		-- U10_50 - Oramond Quest
		10171, 10172,

		-- U10_90 - Ferumbras Ascension
		10173, 10174, 10175, 10176, 10177, 10178, 10179, 10180, 10181, 10182,

		-- U11_40 - Cults of Tibia
		10183, 10184, 10185, 10186, 10187, 10188, 10189, 10190, 10191, 10192, 10193, 10194, 10195,

		-- U11_80 - The Secret Library
		10196,

		-- Example Quest (do arquivo canary)
		10001,
	}

	-- Reseta todas as storages de quest
	for _, storageId in ipairs(questStorages) do
		player:setStorageValue(storageId, -1)
	end

	-- Atualiza o questlog
	player:sendQuestLog()
end

function showQuestStatus(player, targetPlayer)
	local questCount = 0
	local completedCount = 0

	-- Lista de todas as quests principais do servidor
	local questStorages = {
		-- U7_2 - The Queen of the Banshees
		{10072, "The Queen of the Banshees"},
		{10073, "First Seal"},
		{10075, "Second Seal"},
		{10077, "Third Seal"},
		{10080, "Fourth Seal"},
		{10082, "Fifth Seal"},
		{10085, "Sixth Seal"},
		{10087, "Last Seal"},

		-- U7_4 - The Ancient Tombs
		{10091, "Ashmunrah Tomb"},
		{10092, "Diprath Tomb"},
		{10093, "Thalas Tomb"},

		-- U7_6 - The Ape City
		{10094, "Chor Quest"},
		{10095, "Fibula Quest"},
		{10096, "Casks Quest"},
		{10097, "Dworc Quest"},

		-- U7_8 - Outfits
		{10098, "Beggar Outfits"},
		{10099, "Hunter Outfits"},
		{10100, "Mage and Summoner Outfits"},
		{10101, "Nobleman Outfits"},
		{10102, "Warrior Outfits"},

		-- U8_0 - Barbarian Arena
		{10103, "Greenhorn Arena"},
		{10104, "Scrapper Arena"},
		{10105, "Warlord Arena"},

		-- U8_1 - Secret Service
		{10106, "CGB Mission 01"},
		{10107, "TBI Mission 02"},
		{10108, "AVIN Mission 02"},
		{10109, "CGB Mission 02"},
		{10110, "TBI Mission 03"},
		{10111, "TBI Mission 04"},
		{10112, "CGB Mission 04"},
		{10113, "AVIN Mission 05"},
		{10114, "CGB Mission 05"},
		{10115, "Mission 07"},

		-- U8_2 - The Inquisition
		{10116, "Inquisition Mission 01"},
		{10117, "Inquisition Mission 02"},
		{10118, "Inquisition Mission 03"},
		{10119, "Inquisition Mission 04"},
		{10120, "Inquisition Mission 05"},
		{10121, "Inquisition Mission 06"},
		{10122, "Inquisition Mission 07"},
		{10123, "Inquisition Mission 08"},
		{10124, "Inquisition Mission 09"},
		{10125, "Inquisition Mission 10"},

		-- U8_4 - In Service of Yalahar
		{10126, "Yalahar Mission 01"},
		{10127, "Yalahar Mission 02"},
		{10128, "Yalahar Mission 03"},
		{10129, "Yalahar Mission 04"},
		{10130, "Yalahar Mission 05"},
		{10131, "Yalahar Mission 06"},
		{10132, "Yalahar Mission 07"},
		{10133, "Yalahar Mission 08"},
		{10134, "Yalahar Mission 09"},
		{10135, "Yalahar Mission 10"},

		-- U8_5 - Killing in the Name of
		{10136, "Killing Mission 01"},
		{10137, "Killing Mission 02"},
		{10138, "Killing Mission 03"},
		{10139, "Killing Mission 04"},
		{10140, "Killing Mission 05"},
		{10141, "Killing Mission 06"},
		{10142, "Killing Mission 07"},
		{10143, "Killing Mission 08"},
		{10144, "Killing Mission 09"},
		{10145, "Killing Mission 10"},

		-- U8_6 - Wrath of the Emperor
		{10146, "Emperor Mission 01"},
		{10147, "Emperor Mission 02"},
		{10148, "Emperor Mission 03"},
		{10149, "Emperor Mission 04"},
		{10150, "Emperor Mission 05"},
		{10151, "Emperor Mission 06"},
		{10152, "Emperor Mission 07"},
		{10153, "Emperor Mission 08"},
		{10154, "Emperor Mission 09"},
		{10155, "Emperor Mission 10"},
		{10156, "Emperor Mission 11"},
		{10157, "Emperor Mission 12"},

		-- U8_54 - The New Frontier
		{10158, "New Frontier Mission 01"},
		{10159, "New Frontier Mission 02"},
		{10160, "New Frontier Mission 03"},
		{10161, "New Frontier Mission 04"},
		{10162, "New Frontier Mission 05"},
		{10163, "New Frontier Mission 06"},
		{10164, "New Frontier Mission 07"},
		{10165, "New Frontier Mission 08"},
		{10166, "New Frontier Mission 09"},
		{10167, "New Frontier Mission 10"},

		-- U9_60 - Bigfoot's Burden
		{10168, "Bigfoot's Burden Quest Line"},
		{10169, "Bigfoot's Burden Rank"},

		-- U10_20 - Spike Task Quest
		{10170, "Spike Task Quest"},

		-- U10_50 - Oramond Quest
		{10171, "Oramond To Take Roots"},
		{10172, "Oramond Ancient Sewers"},

		-- U10_90 - Ferumbras Ascension
		{10173, "Ferumbras Crystal 1"},
		{10174, "Ferumbras Crystal 2"},
		{10175, "Ferumbras Crystal 3"},
		{10176, "Ferumbras Crystal 4"},
		{10177, "Ferumbras Crystal 5"},
		{10178, "Ferumbras Crystal 6"},
		{10179, "Ferumbras Crystal 7"},
		{10180, "Ferumbras Crystal 8"},
		{10181, "Ferumbras All Crystals"},
		{10182, "Ferumbras Essence"},

		-- U11_40 - Cults of Tibia
		{10183, "Cults Minotaurs Boss Access"},
		{10184, "Cults Minotaurs Access"},
		{10185, "Cults MotA Access Investigation"},
		{10186, "Cults MotA Access Gareth"},
		{10187, "Cults MotA Access Denominator"},
		{10188, "Cults Barkless Trial Access"},
		{10189, "Cults Barkless Tar Access"},
		{10190, "Cults Barkless Sulphur Access"},
		{10191, "Cults Barkless Access"},
		{10192, "Cults Barkless Boss Access"},
		{10193, "Cults Life Access"},
		{10194, "Cults Misguided Access"},
		{10195, "Cults Final Boss Access"},

		-- U11_80 - The Secret Library
		{10196, "Secret Library Small Islands"},

		-- Example Quest (do arquivo canary)
		{10001, "Example Quest"},
	}

	player:sendTextMessage(MESSAGE_INFO_DESCR, "=== STATUS DAS QUESTS DE " .. targetPlayer:getName():upper() .. " ===")

	-- Verifica o status de cada quest
	for _, questData in ipairs(questStorages) do
		local storageId, questName = table.unpack(questData)
		local value = targetPlayer:getStorageValue(storageId)

		if value > -1 then
			questCount = questCount + 1
			if value >= 1 then
				completedCount = completedCount + 1
				player:sendTextMessage(MESSAGE_INFO_DESCR, questName .. ": COMPLETADA (valor: " .. value .. ")")
			else
				player:sendTextMessage(MESSAGE_INFO_DESCR, questName .. ": INICIADA (valor: " .. value .. ")")
			end
		else
			player:sendTextMessage(MESSAGE_INFO_DESCR, questName .. ": NÃO INICIADA")
		end
	end

	player:sendTextMessage(MESSAGE_INFO_DESCR, "=== RESUMO ===")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "Total de quests: " .. #questStorages)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "Quests iniciadas: " .. questCount)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "Quests completadas: " .. completedCount)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "Quests não iniciadas: " .. (#questStorages - questCount))
end

talkaction:groupType("normal")
talkaction:separator(" ")
talkaction:register()
