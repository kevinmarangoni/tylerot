local massPremiumCommand = TalkAction("/masspremium")

function massPremiumCommand.onSay(player, words, param)
    if not player:getGroup():hasFlag(PlayerFlag_CanAlwaysLogin) then
        player:sendCancelMessage("Você não tem permissão para usar este comando!")
        return true
    end

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Iniciando aplicação de premium em massa...")

    -- Carregar configurações
    dofile('data/scripts/config/premium_settings.lua')

    -- Aplicar premium em massa
    addEvent(function()
        local result = db.storeQuery("SELECT id, name FROM accounts")
        if result then
            local accountsUpdated = 0
            local premiumDays = PremiumSettings.getNumber("PREMIUM_DAYS")
            local accountType = PremiumSettings.getNumber("PREMIUM_ACCOUNT_TYPE")
            local premiumEndsAt = os.time() + (premiumDays * 24 * 60 * 60)

            repeat
                local accountId = result.getDataInt(result, "id")
                local accountName = result.getDataString(result, "name")

                -- Aplicar premium
                db.query("UPDATE accounts SET premium_ends_at = " .. premiumEndsAt .. " WHERE id = " .. accountId)
                db.query("UPDATE accounts SET type = " .. accountType .. " WHERE id = " .. accountId)

                accountsUpdated = accountsUpdated + 1
                print(">> [Mass Premium] Conta " .. accountName .. " atualizada com premium!")
            until not result.next(result)
            result.free(result)

            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Premium aplicado em " .. accountsUpdated .. " contas!")
            print(">> [Mass Premium] " .. accountsUpdated .. " contas atualizadas com premium!")
        else
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Erro ao acessar o banco de dados!")
        end
    end, 1000)

    return true
end

massPremiumCommand:groupType("god")
massPremiumCommand:register()
