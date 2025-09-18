local spawnThais = CreatureEvent("SpawnThais")

function spawnThais.onLogin(player)
    -- Verificar se é um personagem novo (primeiro login)
    if player:getLastLoginSaved() == 0 then
        -- Posição do Templo de Thais
        local thaisTemple = Position(32369, 32237, 7)

        -- Definir Thais como cidade natal (ID 8 = THAIS)
        local thaisTown = Town(8)
        if thaisTown then
            player:setTown(thaisTown)

            -- Teleportar para o templo de Thais
            player:teleportTo(thaisTemple)

            -- Mensagem de boas-vindas personalizada
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "🏰 Bem-vindo a Thais! Sua jornada PVP começa aqui!")

            -- Efeito visual
            thaisTemple:sendMagicEffect(CONST_ME_TELEPORT)

            -- Log no console
            print(">>> Player " .. player:getName() .. " iniciou em Thais (Templo)")
        end
    end

    return true
end

spawnThais:register()
