local montariasGratis = CreatureEvent("MontariasGratis")

function montariasGratis.onLogin(player)
    -- Verificar se já recebeu as montarias (usando storage)
    local storageKey = 50001 -- Storage para controlar se já recebeu

    if player:getStorageValue(storageKey) ~= 1 then
        -- Dar todas as montarias
        local mountsGiven = 0

        for mountId = 1, 231 do
            if player:addMount(mountId) then
                mountsGiven = mountsGiven + 1
            end
        end

        -- Marcar como já recebido
        player:setStorageValue(storageKey, 1)

        -- Notificar o player
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "🎁 Bem-vindo! Você recebeu " .. mountsGiven .. " montarias gratuitas!")
        player:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)

        -- Log no console
        print(">>> Player " .. player:getName() .. " recebeu " .. mountsGiven .. " montarias automaticamente!")
    end

    return true
end

montariasGratis:register()
