local alterarSpawn = TalkAction("/alterarspawn")

function alterarSpawn.onSay(player, words, param)
    -- Verificar permissões de administrador
    if not player:getGroup():hasFlag(PlayerFlag_CanAlwaysLogin) then
        player:sendCancelMessage("Você não tem permissão para usar este comando!")
        return true
    end

    -- Alterar configuração padrão do spawn inicial para Thais
    -- Atualizar todos os personagens existentes que ainda estão na ilha inicial

    -- Query para atualizar players que estão na Island of Destiny (town_id = 4) ou Dawnport (town_id = 1 ou 2) para Thais (town_id = 8)
    local queries = {
        "UPDATE `players` SET `town_id` = 8 WHERE `town_id` IN (1, 2, 4);", -- Muda de tutorial/dawnport/island para Thais
        "UPDATE `players` SET `posx` = 32369, `posy` = 32237, `posz` = 7 WHERE `town_id` = 8 AND `level` <= 10;", -- Define posição do templo de Thais para chars baixo level
    }

    local playersUpdated = 0

    for _, query in ipairs(queries) do
        local result = db.query(query)
        if result then
            if query:find("UPDATE `players` SET `town_id`") then
                playersUpdated = db.asyncStoreQuery("SELECT ROW_COUNT() as count;"):getNumber("count")
            end
        else
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "❌ Erro ao executar query: " .. query)
            return true
        end
    end

    -- Mensagem de confirmação
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "✅ Spawn inicial alterado para Thais!")
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "📊 " .. playersUpdated .. " personagens foram movidos para Thais")
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "🏰 Novos personagens nascerão no Templo de Thais")

    -- Efeito visual
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)

    -- Log no console
    print(">>> Spawn inicial alterado para Thais por " .. player:getName())
    print(">>> " .. playersUpdated .. " personagens foram atualizados")

    return true
end

alterarSpawn:separator(" ")
alterarSpawn:groupType("god")
alterarSpawn:register()
