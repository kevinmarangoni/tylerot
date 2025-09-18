local talkaction = TalkAction("/liberarmagias")

function talkaction.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		player:sendCancelMessage("Você não tem permissão para usar este comando.")
		return false
	end

	player:sendTextMessage(MESSAGE_INFO_DESCR, "=== 🔮 LIBERANDO TODAS AS MAGIAS PREMIUM ===")

	-- Lista de diretórios de magias
	local spellDirectories = {
		"data/scripts/spells/",
		"data-otservbr-global/scripts/spells/"
	}

	local totalSpells = 0
	local premiumSpells = 0
	local liberatedSpells = 0
	local failedSpells = 0

	player:sendTextMessage(MESSAGE_INFO_DESCR, "🔍 Procurando por magias premium...")

	-- Processa cada diretório de magias
	for _, spellDir in ipairs(spellDirectories) do
		local spells = processSpellDirectory(spellDir, player)
		if spells then
			totalSpells = totalSpells + spells.total
			premiumSpells = premiumSpells + spells.premium
			liberatedSpells = liberatedSpells + spells.liberated
			failedSpells = failedSpells + spells.failed
		end
	end

	-- Resultado final
	player:sendTextMessage(MESSAGE_INFO_DESCR, "")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "=== 📊 RESULTADO FINAL ===")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "📁 Total de magias encontradas: " .. totalSpells)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "🔒 Magias premium encontradas: " .. premiumSpells)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "✅ Magias liberadas: " .. liberatedSpells)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "❌ Falharam: " .. failedSpells)

	if liberatedSpells > 0 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "🎉 " .. liberatedSpells .. " magias premium foram liberadas!")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "💡 Agora todos os jogadores podem usar todas as magias!")
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, "")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "⚠️ Nenhuma magia premium foi encontrada ou liberada.")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "💡 Verifique se os diretórios de magias existem.")
	end

	return true
end

function processSpellDirectory(directory, player)
	local spells = {
		total = 0,
		premium = 0,
		liberated = 0,
		failed = 0
	}

	-- Verifica se o diretório existe
	if not io.open(directory .. "dummy", "r") then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "❌ Diretório não encontrado: " .. directory)
		return nil
	end

	player:sendTextMessage(MESSAGE_INFO_DESCR, "📁 Processando: " .. directory)

	-- Lista de arquivos de magias para processar
	local spellFiles = {
		-- Magias de Ataque
		"attack/ultimate_light_strike.lua",
		"attack/ultimate_ice_strike.lua",
		"attack/ultimate_flame_strike.lua",
		"attack/ultimate_energy_strike.lua",
		"attack/ultimate_terra_strike.lua",
		"attack/ethereal_spear.lua",
		"attack/divine_grenade.lua",
		"attack/divine_caldera.lua",
		"attack/annihilation.lua",
		"attack/hells_core.lua",
		"attack/groundshaker.lua",
		"attack/rage_of_the_skies.lua",

		-- Magias de Suporte
		"support/ultimate_light.lua",
		"support/swift_foot.lua",
		"support/strong_haste.lua",
		"support/protector.lua",
		"support/magic_rope.lua",
		"support/blood_rage.lua",
		"support/avatar_of_storm.lua",
		"support/levitate.lua",
		"support/avatar_of_steel.lua",
		"support/avatar_of_nature.lua",
		"support/avatar_of_light.lua",
		"support/haste.lua",
		"support/divine_empowerment.lua",
		"support/divine_dazzle.lua",
		"support/chivalrous_challenge.lua",
		"support/charge.lua",
		"support/challenge.lua",
		"support/cancel_invisibility.lua",

		-- Magias de Cura
		"healing/salvation.lua",
		"healing/nature's_embrace.lua",
		"healing/mass_healing.lua",
		"healing/intense_wound_cleansing.lua",
		"healing/intense_recovery.lua",
		"healing/heal_friend.lua",
		"healing/fair_wound_cleansing.lua",
		"healing/cure_electrification.lua",
		"healing/cure_curse.lua",
		"healing/cure_burning.lua",
		"healing/cure_bleeding.lua",

		-- Magias de Conjuração
		"conjuring/wild_growth_rune.lua",
		"conjuring/thunderstorm_rune.lua",
		"conjuring/stone_shower_rune.lua",
		"conjuring/soulfire_rune.lua",
		"conjuring/poison_bomb_rune.lua",
		"conjuring/paralyze_rune.lua",
		"conjuring/magic_wall_rune.lua",
		"conjuring/icicle_rune.lua",
		"conjuring/holy_missile_rune.lua",
		"conjuring/fireball_rune.lua",
		"conjuring/energy_bomb_rune.lua",
		"conjuring/enchant_staff.lua",
		"conjuring/enchant_spear.lua",
		"conjuring/disintegrate_rune.lua",
		"conjuring/conjure_bolt.lua",
		"conjuring/conjure_wand_of_darkness.lua",
		"conjuring/conjure_sniper_arrow.lua",
		"conjuring/conjure_royal_star.lua",
		"conjuring/conjure_power_bolt.lua",
		"conjuring/conjure_piercing_bolt.lua",
		"conjuring/animate_dead_rune.lua",

		-- Magias de Party
		"party/train_party.lua",
		"party/protect_party.lua",
		"party/heal_party.lua",
		"party/enchant_party.lua"
	}

	-- Processa cada arquivo de magia
	for _, spellFile in ipairs(spellFiles) do
		local fullPath = directory .. spellFile
		local result = processSpellFile(fullPath, player)

		if result then
			spells.total = spells.total + 1
			if result.isPremium then
				spells.premium = spells.premium + 1
				if result.liberated then
					spells.liberated = spells.liberated + 1
				else
					spells.failed = spells.failed + 1
				end
			end
		end
	end

	return spells
end

function processSpellFile(filePath, player)
	-- Verifica se o arquivo existe
	local file = io.open(filePath, "r")
	if not file then
		return nil
	end

	local content = file:read("*all")
	file:close()

	-- Verifica se é uma magia premium
	if content:find("spell:isPremium%(true%)") then
		-- Tenta liberar a magia
		local newContent = content:gsub("spell:isPremium%(true%)", "spell:isPremium(false)")

		-- Salva o arquivo modificado
		local success = saveSpellFile(filePath, newContent)

		if success then
			player:sendTextMessage(MESSAGE_INFO_DESCR, "✅ " .. filePath:match("([^/]+%.lua)$") .. " - Liberada!")
			return {isPremium = true, liberated = true}
		else
			player:sendTextMessage(MESSAGE_INFO_DESCR, "❌ " .. filePath:match("([^/]+%.lua)$") .. " - Falhou ao salvar!")
			return {isPremium = true, liberated = false}
		end
	elseif content:find("spell:isPremium%(false%)") then
		-- Magia já é gratuita
		return {isPremium = false, liberated = false}
	else
		-- Arquivo não tem configuração de premium
		return {isPremium = false, liberated = false}
	end
end

function saveSpellFile(filePath, content)
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
