-- Sistema de Premium Global
-- Aplica premium status para todas as contas automaticamente

local globalPremium = GlobalEvent("globalPremium")

-- Carregar configurações de premium
dofile('data/scripts/config/premium_settings.lua')

function globalPremium.onStartup()
    if not PremiumSettings.isEnabled("ENABLE_GLOBAL_PREMIUM") then
        return
    end

    if not PremiumSettings.isEnabled("APPLY_ON_STARTUP") then
        return
    end

    print(">> [Global Premium] Iniciando aplicação de premium global...")

    local result = db.storeQuery("SELECT id, name FROM accounts")
    if result then
        local accountsUpdated = 0
        repeat
            local accountId = result.getDataInt(result, "id")
            local accountName = result.getDataString(result, "name")

            -- Aplicar premium
            db.query("UPDATE accounts SET premium_ends_at = " .. os.time() + (PremiumSettings.getNumber("PREMIUM_DAYS") * 24 * 60 * 60) .. " WHERE id = " .. accountId)
            db.query("UPDATE accounts SET type = " .. PremiumSettings.getNumber("PREMIUM_ACCOUNT_TYPE") .. " WHERE id = " .. accountId)

            accountsUpdated = accountsUpdated + 1
            print(">> [Global Premium] Conta " .. accountName .. " atualizada com premium!")
        until not result.next(result)
        result.free(result)

        print(">> [Global Premium] " .. accountsUpdated .. " contas atualizadas com premium!")
    end

    print(">> [Global Premium] Aplicação de premium global concluída!")
end

function globalPremium.onLogin(player)
    if not PremiumSettings.isEnabled("ENABLE_GLOBAL_PREMIUM") then
        return
    end

    if not PremiumSettings.isEnabled("APPLY_ON_LOGIN") then
        return
    end

    if not player then
        return
    end

    local accountId = player:getAccountId()
    local premiumEndsAt = os.time() + (PremiumSettings.getNumber("PREMIUM_DAYS") * 24 * 60 * 60)

    -- Aplicar premium na conta
    db.query("UPDATE accounts SET premium_ends_at = " .. premiumEndsAt .. " WHERE id = " .. accountId)
    db.query("UPDATE accounts SET type = " .. PremiumSettings.getNumber("PREMIUM_ACCOUNT_TYPE") .. " WHERE id = " .. accountId)

    -- Mensagem para o jogador
    if PremiumSettings.isEnabled("SHOW_MESSAGES") then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Sua conta foi configurada com premium por " .. PremiumSettings.getNumber("PREMIUM_DAYS") .. " dias!")
    end

    -- Log da ação
    if PremiumSettings.isEnabled("LOG_ACTIONS") then
        print(">> [Global Premium] Jogador " .. player:getName() .. " recebeu premium na conta " .. accountId)
    end
end

-- Registrar o evento global
globalPremium:register()
