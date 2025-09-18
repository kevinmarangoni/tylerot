local teleport = TalkAction("/tp")

-- Tabela com todas as localizações de teleporte
local teleportLocations = {
	-- Livrarias
	["livraria entrada"] = Position(32522, 32538, 12),
	["livraria ice"] = Position(32458, 32587, 12),
	["livraria fire"] = Position(32647, 32611, 12),
	["livraria energy"] = Position(32479, 32778, 11),

	-- Esqueletinho
	["esqueletinho baixo"] = Position(32943, 32280, 10),
	["esqueletinho entrada"] = Position(32956, 32320, 8),

	-- Cobras
	["cobras entrada"] = Position(32956, 32320, 8),
	["cobras baixo"] = Position(32956, 32320, 8), -- ATENÇÃO: Mesma coordenada da entrada

	-- Soulwar
	["soulwar entrada"] = Position(33621, 31425, 10),
	["soulwar thais invertida"] = Position(33888, 31185, 10),
	["soulwar brachiodemon"] = Position(34011, 31014, 9),
	["soulwar piranha"] = Position(33895, 31020, 8),
	["soulwar cloak"] = Position(33863, 31832, 3),
	["soulwar rotten golem"] = Position(33970, 31041, 11),

	-- Gnomprona
	["gnomprona carrinhos"] = Position(33546, 32908, 15),
	["gnomprona magma"] = Position(33662, 32895, 14),
	["gnomprona primal"] = Position(33714, 32799, 14),

	-- Rottenblood
	["rottenblood darklight"] = Position(34119, 31877, 14),
	["rottenblood putrefactory"] = Position(34101, 31680, 13),
	["rottenblood gloom pillars"] = Position(33809, 31817, 13),
	["rottenblood jaded roots"] = Position(33842, 31653, 13),

	-- Ferumbras
	["ferumbras baixo"] = Position(33309, 32377, 13),
	["ferumbras juggerseal"] = Position(33428, 32447, 13),

	-- Ingol
	["ingol -1"] = Position(33791, 32567, 8),
	["ingol entrada"] = Position(33711, 32602, 6),

	-- Goanna
	["goanna west"] = Position(33871, 31603, 6),
	["goanna sul"] = Position(33939, 31547, 6)
}

function teleport.onSay(player, words, param)
	if param == "" then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Uso: /tp <localização>\n\nLocais disponíveis:\n" ..
			"- livraria entrada, livraria ice, livraria fire, livraria energy\n" ..
			"- esqueletinho baixo, esqueletinho entrada\n" ..
			"- cobras entrada, cobras baixo\n" ..
			"- soulwar entrada, soulwar thais invertida, soulwar brachiodemon, soulwar piranha, soulwar cloak, soulwar rotten golem\n" ..
			"- gnomprona carrinhos, gnomprona magma, gnomprona primal\n" ..
			"- rottenblood darklight, rottenblood putrefactory, rottenblood gloom pillars, rottenblood jaded roots\n" ..
			"- ferumbras baixo, ferumbras juggerseal\n" ..
			"- ingol -1, ingol entrada\n" ..
			"- goanna west, goanna sul")
		return true
	end

	-- Converte o parâmetro para minúsculas para facilitar a busca
	local location = param:lower()

	-- Procura pela localização na tabela
	local targetPosition = teleportLocations[location]

	if targetPosition then
		-- Teleporta o jogador
		player:teleportTo(targetPosition)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Teleportado para: " .. param)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Localização não encontrada: " .. param .. "\nUse /tp para ver todos os locais disponíveis.")
	end

	return true
end

teleport:setDescription("Comando de teleporte para várias localizações do servidor")
teleport:groupType("normal")
teleport:register()
