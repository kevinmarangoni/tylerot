-- Mass Database Update Script
-- Atualiza todos os jogadores e contas no banco de dados

local massUpdate = GlobalEvent("massUpdate")

function massUpdate.onStartup()
    print(">> [Mass Update] Iniciando atualização em massa do banco de dados...")

    -- Atualizar todas as contas com tibia coins
    local result = db.storeQuery("SELECT id, name FROM accounts")
    if result ~= false then
        repeat
            local accountId = result:getNumber("id")
            local accountName = result:getString("name")

            -- Atualizar tibia coins para 9999999999
            db.query("UPDATE accounts SET coins = 9999999999 WHERE id = " .. accountId)
            print(">> [Mass Update] Conta " .. accountName .. " atualizada com 9999999999 tibia coins")

        until not result:next()
        result:free()
    end

    -- Atualizar todos os jogadores com dinheiro e blessings
    local playerResult = db.storeQuery("SELECT id, name FROM players")
    if playerResult ~= false then
        repeat
            local playerId = playerResult:getNumber("id")
            local playerName = playerResult:getString("name")

            -- Atualizar dinheiro para 9999999999
            db.query("UPDATE players SET balance = 9999999999 WHERE id = " .. playerId)

            -- Atualizar todas as blessings para 120
            db.query("UPDATE players SET blessings1 = 120, blessings2 = 120, blessings3 = 120, blessings4 = 120, blessings5 = 120, blessings6 = 120, blessings7 = 120, blessings8 = 120 WHERE id = " .. playerId)

            print(">> [Mass Update] Jogador " .. playerName .. " atualizado com dinheiro e blessings")

        until not playerResult:next()
        playerResult:free()
    end

    print(">> [Mass Update] Atualização em massa concluída!")
end

-- Comando para executar atualização manual
local massUpdateCommand = TalkAction("/massupdate")

function massUpdateCommand.onSay(player, words, param)
    if not player:getGroup():hasFlag(PlayerFlag_CanAlwaysLogin) then
        player:sendCancelMessage("Você não tem permissão para usar este comando!")
        return true
    end

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Iniciando atualização em massa do banco de dados...")

    -- Executar atualização
    addEvent(function()
        massUpdate.onStartup()
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Atualização em massa concluída!")
    end, 1000)

    return true
end

massUpdateCommand:groupType("god")
massUpdateCommand:register()

-- Registrar o evento global
massUpdate:register()
