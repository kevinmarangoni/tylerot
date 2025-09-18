local talkaction = TalkAction("/premium")

function talkaction.onSay(player, words, param)
	local param = param:lower()

	if param == "help" then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "=== COMANDOS DE PREMIUM MANAGER ===")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "/premium add 1ano <nome> - Adiciona 1 ano de premium")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "/premium add 6meses <nome> - Adiciona 6 meses de premium")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "/premium add 1mes <nome> - Adiciona 1 mês de premium")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "/premium add 1semana <nome> - Adiciona 1 semana de premium")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "/premium add 1dia <nome> - Adiciona 1 dia de premium")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "/premium remove <nome> - Remove premium do jogador")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "/premium status <nome> - Mostra status do premium")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "/premium list - Lista jogadores com premium")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "/premium add 1ano - Adiciona 1 ano de premium para você")
		return true
	end

	local parts = {}
	for part in param:gmatch("%S+") do
		table.insert(parts, part)
	end

	if #parts == 0 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Uso: /premium <comando> [tempo] [nome]")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Use /premium help para ver todos os comandos disponíveis.")
		return true
	end

	local command = parts[1]

	if command == "add" then
		if #parts < 2 then
			player:sendTextMessage(MESSAGE_INFO_DESCR, "Uso: /premium add <tempo> [nome]")
			player:sendTextMessage(MESSAGE_INFO_DESCR, "Tempos disponíveis: 1ano, 6meses, 1mes, 1semana, 1dia")
			return true
		end

		local timeAmount = parts[2]
		local targetPlayer = player
		local targetName = player:getName()

		if #parts >= 3 then
			targetName = parts[3]
			targetPlayer = Player(targetName)
			if not targetPlayer then
				player:sendCancelMessage("Jogador '" .. targetName .. "' não foi encontrado online.")
				return false
			end
		end

		addPremium(targetPlayer, timeAmount, player)

	elseif command == "remove" then
		if #parts < 2 then
			player:sendTextMessage(MESSAGE_INFO_DESCR, "Uso: /premium remove <nome>")
			return true
		end

		local targetName = parts[2]
		local targetPlayer = Player(targetName)
		if not targetPlayer then
			player:sendCancelMessage("Jogador '" .. targetName .. "' não foi encontrado online.")
			return false
		end

		removePremium(targetPlayer, player)

	elseif command == "status" then
		if #parts < 2 then
			player:sendTextMessage(MESSAGE_INFO_DESCR, "Uso: /premium status <nome>")
			return true
		end

		local targetName = parts[2]
		local targetPlayer = Player(targetName)
		if not targetPlayer then
			player:sendCancelMessage("Jogador '" .. targetName .. "' não foi encontrado online.")
			return false
		end

		showPremiumStatus(targetPlayer, player)

	elseif command == "list" then
		listPremiumPlayers(player)

	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Comando inválido. Use /premium help para ver os comandos disponíveis.")
	end

	return true
end

function addPremium(targetPlayer, timeAmount, admin)
	local currentTime = os.time()
	local premiumTime = 0
	local timeDescription = ""

	-- Converte o tempo para segundos
	if timeAmount == "1ano" or timeAmount == "1ano" then
		premiumTime = 365 * 24 * 60 * 60 -- 1 ano em segundos
		timeDescription = "1 ano"
	elseif timeAmount == "6meses" or timeAmount == "6meses" then
		premiumTime = 6 * 30 * 24 * 60 * 60 -- 6 meses em segundos
		timeDescription = "6 meses"
	elseif timeAmount == "1mes" or timeAmount == "1mes" then
		premiumTime = 30 * 24 * 60 * 60 -- 1 mês em segundos
		timeDescription = "1 mês"
	elseif timeAmount == "1semana" or timeAmount == "1semana" then
		premiumTime = 7 * 24 * 60 * 60 -- 1 semana em segundos
		timeDescription = "1 semana"
	elseif timeAmount == "1dia" or timeAmount == "1dia" then
		premiumTime = 24 * 60 * 60 -- 1 dia em segundos
		timeDescription = "1 dia"
	else
		admin:sendTextMessage(MESSAGE_INFO_DESCR, "Tempo inválido. Use: 1ano, 6meses, 1mes, 1semana, 1dia")
		return
	end

	-- Verifica se o jogador já tem premium
	local currentPremium = targetPlayer:getPremiumDays()
	local newPremiumTime = 0

	if currentPremium > 0 then
		-- Se já tem premium, adiciona ao tempo existente
		newPremiumTime = currentPremium + (premiumTime / (24 * 60 * 60))
	else
		-- Se não tem premium, define o novo tempo
		newPremiumTime = premiumTime / (24 * 60 * 60)
	end

	-- Aplica o premium usando o método correto do Canary
	if targetPlayer.setPremiumDays then
		targetPlayer:setPremiumDays(math.floor(newPremiumTime))
	elseif targetPlayer.addPremiumDays then
		-- Se setPremiumDays não existir, tenta addPremiumDays
		local daysToAdd = math.floor(premiumTime / (24 * 60 * 60))
		targetPlayer:addPremiumDays(daysToAdd)
		newPremiumTime = targetPlayer:getPremiumDays()
	else
		-- Fallback: tenta usar storage para premium
		local premiumStorage = 3000 -- Storage padrão para premium
		targetPlayer:setStorageValue(premiumStorage, math.floor(newPremiumTime))
		admin:sendTextMessage(MESSAGE_INFO_DESCR, "⚠️ Método premium não encontrado. Usando storage alternativo.")
	end

	-- Mensagens de confirmação
	admin:sendTextMessage(MESSAGE_INFO_DESCR, "Premium de " .. timeDescription .. " adicionado para " .. targetPlayer:getName() .. "!")
	admin:sendTextMessage(MESSAGE_INFO_DESCR, "Total de premium: " .. math.floor(newPremiumTime) .. " dias")

	if admin ~= targetPlayer then
		targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, admin:getName() .. " adicionou " .. timeDescription .. " de premium para você!")
		targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Seu premium total: " .. math.floor(newPremiumTime) .. " dias")
	else
		targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você adicionou " .. timeDescription .. " de premium para si mesmo!")
		targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Seu premium total: " .. math.floor(newPremiumTime) .. " dias")
	end

	-- Atualiza o jogador
	if targetPlayer.reloadData then
		targetPlayer:reloadData()
	end
end

function removePremium(targetPlayer, admin)
	-- Remove todo o premium usando o método correto do Canary
	if targetPlayer.setPremiumDays then
		targetPlayer:setPremiumDays(0)
	elseif targetPlayer.addPremiumDays then
		-- Se não conseguir remover diretamente, tenta definir como 0
		local currentPremium = targetPlayer:getPremiumDays()
		if currentPremium > 0 then
			targetPlayer:addPremiumDays(-currentPremium)
		end
	else
		-- Fallback: usa storage
		local premiumStorage = 3000
		targetPlayer:setStorageValue(premiumStorage, 0)
		admin:sendTextMessage(MESSAGE_INFO_DESCR, "⚠️ Método premium não encontrado. Usando storage alternativo.")
	end

	-- Mensagens de confirmação
	admin:sendTextMessage(MESSAGE_INFO_DESCR, "Premium removido de " .. targetPlayer:getName() .. "!")

	if admin ~= targetPlayer then
		targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, admin:getName() .. " removeu seu premium!")
	else
		targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você removeu seu próprio premium!")
	end

	-- Atualiza o jogador
	if targetPlayer.reloadData then
		targetPlayer:reloadData()
	end
end

function showPremiumStatus(targetPlayer, admin)
	local premiumDays = targetPlayer:getPremiumDays()
	local isPremium = targetPlayer:isPremium()

	admin:sendTextMessage(MESSAGE_INFO_DESCR, "=== STATUS DO PREMIUM DE " .. targetPlayer:getName():upper() .. " ===")
	admin:sendTextMessage(MESSAGE_INFO_DESCR, "Premium Ativo: " .. (isPremium and "SIM" or "NÃO"))
	admin:sendTextMessage(MESSAGE_INFO_DESCR, "Dias Restantes: " .. premiumDays)

	if premiumDays > 0 then
		local years = math.floor(premiumDays / 365)
		local months = math.floor((premiumDays % 365) / 30)
		local days = premiumDays % 30

		admin:sendTextMessage(MESSAGE_INFO_DESCR, "Tempo Restante: " .. years .. " anos, " .. months .. " meses, " .. days .. " dias")

		-- Calcula quando expira
		local currentTime = os.time()
		local expireTime = currentTime + (premiumDays * 24 * 60 * 60)
		local expireDate = os.date("%d/%m/%Y às %H:%M", expireTime)
		admin:sendTextMessage(MESSAGE_INFO_DESCR, "Expira em: " .. expireDate)
	else
		admin:sendTextMessage(MESSAGE_INFO_DESCR, "Jogador não possui premium ativo.")
	end
end

function listPremiumPlayers(admin)
	local players = Game.getPlayers()
	local premiumPlayers = {}

	for _, player in ipairs(players) do
		if player:isPremium() then
			local premiumDays = player:getPremiumDays()
			table.insert(premiumPlayers, {name = player:getName(), days = premiumDays})
		end
	end

	if #premiumPlayers == 0 then
		admin:sendTextMessage(MESSAGE_INFO_DESCR, "Nenhum jogador com premium ativo encontrado online.")
		return
	end

	-- Ordena por dias de premium (maior para menor)
	table.sort(premiumPlayers, function(a, b) return a.days > b.days end)

	admin:sendTextMessage(MESSAGE_INFO_DESCR, "=== JOGADORES COM PREMIUM ONLINE ===")
	admin:sendTextMessage(MESSAGE_INFO_DESCR, "Total: " .. #premiumPlayers .. " jogadores")

	for i, playerData in ipairs(premiumPlayers) do
		local years = math.floor(playerData.days / 365)
		local months = math.floor((playerData.days % 365) / 30)
		local days = playerData.days % 30

		local timeStr = ""
		if years > 0 then
			timeStr = years .. "a " .. months .. "m " .. days .. "d"
		elseif months > 0 then
			timeStr = months .. "m " .. days .. "d"
		else
			timeStr = days .. "d"
		end

		admin:sendTextMessage(MESSAGE_INFO_DESCR, i .. ". " .. playerData.name .. " - " .. timeStr .. " (" .. playerData.days .. " dias)")
	end
end

talkaction:groupType("normal")
talkaction:separator(" ")
talkaction:register()
