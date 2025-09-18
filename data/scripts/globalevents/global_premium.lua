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
    if result ~= false then
        local accountsUpdated = 0
        repeat
            local accountId = result:getNumber("id")
            local accountName = result:getString("name")

            -- Aplicar premium
            db.query("UPDATE accounts SET premium_ends_at = " .. os.time() + (PremiumSettings.getNumber("PREMIUM_DAYS") * 24 * 60 * 60) .. " WHERE id = " .. accountId)
            db.query("UPDATE accounts SET type = " .. PremiumSettings.getNumber("PREMIUM_ACCOUNT_TYPE") .. " WHERE id = " .. accountId)

            accountsUpdated = accountsUpdated + 1
            print(">> [Global Premium] Conta " .. accountName .. " atualizada com premium!")
        until not result:next()
        result:free()

        print(">> [Global Premium] " .. accountsUpdated .. " contas atualizadas com premium!")
    end

    print(">> [Global Premium] Aplicação de premium global concluída!")
end

-- Evento de login separado para premium
local globalPremiumLogin = CreatureEvent("globalPremiumLogin")

function globalPremiumLogin.onLogin(player)
    if not PremiumSettings.isEnabled("ENABLE_GLOBAL_PREMIUM") then
        return true
    end

    if not PremiumSettings.isEnabled("APPLY_ON_LOGIN") then
        return true
    end

    if not player then
        return true
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

    return true
end

globalPremiumLogin:register()

-- Registrar o evento global
globalPremium:register()
