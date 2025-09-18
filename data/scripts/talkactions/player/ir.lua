

local talkaction = TalkAction("/ir")

-- Tabela com todas as localizações de teleporte organizadas por categoria
local teleportLocations = {
	-- 🏠 CIDADES E TOWNS
	["thais"] = Position(32369, 32237, 7), -- Templo de Thais (centro)
	["venore"] = Position(32957, 32076, 7),
	["carlin"] = Position(32360, 31782, 7),
	["ab'dendriel"] = Position(32732, 31634, 7),
	["rookgaard"] = Position(32097, 32205, 7),
	["kazordoon"] = Position(32649, 31925, 11),
	["darashia"] = Position(33289, 32480, 1),
	["ankrahmun"] = Position(33092, 32883, 6),
	["port hope"] = Position(32527, 32744, 7),
	["svargrond"] = Position(32255, 31033, 7),
	["liberty bay"] = Position(32285, 32892, 7),
	["yalahar"] = Position(32816, 31272, 7),
	["oramond"] = Position(33479, 31964, 7),
	["edron"] = Position(33217, 31814, 7),
	["tibia"] = Position(32369, 32241, 7),
	
	-- Variações para Thais
	["thais templo"] = Position(32369, 32237, 7), -- Templo de Thais
	["templo thais"] = Position(32369, 32237, 7), -- Templo de Thais
	["templo de thais"] = Position(32369, 32237, 7), -- Templo de Thais

	-- 🏰 DUNGEONS POPULARES
	["dragon"] = Position(32957, 32360, 7),
	["dragon lord"] = Position(32957, 32360, 7),
	["dragon lord entrance"] = Position(32957, 32360, 7),
	["hero"] = Position(32732, 31634, 7),
	["hero entrance"] = Position(32732, 31634, 7),
	["warlock"] = Position(32360, 32241, 7),
	["warlock entrance"] = Position(32360, 32241, 7),
	["necromancer"] = Position(32360, 32241, 7),
	["necromancer entrance"] = Position(32360, 32241, 7),
	["paladin"] = Position(32360, 32241, 7),
	["paladin entrance"] = Position(32360, 32241, 7),

	-- 🏛️ QUEST AREAS
	["inquisition"] = Position(33059, 31914, 11),
	["inquisition entrance"] = Position(33059, 31914, 11),
	["yalahar quest"] = Position(32816, 31272, 7),
	["yalahar entrance"] = Position(32816, 31272, 7),
	["emperor"] = Position(33059, 31914, 11),
	["emperor entrance"] = Position(33059, 31914, 11),
	["ferumbras"] = Position(33309, 32377, 13),
	["ferumbras entrance"] = Position(33309, 32377, 13),
	["cults"] = Position(33059, 31914, 11),
	["cults entrance"] = Position(33059, 31914, 11),

	-- 🎭 ARENAS E BATTLES
	["arena"] = Position(32360, 32241, 7),
	["arena entrance"] = Position(32360, 32241, 7),
	["warrior guild"] = Position(32360, 32241, 7),
	["wizard guild"] = Position(32360, 32241, 7),
	["paladin guild"] = Position(32360, 32241, 7),
	["knight guild"] = Position(32360, 32241, 7),

	-- 🏪 SHOPS E SERVIÇOS
	["shop"] = Position(32360, 32241, 7),
	["bank"] = Position(32360, 32241, 7),
	["depot"] = Position(32360, 32241, 7),
	["temple"] = Position(32360, 32241, 7),
	["post office"] = Position(32360, 32241, 7),
	["magic shop"] = Position(32360, 32241, 7),
	["weapon shop"] = Position(32360, 32241, 7),
	["armor shop"] = Position(32360, 32241, 7),

	-- 🌍 LOCAÇÕES ESPECIAIS
	["trainer"] = Position(32360, 32241, 7),
	["trainer entrance"] = Position(32360, 32241, 7),
	["hunt"] = Position(32360, 32241, 7),
	["hunt entrance"] = Position(32360, 32241, 7),
	["boss"] = Position(32360, 32241, 7),
	["boss entrance"] = Position(32360, 32241, 7),
	["quest"] = Position(32360, 32241, 7),
	["quest entrance"] = Position(32360, 32241, 7),

	-- 📚 LIVRARIAS (COORDENADAS CORRETAS)
	["livraria entrada"] = Position(32522, 32538, 12),
	["livraria ice"] = Position(32458, 32587, 12),
	["livraria fire"] = Position(32647, 32611, 12),
	["livraria energy"] = Position(32479, 32778, 11),
	["livraria de ice"] = Position(32458, 32587, 12),
	["livraria de fire"] = Position(32647, 32611, 12),
	["livraria de energy"] = Position(32479, 32778, 11),

	-- 💀 ESQUELETINHO (COORDENADAS CORRETAS)
	["esqueletinho baixo"] = Position(32943, 32280, 10),
	["esqueletinho entrada"] = Position(32956, 32320, 8),

	-- 🐍 COBRAS (COORDENADAS CORRETAS)
	["cobras entrada"] = Position(32956, 32320, 8),
	["cobras baixo"] = Position(32956, 32320, 8),

	-- ⚔️ SOULWAR (COORDENADAS CORRETAS)
	["soulwar entrada"] = Position(33621, 31425, 10),
	["soulwar thais invertida"] = Position(33888, 31185, 10),
	["soulwar brachiodemon"] = Position(34011, 31014, 9),
	["soulwar piranha"] = Position(33895, 31020, 8),
	["soulwar cloak"] = Position(33863, 31832, 3),
	["soulwar rotten golem"] = Position(33970, 31041, 11),

	-- 🏔️ GNOMPRONA (COORDENADAS CORRETAS)
	["gnomprona carrinhos"] = Position(33546, 32908, 15),
	["gnomprona magma"] = Position(33662, 32895, 14),
	["gnomprona primal"] = Position(33714, 32799, 14),

	-- 🩸 ROTTENBLOOD (COORDENADAS CORRETAS)
	["rottenblood darklight"] = Position(34119, 31877, 14),
	["rottenblood putrefactory"] = Position(34101, 31680, 13),
	["rottenblood gloom pillars"] = Position(33809, 31817, 13),
	["rottenblood jaded roots"] = Position(33842, 31653, 13),

	-- 🔥 FERUMBRAS (COORDENADAS CORRETAS)
	["ferumbras baixo"] = Position(33309, 32377, 13),
	["ferumbras juggerseal"] = Position(33428, 32447, 13),

	-- 🏰 INGOL (COORDENADAS CORRETAS)
	["ingol -1"] = Position(33791, 32567, 8),
	["ingol entrada"] = Position(33711, 32602, 6),

	-- 🦎 GOANNA (COORDENADAS CORRETAS)
	["goanna west"] = Position(33871, 31603, 6),
	["goanna sul"] = Position(33939, 31547, 6),
	["Goanna west"] = Position(33871, 31603, 6),
	["Goanna sul"] = Position(33939, 31547, 6)
}

function talkaction.onSay(player, words, param)
	if param == "" then
		showHelp(player)
		return true
	end

	if param == "help" then
		showHelp(player)
		return true
	end

	if param == "list" then
		showAllLocations(player)
		return true
	end

	-- Converte o parâmetro para minúsculas para facilitar a busca
	local location = param:lower()

	-- Procura pela localização na tabela
	local targetPosition = teleportLocations[location]

	if targetPosition then
		-- Teleporta o jogador
		player:teleportTo(targetPosition)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "🚀 Teleportado para: " .. param)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)

		-- Log da ação
		logger.info("[TELEPORT] {} foi teleportado para {} ({}, {}, {})",
			player:getName(), param, targetPosition.x, targetPosition.y, targetPosition.z)
	else
		-- Tenta encontrar localizações similares
		local suggestions = findSimilarLocations(location)
		if #suggestions > 0 then
			player:sendTextMessage(MESSAGE_INFO_DESCR, "❌ Localização não encontrada: " .. param)
			player:sendTextMessage(MESSAGE_INFO_DESCR, "💡 Você quis dizer uma destas?")
			for i, suggestion in ipairs(suggestions) do
				if i <= 5 then -- Mostra apenas 5 sugestões
					player:sendTextMessage(MESSAGE_INFO_DESCR, "   • " .. suggestion)
				end
			end
		else
			player:sendTextMessage(MESSAGE_INFO_DESCR, "❌ Localização não encontrada: " .. param)
			player:sendTextMessage(MESSAGE_INFO_DESCR, "💡 Use /ir help para ver todos os locais disponíveis")
		end
	end

	return true
end

function showHelp(player)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "=== 🚀 COMANDO /IR - TELEPORTE INTELIGENTE ===")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "Uso: /ir <localização>")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "📋 Comandos disponíveis:")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "   /ir <nome>     - Teleporta para o local")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "   /ir help       - Mostra esta ajuda")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "   /ir list       - Lista todos os locais")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "🏠 CIDADES: thais, venore, carlin, ab'dendriel, rookgaard")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "🏛️ TEMPLOS: thais templo, templo thais, templo de thais")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "🏰 DUNGEONS: dragon, hero, warlock, necromancer, paladin")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "🏛️ QUESTS: inquisition, yalahar, emperor, ferumbras, cults")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "🎭 ARENAS: arena, warrior guild, wizard guild")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "🏪 SHOPS: shop, bank, depot, temple, post office")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "📚 LIVRARIAS: livraria entrada, livraria ice, livraria fire, livraria energy")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "💀 ESQUELETINHO: esqueletinho baixo, esqueletinho entrada")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "🐍 COBRAS: cobras entrada, cobras baixo")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "⚔️ SOULWAR: soulwar entrada, soulwar thais invertida, soulwar brachiodemon")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "🏔️ GNOMPRONA: gnomprona carrinhos, gnomprona magma, gnomprona primal")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "🩸 ROTTENBLOOD: rottenblood darklight, rottenblood putrefactory")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "🔥 FERUMBRAS: ferumbras baixo, ferumbras juggerseal")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "🏰 INGOL: ingol -1, ingol entrada")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "🦎 GOANNA: goanna west, goanna sul")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "💡 Dica: Use /ir list para ver todos os locais disponíveis!")
end

function showAllLocations(player)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "=== 📋 TODOS OS LOCAIS DISPONÍVEIS ===")

	local categories = {
		{"🏠 CIDADES", {"thais", "venore", "carlin", "ab'dendriel", "rookgaard", "kazordoon", "darashia", "ankrahmun", "port hope", "svargrond", "liberty bay", "yalahar", "oramond", "edron", "tibia"}},
		{"🏛️ TEMPLOS", {"thais templo", "templo thais", "templo de thais"}},
		{"🏰 DUNGEONS", {"dragon", "hero", "warlock", "necromancer", "paladin", "dragon lord", "hero entrance", "warlock entrance", "necromancer entrance", "paladin entrance"}},
		{"🏛️ QUESTS", {"inquisition", "yalahar quest", "emperor", "ferumbras", "cults", "inquisition entrance", "yalahar entrance", "emperor entrance", "ferumbras entrance", "cults entrance"}},
		{"🎭 ARENAS", {"arena", "warrior guild", "wizard guild", "paladin guild", "knight guild", "arena entrance"}},
		{"🏪 SHOPS", {"shop", "bank", "depot", "temple", "post office", "magic shop", "weapon shop", "armor shop"}},
		{"🌍 ESPECIAIS", {"trainer", "hunt", "boss", "quest", "trainer entrance", "hunt entrance", "boss entrance", "quest entrance"}},
		{"📚 LIVRARIAS", {"livraria entrada", "livraria ice", "livraria fire", "livraria energy", "livraria de ice", "livraria de fire", "livraria de energy"}},
		{"💀 ESQUELETINHO", {"esqueletinho baixo", "esqueletinho entrada"}},
		{"🐍 COBRAS", {"cobras entrada", "cobras baixo"}},
		{"⚔️ SOULWAR", {"soulwar entrada", "soulwar thais invertida", "soulwar brachiodemon", "soulwar piranha", "soulwar cloak", "soulwar rotten golem"}},
		{"🏔️ GNOMPRONA", {"gnomprona carrinhos", "gnomprona magma", "gnomprona primal"}},
		{"🩸 ROTTENBLOOD", {"rottenblood darklight", "rottenblood putrefactory", "rottenblood gloom pillars", "rottenblood jaded roots"}},
		{"🔥 FERUMBRAS", {"ferumbras baixo", "ferumbras juggerseal"}},
		{"🏰 INGOL", {"ingol -1", "ingol entrada"}},
		{"🦎 GOANNA", {"goanna west", "goanna sul", "Goanna west", "Goanna sul"}}
	}

	for _, category in ipairs(categories) do
		player:sendTextMessage(MESSAGE_INFO_DESCR, "")
		player:sendTextMessage(MESSAGE_INFO_DESCR, category[1] .. ":")
		local locations = category[2]
		local line = ""
		for i, location in ipairs(locations) do
			line = line .. location
			if i % 3 == 0 or i == #locations then
				player:sendTextMessage(MESSAGE_INFO_DESCR, "   " .. line)
				line = ""
			else
				line = line .. ", "
			end
		end
	end

	player:sendTextMessage(MESSAGE_INFO_DESCR, "")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "💡 Total: " .. getTotalLocations() .. " locais disponíveis")
end

function findSimilarLocations(searchTerm)
	local suggestions = {}
	local searchLower = searchTerm:lower()

	for location, _ in pairs(teleportLocations) do
		if location:find(searchLower) or searchLower:find(location:sub(1, 3)) then
			table.insert(suggestions, location)
		end
	end

	-- Ordena por relevância (mais similares primeiro)
	table.sort(suggestions, function(a, b)
		local aScore = calculateSimilarity(a, searchTerm)
		local bScore = calculateSimilarity(b, searchTerm)
		return aScore > bScore
	end)

	return suggestions
end

function calculateSimilarity(str1, str2)
	local str1Lower = str1:lower()
	local str2Lower = str2:lower()

	if str1Lower == str2Lower then
		return 100
	elseif str1Lower:find(str2Lower) or str2Lower:find(str1Lower) then
		return 80
	elseif str1Lower:sub(1, 3) == str2Lower:sub(1, 3) then
		return 60
	else
		return 0
	end
end

function getTotalLocations()
	local count = 0
	for _ in pairs(teleportLocations) do
		count = count + 1
	end
	return count
end

talkaction:groupType("normal")
talkaction:separator(" ")
talkaction:register()
