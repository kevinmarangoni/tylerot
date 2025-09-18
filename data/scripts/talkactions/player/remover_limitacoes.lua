local talkaction = TalkAction("/removerlimitacoes")

function talkaction.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		player:sendCancelMessage("Você não tem permissão para usar este comando.")
		return false
	end
	
	player:sendTextMessage(MESSAGE_INFO_DESCR, "=== 🚫 REMOVENDO TODAS AS LIMITAÇÕES PREMIUM ===")
	
	local totalFiles = 0
	local modifiedFiles = 0
	local failedFiles = 0
	
	-- Lista de arquivos com limitações de premium
	local filesToModify = {
		-- Chat channels
		{path = "data/chatchannels/scripts/english_chat.lua", 
		 search = "if player:getLevel%(%) < 20 and not player:isPremium%(%) then",
		 replace = "if player:getLevel() < 20 and false then"},
		
		{path = "data/chatchannels/scripts/advertising.lua",
		 search = "if player:getLevel%(%) < 20 and not player:isPremium%(%) then",
		 replace = "if player:getLevel() < 20 and false then"},
		
		-- Quest system
		{path = "data/libs/functions/quests.lua",
		 search = "return self:isPremium%(%) and 25 or 10",
		 replace = "return 25"},
		
		-- Skill trainer
		{path = "data/scripts/actions/objects/skill_trainer.lua",
		 search = "if not player:isPremium%(%) then",
		 replace = "if false then"},
		
		-- House buying
		{path = "data/scripts/talkactions/player/buy_house.lua",
		 search = "if not player:isPremium%(%) then",
		 replace = "if false then"},
		
		-- Outfit items
		{path = "data/scripts/actions/items/usable_outfit_items.lua",
		 search = "if not player:isPremium%(%) then",
		 replace = "if false then"},
		
		-- Mount items
		{path = "data/scripts/actions/items/usable_mount_items.lua",
		 search = "if not player:isPremium%(%) then",
		 replace = "if false then"},
		
		-- Afflicted outfit items
		{path = "data/scripts/actions/items/usable_afflicted_outfit_items.lua",
		 search = "if not player:isPremium%(%) then",
		 replace = "if false then"},
		
		-- Fury gates
		{path = "data-otservbr-global/scripts/world_changes/fury_gates.lua",
		 search = "if not player:isPremium%(%) or not player:isPromoted%(%) or player:getLevel%(%) < 60 then",
		 replace = "if not player:isPromoted() or player:getLevel() < 60 then"},
		
		-- Premium bridge
		{path = "data-otservbr-global/scripts/movements/rookgaard/premium_bridge.lua",
		 search = "if player:isPremium%(%) then",
		 replace = "if true then"},
		
		-- Login scripts
		{path = "data-otservbr-global/scripts/creaturescripts/others/login.lua",
		 search = "if not player:isPremium%(%) and not table.contains%(freeTowns, player:getTown%(%)%:getName%(%)%) then",
		 replace = "if not table.contains(freeTowns, player:getTown():getName()) then"},
		
		{path = "data-otservbr-global/scripts/creaturescripts/others/login.lua",
		 search = "if home and not player:isPremium%(%) then",
		 replace = "if false then"},
		
		-- Familiar system
		{path = "data/scripts/creaturescripts/familiar/on_login.lua",
		 search = "if %(not player:isPremium%(%) and player:hasFamiliar%(vocation.id%)%) or player:getLevel%(%) < 200 then",
		 replace = "if player:getLevel() < 200 then"},
		
		{path = "data/scripts/creaturescripts/familiar/on_login.lua",
		 search = "elseif player:isPremium%(%) and player:getLevel%(%) >= 200 then",
		 replace = "elseif player:getLevel() >= 200 then"},
		
		{path = "data/scripts/creaturescripts/familiar/on_advance.lua",
		 search = "if newLevel < 200 and not player:isPremium%(%) then",
		 replace = "if false then"},
		
		-- Player functions
		{path = "data/libs/functions/player.lua",
		 search = "if not self:isPremium%(%) then",
		 replace = "if false then"},
		
		{path = "data/libs/functions/player.lua",
		 search = "if staminaMinutes > 2340 and self:isPremium%(%) then",
		 replace = "if staminaMinutes > 2340 then"},
		
		-- Daily reward
		{path = "data/libs/systems/daily_reward.lua",
		 search = "if %(configManager.getBoolean%(configKeys.VIP_SYSTEM_ENABLED%) and player:isVip%(%)%) or player:isPremium%(%) then",
		 replace = "if true then"},
		
		-- Events
		{path = "data/events/scripts/player.lua",
		 search = "if self:isPremium%(%) then",
		 replace = "if true then"}
	}
	
	player:sendTextMessage(MESSAGE_INFO_DESCR, "🔍 Procurando por arquivos com limitações...")
	
	-- Processa cada arquivo
	for _, fileInfo in ipairs(filesToModify) do
		totalFiles = totalFiles + 1
		local result = processFile(fileInfo.path, fileInfo.search, fileInfo.replace, player)
		
		if result then
			modifiedFiles = modifiedFiles + 1
		else
			failedFiles = failedFiles + 1
		end
	end
	
	-- Resultado final
	player:sendTextMessage(MESSAGE_INFO_DESCR, "")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "=== 📊 RESULTADO FINAL ===")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "📁 Total de arquivos processados: " .. totalFiles)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "✅ Arquivos modificados: " .. modifiedFiles)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "❌ Falharam: " .. failedFiles)
	
	if modifiedFiles > 0 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "🎉 " .. modifiedFiles .. " limitações foram removidas!")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "💡 Agora todos os jogadores têm acesso premium!")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "🔄 Reinicie o servidor para aplicar as mudanças!")
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, "")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "⚠️ Nenhuma limitação foi encontrada ou removida.")
	end
	
	return true
end

function processFile(filePath, searchPattern, replacePattern, player)
	-- Verifica se o arquivo existe
	local file = io.open(filePath, "r")
	if not file then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "❌ Arquivo não encontrado: " .. filePath)
		return false
	end
	
	local content = file:read("*all")
	file:close()
	
	-- Verifica se o padrão existe no arquivo
	if content:find(searchPattern) then
		-- Substitui o padrão
		local newContent = content:gsub(searchPattern, replacePattern)
		
		-- Salva o arquivo modificado
		local success = saveFile(filePath, newContent)
		
		if success then
			player:sendTextMessage(MESSAGE_INFO_DESCR, "✅ " .. filePath:match("([^/]+%.lua)$") .. " - Limitação removida!")
			return true
		else
			player:sendTextMessage(MESSAGE_INFO_DESCR, "❌ " .. filePath:match("([^/]+%.lua)$") .. " - Falhou ao salvar!")
			return false
		end
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, "ℹ️ " .. filePath:match("([^/]+%.lua)$") .. " - Padrão não encontrado")
		return true
	end
end

function saveFile(filePath, content)
	-- Tenta salvar o arquivo
	local file = io.open(filePath, "w")
	if file then
		file:write(content)
		file:close()
		return true
	else
		return false
	end
end

talkaction:groupType(1, 1) -- Apenas administradores
talkaction:separator(" ")
talkaction:register()
