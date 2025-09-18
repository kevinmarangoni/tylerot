local liberarMontarias = TalkAction("/liberarmontarias")

function liberarMontarias.onSay(player, words, param)
    -- Verificar permissões de administrador
    if not player:getGroup():hasFlag(PlayerFlag_CanAlwaysLogin) then
        player:sendCancelMessage("Você não tem permissão para usar este comando!")
        return true
    end

    local targetName = param:trim()
    local target = nil

    if targetName == "" then
        target = player
    else
        target = Player(targetName)
        if not target then
            player:sendCancelMessage("Jogador '" .. targetName .. "' não encontrado!")
            return true
        end
    end

    local mountsUnlocked = 0

    -- Liberar todas as montarias (IDs 1 a 231 baseado no mounts.xml)
    for mountId = 1, 231 do
        if target:addMount(mountId) then
            mountsUnlocked = mountsUnlocked + 1
        end
    end

    -- Mensagens de confirmação
    target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "🐎 Todas as " .. mountsUnlocked .. " montarias foram liberadas!")
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "✅ Liberou " .. mountsUnlocked .. " montarias para " .. target:getName() .. "!")

    -- Efeito visual
    target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)

    return true
end

liberarMontarias:separator(" ")
liberarMontarias:groupType("god")
liberarMontarias:register()
