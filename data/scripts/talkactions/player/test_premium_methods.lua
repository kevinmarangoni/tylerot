local talkaction = TalkAction("/testpremium")

function talkaction.onSay(player, words, param)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "=== TESTE DE MÉTODOS PREMIUM ===")

	-- Testa métodos disponíveis
	local methods = {
		"setPremiumDays",
		"addPremiumDays",
		"getPremiumDays",
		"isPremium",
		"reloadData"
	}

	player:sendTextMessage(MESSAGE_INFO_DESCR, "Métodos disponíveis para premium:")

	for _, methodName in ipairs(methods) do
		local method = player[methodName]
		if method then
			player:sendTextMessage(MESSAGE_INFO_DESCR, "✅ " .. methodName .. " - DISPONÍVEL")
		else
			player:sendTextMessage(MESSAGE_INFO_DESCR, "❌ " .. methodName .. " - NÃO DISPONÍVEL")
		end
	end

	-- Testa métodos específicos
	player:sendTextMessage(MESSAGE_INFO_DESCR, "")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "=== TESTE DE FUNCIONALIDADE ===")

	-- Testa getPremiumDays
	if player.getPremiumDays then
		local premiumDays = player:getPremiumDays()
		player:sendTextMessage(MESSAGE_INFO_DESCR, "📅 Dias de premium atuais: " .. premiumDays)
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, "❌ getPremiumDays não disponível")
	end

	-- Testa isPremium
	if player.isPremium then
		local isPremium = player:isPremium()
		player:sendTextMessage(MESSAGE_INFO_DESCR, "🎯 Premium ativo: " .. (isPremium and "SIM" or "NÃO"))
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, "❌ isPremium não disponível")
	end

	-- Testa métodos de modificação
	player:sendTextMessage(MESSAGE_INFO_DESCR, "")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "=== MÉTODOS DE MODIFICAÇÃO ===")

	if player.setPremiumDays then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "✅ setPremiumDays - PODE DEFINIR VALOR DIRETO")
	elseif player.addPremiumDays then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "✅ addPremiumDays - PODE ADICIONAR DIAS")
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, "❌ Nenhum método de modificação disponível")
	end

	-- Sugestões
	player:sendTextMessage(MESSAGE_INFO_DESCR, "")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "=== SUGESTÕES ===")

	if not player.setPremiumDays and not player.addPremiumDays then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "⚠️ Usar storage alternativo para premium")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "💡 Storage ID sugerido: 3000")
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, "✅ Sistema premium funcionando normalmente")
	end

	return true
end

talkaction:groupType("normal")
talkaction:separator(" ")
talkaction:register()
