local talkaction = TalkAction("/liberartudo")

function talkaction.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		player:sendCancelMessage("Você não tem permissão para usar este comando.")
		return false
	end

	player:sendTextMessage(MESSAGE_INFO_DESCR, "=== 🚀 LIBERANDO TUDO - COMANDO MASTER ===")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "🔮 Este comando irá liberar todas as limitações do servidor!")

	-- Executa todas as liberações
	local results = {}

	-- 1. Liberar magias
	player:sendTextMessage(MESSAGE_INFO_DESCR, "")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "=== 🔮 LIBERANDO MAGIAS ===")
	results.magias = liberarMagias(player)

	-- 2. Remover limitações
	player:sendTextMessage(MESSAGE_INFO_DESCR, "")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "=== 🚫 REMOVENDO LIMITAÇÕES ===")
	results.limitacoes = removerLimitacoes(player)

	-- 3. Zerar store
	player:sendTextMessage(MESSAGE_INFO_DESCR, "")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "=== 🛒 ZERANDO STORE ===")
	results.store = zerarStore(player)

	-- Resultado final
	player:sendTextMessage(MESSAGE_INFO_DESCR, "")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "=== 🎉 LIBERAÇÃO COMPLETA ===")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "🔮 Magias: " .. (results.magias and "✅ LIBERADAS" or "❌ FALHOU"))
	player:sendTextMessage(MESSAGE_INFO_DESCR, "🚫 Limitações: " .. (results.limitacoes and "✅ REMOVIDAS" or "❌ FALHOU"))
	player:sendTextMessage(MESSAGE_INFO_DESCR, "🛒 Store: " .. (results.store and "✅ ZERADA" or "❌ FALHOU"))

	player:sendTextMessage(MESSAGE_INFO_DESCR, "")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "🎊 TODAS AS LIBERAÇÕES FORAM EXECUTADAS!")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "💡 Agora todos os jogadores têm acesso total ao servidor!")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "🔄 REINICIE O SERVIDOR PARA APLICAR TODAS AS MUDANÇAS!")

	return true
end

-- Função para liberar magias
function liberarMagias(player)
	local spellDirectories = {
		"data/scripts/spells/",
		"data-otservbr-global/scripts/spells/"
	}

	local totalSpells = 0
	local liberatedSpells = 0

	for _, spellDir in ipairs(spellDirectories) do
		local spells = processSpellDirectory(spellDir, player)
		if spells then
			totalSpells = totalSpells + spells.total
			liberatedSpells = liberatedSpells + spells.liberated
		end
	end

	player:sendTextMessage(MESSAGE_INFO_DESCR, "✅ " .. liberatedSpells .. " magias premium foram liberadas!")
	return liberatedSpells > 0
end

-- Função para remover limitações
function removerLimitacoes(player)
	local filesToModify = {
		{path = "data/chatchannels/scripts/english_chat.lua",
		 search = "if player:getLevel%(%) < 20 and not player:isPremium%(%) then",
		 replace = "if player:getLevel() < 20 and false then"},

		{path = "data/chatchannels/scripts/advertising.lua",
		 search = "if player:getLevel%(%) < 20 and not player:isPremium%(%) then",
		 replace = "if player:getLevel() < 20 and false then"},

		{path = "data/libs/functions/quests.lua",
		 search = "return self:isPremium%(%) and 25 or 10",
		 replace = "return 25"},

		{path = "data/scripts/actions/objects/skill_trainer.lua",
		 search = "if not player:isPremium%(%) then",
		 replace = "if false then"},

		{path = "data/scripts/talkactions/player/buy_house.lua",
		 search = "if not player:isPremium%(%) then",
		 replace = "if false then"},

		{path = "data/scripts/actions/items/usable_outfit_items.lua",
		 search = "if not player:isPremium%(%) then",
		 replace = "if false then"},

		{path = "data/scripts/actions/items/usable_mount_items.lua",
		 search = "if not player:isPremium%(%) then",
		 replace = "if false then"},

		{path = "data/scripts/actions/items/usable_afflicted_outfit_items.lua",
		 search = "if not player:isPremium%(%) then",
		 replace = "if false then"}
	}

	local modifiedFiles = 0
	for _, fileInfo in ipairs(filesToModify) do
		local result = processFile(fileInfo.path, fileInfo.search, fileInfo.replace, player)
		if result then
			modifiedFiles = modifiedFiles + 1
		end
	end

	player:sendTextMessage(MESSAGE_INFO_DESCR, "✅ " .. modifiedFiles .. " limitações foram removidas!")
	return modifiedFiles > 0
end

-- Função para zerar store
function zerarStore(player)
	local storeFile = "data/modules/scripts/gamestore/gamestore.lua"

	local file = io.open(storeFile, "r")
	if not file then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "❌ Arquivo da store não encontrado!")
		return false
	end

	local content = file:read("*all")
	file:close()

	local priceCount = 0
	for _ in content:gmatch("price%s*=%s*[%d]+") do
		priceCount = priceCount + 1
	end

	local newContent = content:gsub("price%s*=%s*([%d]+)", "price = 0")

	local success = saveFile(storeFile, newContent)

	if success then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "✅ " .. priceCount .. " preços foram zerados!")
		return true
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, "❌ Erro ao salvar a store!")
		return false
	end
end

-- Funções auxiliares
function processSpellDirectory(directory, player)
	local spells = {total = 0, liberated = 0}

	if not io.open(directory .. "dummy", "r") then
		return nil
	end

	local spellFiles = {
		"attack/ultimate_light_strike.lua", "attack/ultimate_ice_strike.lua",
		"attack/ultimate_flame_strike.lua", "attack/ultimate_energy_strike.lua",
		"attack/ultimate_terra_strike.lua", "attack/ethereal_spear.lua",
		"support/ultimate_light.lua", "support/swift_foot.lua",
		"support/strong_haste.lua", "support/protector.lua",
		"support/magic_rope.lua", "support/blood_rage.lua",
		"healing/salvation.lua", "healing/nature's_embrace.lua",
		"healing/mass_healing.lua", "conjuring/wild_growth_rune.lua",
		"conjuring/thunderstorm_rune.lua", "conjuring/stone_shower_rune.lua"
	}

	for _, spellFile in ipairs(spellFiles) do
		local fullPath = directory .. spellFile
		local result = processSpellFile(fullPath)

		if result then
			spells.total = spells.total + 1
			if result.liberated then
				spells.liberated = spells.liberated + 1
			end
		end
	end

	return spells
end

function processSpellFile(filePath)
	local file = io.open(filePath, "r")
	if not file then
		return nil
	end

	local content = file:read("*all")
	file:close()

	if content:find("spell:isPremium%(true%)") then
		local newContent = content:gsub("spell:isPremium%(true%)", "spell:isPremium(false)")
		local success = saveFile(filePath, newContent)
		return {liberated = success}
	end

	return {liberated = false}
end

function processFile(filePath, searchPattern, replacePattern)
	local file = io.open(filePath, "r")
	if not file then
		return false
	end

	local content = file:read("*all")
	file:close()

	if content:find(searchPattern) then
		local newContent = content:gsub(searchPattern, replacePattern)
		return saveFile(filePath, newContent)
	end

	return true
end

function saveFile(filePath, content)
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
