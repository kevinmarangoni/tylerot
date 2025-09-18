local talkaction = TalkAction("/questcategory")

function talkaction.onSay(player, words, param)
	local param = param:lower()

	if param == "help" then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "=== COMANDOS DE QUEST CATEGORY ===")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "/questcategory outfits unlock - Libera todas as quests de outfits")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "/questcategory outfits complete - Completa todas as quests de outfits")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "/questcategory arena unlock - Libera todas as quests de arena")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "/questcategory arena complete - Completa todas as quests de arena")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "/questcategory inquisition unlock - Libera todas as quests da inquisição")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "/questcategory inquisition complete - Completa todas as quests da inquisição")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "/questcategory yalahar unlock - Libera todas as quests de Yalahar")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "/questcategory yalahar complete - Completa todas as quests de Yalahar")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "/questcategory emperor unlock - Libera todas as quests do imperador")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "/questcategory emperor complete - Completa todas as quests do imperador")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "/questcategory ferumbras unlock - Libera todas as quests de Ferumbras")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "/questcategory ferumbras complete - Completa todas as quests de Ferumbras")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "/questcategory cults unlock - Libera todas as quests de cultos")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "/questcategory cults complete - Completa todas as quests de cultos")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "/questcategory target <nome> <categoria> <acao> - Aplica em outro jogador")
		return true
	end

	local targetPlayer = player
	local category = ""
	local action = ""

	-- Verifica se é para outro jogador
	if param:find("target ") then
		local parts = {}
		for part in param:gmatch("%S+") do
			table.insert(parts, part)
		end

		if #parts >= 4 then
			local targetName = parts[2]
			targetPlayer = Player(targetName)
			if not targetPlayer then
				player:sendCancelMessage("Jogador '" .. targetName .. "' não foi encontrado online.")
				return false
			end
			category = parts[3]
			action = parts[4]
		else
			player:sendCancelMessage("Uso: /questcategory target <nome> <categoria> <acao>")
			return false
		end
	else
		-- Para o jogador atual
		local parts = {}
		for part in param:gmatch("%S+") do
			table.insert(parts, part)
		end

		if #parts >= 2 then
			category = parts[1]
			action = parts[2]
		else
			player:sendCancelMessage("Uso: /questcategory <categoria> <acao>")
			return false
		end
	end

	-- Processa a categoria e ação
	if category == "outfits" then
		processOutfitsQuests(targetPlayer, action, player)
	elseif category == "arena" then
		processArenaQuests(targetPlayer, action, player)
	elseif category == "inquisition" then
		processInquisitionQuests(targetPlayer, action, player)
	elseif category == "yalahar" then
		processYalaharQuests(targetPlayer, action, player)
	elseif category == "emperor" then
		processEmperorQuests(targetPlayer, action, player)
	elseif category == "ferumbras" then
		processFerumbrasQuests(targetPlayer, action, player)
	elseif category == "cults" then
		processCultsQuests(targetPlayer, action, player)
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Categoria inválida. Use /questcategory help para ver as categorias disponíveis.")
	end

	return true
end

function processOutfitsQuests(player, action, admin)
	local questStorages = {
		{10098, "Beggar Outfits", 10},
		{10099, "Hunter Outfits", 10},
		{10100, "Mage and Summoner Outfits", 10},
		{10101, "Nobleman Outfits", 10},
		{10102, "Warrior Outfits", 10}
	}

	processQuestCategory(player, action, admin, questStorages, "Outfits")
end

function processArenaQuests(player, action, admin)
	local questStorages = {
		{10103, "Greenhorn Arena", 1},
		{10104, "Scrapper Arena", 1},
		{10105, "Warlord Arena", 1}
	}

	processQuestCategory(player, action, admin, questStorages, "Arena")
end

function processInquisitionQuests(player, action, admin)
	local questStorages = {
		{10116, "Inquisition Mission 01", 1},
		{10117, "Inquisition Mission 02", 1},
		{10118, "Inquisition Mission 03", 1},
		{10119, "Inquisition Mission 04", 1},
		{10120, "Inquisition Mission 05", 1},
		{10121, "Inquisition Mission 06", 1},
		{10122, "Inquisition Mission 07", 1},
		{10123, "Inquisition Mission 08", 1},
		{10124, "Inquisition Mission 09", 1},
		{10125, "Inquisition Mission 10", 1}
	}

	processQuestCategory(player, action, admin, questStorages, "Inquisição")
end

function processYalaharQuests(player, action, admin)
	local questStorages = {
		{10126, "Yalahar Mission 01", 1},
		{10127, "Yalahar Mission 02", 1},
		{10128, "Yalahar Mission 03", 1},
		{10129, "Yalahar Mission 04", 1},
		{10130, "Yalahar Mission 05", 1},
		{10131, "Yalahar Mission 06", 1},
		{10132, "Yalahar Mission 07", 1},
		{10133, "Yalahar Mission 08", 1},
		{10134, "Yalahar Mission 09", 1},
		{10135, "Yalahar Mission 10", 1}
	}

	processQuestCategory(player, action, admin, questStorages, "Yalahar")
end

function processEmperorQuests(player, action, admin)
	local questStorages = {
		{10146, "Emperor Mission 01", 1},
		{10147, "Emperor Mission 02", 1},
		{10148, "Emperor Mission 03", 1},
		{10149, "Emperor Mission 04", 1},
		{10150, "Emperor Mission 05", 1},
		{10151, "Emperor Mission 06", 1},
		{10152, "Emperor Mission 07", 1},
		{10153, "Emperor Mission 08", 1},
		{10154, "Emperor Mission 09", 1},
		{10155, "Emperor Mission 10", 1},
		{10156, "Emperor Mission 11", 1},
		{10157, "Emperor Mission 12", 1}
	}

	processQuestCategory(player, action, admin, questStorages, "Imperador")
end

function processFerumbrasQuests(player, action, admin)
	local questStorages = {
		{10173, "Ferumbras Crystal 1", 1},
		{10174, "Ferumbras Crystal 2", 1},
		{10175, "Ferumbras Crystal 3", 1},
		{10176, "Ferumbras Crystal 4", 1},
		{10177, "Ferumbras Crystal 5", 1},
		{10178, "Ferumbras Crystal 6", 1},
		{10179, "Ferumbras Crystal 7", 1},
		{10180, "Ferumbras Crystal 8", 1},
		{10181, "Ferumbras All Crystals", 1},
		{10182, "Ferumbras Essence", 1}
	}

	processQuestCategory(player, action, admin, questStorages, "Ferumbras")
end

function processCultsQuests(player, action, admin)
	local questStorages = {
		{10183, "Cults Minotaurs Boss Access", 1},
		{10184, "Cults Minotaurs Access", 1},
		{10185, "Cults MotA Access Investigation", 1},
		{10186, "Cults MotA Access Gareth", 1},
		{10187, "Cults MotA Access Denominator", 1},
		{10188, "Cults Barkless Trial Access", 1},
		{10189, "Cults Barkless Tar Access", 1},
		{10190, "Cults Barkless Sulphur Access", 1},
		{10191, "Cults Barkless Access", 1},
		{10192, "Cults Barkless Boss Access", 1},
		{10193, "Cults Life Access", 1},
		{10194, "Cults Misguided Access", 1},
		{10195, "Cults Final Boss Access", 1}
	}

	processQuestCategory(player, action, admin, questStorages, "Cultos")
end

function processQuestCategory(player, action, admin, questStorages, categoryName)
	if action == "unlock" then
		-- Libera as quests da categoria
		for _, questData in ipairs(questStorages) do
			local storageId, questName, _ = table.unpack(questData)
			player:setStorageValue(storageId, 1)
		end

		admin:sendTextMessage(MESSAGE_INFO_DESCR, "Todas as quests de " .. categoryName .. " foram liberadas para " .. player:getName() .. "!")
		if admin ~= player then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, admin:getName() .. " liberou todas as quests de " .. categoryName .. " para você!")
		end

	elseif action == "complete" then
		-- Completa as quests da categoria
		for _, questData in ipairs(questStorages) do
			local storageId, questName, completeValue = table.unpack(questData)
			player:setStorageValue(storageId, completeValue)
		end

		admin:sendTextMessage(MESSAGE_INFO_DESCR, "Todas as quests de " .. categoryName .. " foram completadas para " .. player:getName() .. "!")
		if admin ~= player then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, admin:getName() .. " completou todas as quests de " .. categoryName .. " para você!")
		end

	else
		admin:sendTextMessage(MESSAGE_INFO_DESCR, "Ação inválida. Use 'unlock' ou 'complete'.")
		return
	end

	-- Atualiza o questlog
	player:sendQuestLog()
end

talkaction:groupType("normal")
talkaction:separator(" ")
talkaction:register()
