local talkaction = TalkAction("/testquest")

function talkaction.onSay(player, words, param)

	player:sendTextMessage(MESSAGE_INFO_DESCR, "=== TESTE DO SISTEMA DE QUESTS ===")

	-- Testa algumas storages específicas
	local testStorages = {
		{10001, "Example Quest"},
		{10072, "Queen of the Banshees QuestLine"},
		{10098, "Beggar Outfits"},
		{10103, "Greenhorn Arena"},
		{10116, "Inquisition Mission 01"},
		{10126, "Yalahar Mission 01"},
		{10146, "Emperor Mission 01"},
		{10173, "Ferumbras Crystal 1"},
		{10183, "Cults Minotaurs Boss Access"}
	}

	player:sendTextMessage(MESSAGE_INFO_DESCR, "Verificando storages de teste...")

	for _, storageData in ipairs(testStorages) do
		local storageId, storageName = table.unpack(storageData)
		local value = player:getStorageValue(storageId)

		if value == -1 then
			player:sendTextMessage(MESSAGE_INFO_DESCR, storageName .. " (ID: " .. storageId .. "): NÃO INICIADA")
		else
			player:sendTextMessage(MESSAGE_INFO_DESCR, storageName .. " (ID: " .. storageId .. "): VALOR = " .. value)
		end
	end

	player:sendTextMessage(MESSAGE_INFO_DESCR, "=== TESTE CONCLUÍDO ===")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "Use /questmaster help para ver comandos disponíveis")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "Use /questcategory help para ver comandos de categoria")

	return true
end

talkaction:groupType("normal")
talkaction:separator(" ")
talkaction:register()
