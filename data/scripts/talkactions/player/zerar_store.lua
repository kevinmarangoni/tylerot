local talkaction = TalkAction("/zerarstore")

function talkaction.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		player:sendCancelMessage("Você não tem permissão para usar este comando.")
		return false
	end

	player:sendTextMessage(MESSAGE_INFO_DESCR, "=== 🛒 ZERANDO TODOS OS PREÇOS DA STORE ===")

	-- Caminho para o arquivo da store
	local storeFile = "data/modules/scripts/gamestore/gamestore.lua"

	-- Verifica se o arquivo existe
	local file = io.open(storeFile, "r")
	if not file then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "❌ Arquivo da store não encontrado: " .. storeFile)
		return false
	end

	local content = file:read("*all")
	file:close()

	-- Conta quantos preços existem
	local priceCount = 0
	for _ in content:gmatch("price%s*=%s*[%d]+") do
		priceCount = priceCount + 1
	end

	player:sendTextMessage(MESSAGE_INFO_DESCR, "🔍 Encontrados " .. priceCount .. " itens com preços na store")

	-- Substitui todos os preços por 0
	local newContent = content:gsub("price%s*=%s*([%d]+)", "price = 0")

	-- Conta quantos preços foram alterados
	local newPriceCount = 0
	for _ in newContent:gmatch("price%s*=%s*0") do
		newPriceCount = newPriceCount + 1
	end

	-- Salva o arquivo modificado
	local success = saveStoreFile(storeFile, newContent)

	if success then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "✅ " .. newPriceCount .. " preços foram zerados com sucesso!")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "🎉 Agora todos os itens da store são gratuitos!")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "💡 Reinicie o servidor para aplicar as mudanças!")
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, "❌ Erro ao salvar o arquivo da store!")
	end

	return true
end

function saveStoreFile(filePath, content)
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
