local blessingsManager = TalkAction("/blessings")

function blessingsManager.onSay(player, words, param)
    if not player:getGroup():hasFlag(PlayerFlag_CanAlwaysLogin) then
        player:sendCancelMessage("Você não tem permissão para usar este comando!")
        return true
    end

    local params = param:split(",")
    local targetName = params[1]:trim()
    local amount = tonumber(params[2]) or 120
    local blessingId = tonumber(params[3]) or 0 -- 0 = todas as blessings

    if not targetName or targetName == "" then
        player:sendCancelMessage("Uso: /blessings <nome_jogador>, [quantidade], [blessing_id]\n\n" ..
            "Exemplos:\n" ..
            "/blessings NomeJogador, 120, 0     - Todas as blessings para 120\n" ..
            "/blessings NomeJogador, 50, 1      - Blessing 1 para 50\n" ..
            "/blessings NomeJogador, 200        - Todas para 200\n" ..
            "/blessings NomeJogador             - Todas para 120 (padrão)")
        return true
    end

    local target = Player(targetName)
    if not target then
        player:sendCancelMessage("Jogador '" .. targetName .. "' não encontrado!")
        return true
    end

    -- Validar quantidade
    if amount < 0 or amount > 999999 then
        player:sendCancelMessage("Quantidade deve ser entre 0 e 999999!")
        return true
    end

    -- Aplicar blessings
    if blessingId == 0 then
        -- Aplicar para todas as blessings
        local blessingsList = {1, 2, 3, 4, 5, 6, 7, 8}
        for _, bid in pairs(blessingsList) do
            target:addBlessing(bid, amount)
        end

        target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Todas as suas blessings foram configuradas para " .. amount .. "!")
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Todas as blessings de " .. target:getName() .. " configuradas para " .. amount .. "!")

    else
        -- Aplicar para blessing específica
        if blessingId < 1 or blessingId > 8 then
            player:sendCancelMessage("ID da blessing deve ser entre 1 e 8!")
            return true
        end

        target:addBlessing(blessingId, amount)
        target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Blessing " .. blessingId .. " configurada para " .. amount .. "!")
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Blessing " .. blessingId .. " de " .. target:getName() .. " configurada para " .. amount .. "!")
    end

    -- Log do comando
    logCommand(player, words, param)

    return true
end

blessingsManager:separator(" ")
blessingsManager:groupType("god")
blessingsManager:register()
