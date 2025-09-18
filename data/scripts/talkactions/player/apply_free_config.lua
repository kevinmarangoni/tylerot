local talkaction = TalkAction("/applyfreeconfig")

function talkaction.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		player:sendCancelMessage("Você não tem permissão para usar este comando.")
		return false
	end

	player:sendTextMessage(MESSAGE_INFO_DESCR, "=== 🔓 APLICANDO CONFIGURAÇÕES FREE ACCOUNTS ===")

	-- Lista de configurações que serão aplicadas
	local configs = {
		{name = "freePremium", value = true, description = "Premium gratuito para todos"},
		{name = "vipSystemEnabled", value = true, description = "Sistema VIP ativo"},
		{name = "vipStayOnline", value = true, description = "VIP não é kickado por inatividade"},
		{name = "vipKeepHouse", value = true, description = "VIP mantém casa offline"},
		{name = "preyFreeThirdSlot", value = true, description = "Terceiro slot de prey para todos"},
		{name = "taskHuntingFreeThirdSlot", value = true, description = "Terceiro slot de task hunting para todos"},
		{name = "toggleTravelsFree", value = true, description = "Viagens gratuitas de barco"},
		{name = "premiumToCreateMarketOffer", value = false, description = "Market acessível para todos"}
	}

	player:sendTextMessage(MESSAGE_INFO_DESCR, "📋 Configurações que serão aplicadas:")

	for i, config in ipairs(configs) do
		player:sendTextMessage(MESSAGE_INFO_DESCR, i .. ". " .. config.name .. " = " .. tostring(config.value) .. " - " .. config.description)
	end

	player:sendTextMessage(MESSAGE_INFO_DESCR, "")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "⚠️ ATENÇÃO: Este comando aplica as configurações automaticamente!")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "💡 Para aplicar manualmente, edite o config.lua e reinicie o servidor.")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "📁 Arquivo: config.lua (na raiz do servidor)")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "🔄 Após editar, reinicie o servidor com: ./start.sh")

	-- Tenta aplicar algumas configurações via script (se possível)
	applyConfigurations(player)

	return true
end

function applyConfigurations(player)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "=== 🔧 APLICANDO CONFIGURAÇÕES VIA SCRIPT ===")

	-- Tenta aplicar configurações que podem ser alteradas via script
	local applied = 0
	local failed = 0

	-- Configurações que podem ser aplicadas via script
	local scriptConfigs = {
		{name = "preyFreeThirdSlot", setter = "setPreyFreeThirdSlot", value = true},
		{name = "taskHuntingFreeThirdSlot", setter = "setTaskHuntingFreeThirdSlot", value = true},
		{name = "toggleTravelsFree", setter = "setTravelsFree", value = true}
	}

	for _, config in ipairs(scriptConfigs) do
		if Game[config.setter] then
			Game[config.setter](Game, config.value)
			player:sendTextMessage(MESSAGE_INFO_DESCR, "✅ " .. config.name .. " aplicado via script")
			applied = applied + 1
		else
			player:sendTextMessage(MESSAGE_INFO_DESCR, "❌ " .. config.name .. " não pode ser aplicado via script")
			failed = failed + 1
		end
	end

	player:sendTextMessage(MESSAGE_INFO_DESCR, "")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "📊 Resultado:")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "   ✅ Aplicados via script: " .. applied)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "   ❌ Falharam via script: " .. failed)

	if failed > 0 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "⚠️ Algumas configurações precisam ser aplicadas manualmente no config.lua!")
	end
end

talkaction:groupType(1, 1) -- Apenas administradores
talkaction:separator(" ")
talkaction:register()
