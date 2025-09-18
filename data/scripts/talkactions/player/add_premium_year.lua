local talkaction = TalkAction("/addpremium")

function talkaction.onSay(player, words, param)
	if param == "" then
		-- Adiciona 1 ano de premium para o próprio jogador
		addPremiumYear(player, player)
		return true
	end

	-- Adiciona 1 ano de premium para outro jogador
	local targetPlayer = Player(param)
	if not targetPlayer then
		player:sendCancelMessage("Jogador '" .. param .. "' não foi encontrado online.")
		return false
	end

	addPremiumYear(targetPlayer, player)
	return true
end

function addPremiumYear(targetPlayer, admin)
	-- 1 ano = 365 dias
	local oneYearInDays = 365

	-- Verifica se o jogador já tem premium
	local currentPremium = targetPlayer:getPremiumDays()
	local newPremiumTime = 0

	if currentPremium > 0 then
		-- Se já tem premium, adiciona 1 ano ao tempo existente
		newPremiumTime = currentPremium + oneYearInDays
	else
		-- Se não tem premium, define 1 ano
		newPremiumTime = oneYearInDays
	end

	-- Aplica o premium usando o método correto do Canary
	-- No Canary, usamos setPremiumDays() ou addPremiumDays()
	if targetPlayer.setPremiumDays then
		targetPlayer:setPremiumDays(math.floor(newPremiumTime))
	elseif targetPlayer.addPremiumDays then
		-- Se setPremiumDays não existir, tenta addPremiumDays
		targetPlayer:addPremiumDays(oneYearInDays)
		newPremiumTime = targetPlayer:getPremiumDays()
	else
		-- Fallback: tenta usar storage para premium
		local premiumStorage = 3000 -- Storage padrão para premium
		targetPlayer:setStorageValue(premiumStorage, newPremiumTime)
		admin:sendTextMessage(MESSAGE_INFO_DESCR, "⚠️ Método premium não encontrado. Usando storage alternativo.")
	end

	-- Mensagens de confirmação
	admin:sendTextMessage(MESSAGE_INFO_DESCR, "✅ 1 ANO de premium adicionado para " .. targetPlayer:getName() .. "!")
	admin:sendTextMessage(MESSAGE_INFO_DESCR, "📅 Total de premium: " .. math.floor(newPremiumTime) .. " dias")

	if admin ~= targetPlayer then
		targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "🎉 " .. admin:getName() .. " adicionou 1 ANO de premium para você!")
		targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "📅 Seu premium total: " .. math.floor(newPremiumTime) .. " dias")
	else
		targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "🎉 Você adicionou 1 ANO de premium para si mesmo!")
		targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "📅 Seu premium total: " .. math.floor(newPremiumTime) .. " dias")
	end

	-- Atualiza o jogador
	if targetPlayer.reloadData then
		targetPlayer:reloadData()
	end
end

talkaction:groupType("normal")
talkaction:separator(" ")
talkaction:register()
