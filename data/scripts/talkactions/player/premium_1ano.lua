local talkaction = TalkAction("/1ano")

function talkaction.onSay(player, words, param)
	if param == "" then
		-- Adiciona 1 ano de premium para o próprio jogador
		addOneYearPremium(player)
		return true
	end

	-- Adiciona 1 ano de premium para outro jogador
	local targetPlayer = Player(param)
	if not targetPlayer then
		player:sendCancelMessage("Jogador '" .. param .. "' não foi encontrado online.")
		return false
	end

	addOneYearPremium(targetPlayer)
	return true
end

function addOneYearPremium(targetPlayer)
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
		targetPlayer:sendTextMessage(MESSAGE_INFO_DESCR, "⚠️ Método premium não encontrado. Usando storage alternativo.")
	end

	-- Mensagens de confirmação
	targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "🎉 1 ANO de premium adicionado!")
	targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "📅 Seu premium total: " .. math.floor(newPremiumTime) .. " dias")

	-- Atualiza o jogador
	if targetPlayer.reloadData then
		targetPlayer:reloadData()
	end
end

talkaction:groupType("normal")
talkaction:separator(" ")
talkaction:register()
