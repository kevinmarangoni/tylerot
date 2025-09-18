-- Global Configuration Script
-- Aplica configurações globais para todos os jogadores

local globalConfig = GlobalEvent("globalConfig")

-- Carregar configurações globais
dofile('data/scripts/config/global_settings.lua')

function globalConfig.onStartup()
    if not GlobalSettings.isEnabled("GENERAL.ENABLE_AUTO_APPLY") then
        print(">> [Global Config] Aplicação automática desabilitada!")
        return
    end

    print(">> [Global Config] Aplicando configurações globais...")

    -- Aplicar para todos os jogadores online
    for _, player in pairs(Game.getPlayers()) do
        applyGlobalConfig(player)
    end

    print(">> [Global Config] Configurações aplicadas para jogadores online!")
end

function globalConfig.onLogin(player)
    if not GlobalSettings.isEnabled("GENERAL.ENABLE_AUTO_APPLY") then
        return
    end

    -- Aplicar configurações quando jogador fizer login
    if player then
        applyGlobalConfig(player)
    end
end

function applyGlobalConfig(player)
    if not player then
        return
    end

    -- Aplicar dinheiro
    if GlobalSettings.isEnabled("MONEY.APPLY_ON_LOGIN") then
        local moneyAmount = GlobalSettings.getNumber("MONEY.DEFAULT_AMOUNT")
        if player:getBankBalance() < moneyAmount then
            player:setBankBalance(moneyAmount)
            if GlobalSettings.isEnabled("GENERAL.SHOW_MESSAGES") then
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Seu dinheiro foi configurado para " .. moneyAmount .. " gold coins!")
            end
        end
    end

    -- Aplicar blessings
    if GlobalSettings.isEnabled("BLESSINGS.APPLY_ON_LOGIN") then
        local blessingsAmount = GlobalSettings.getNumber("BLESSINGS.DEFAULT_AMOUNT")
        local blessingsList = GlobalSettings.get("BLESSINGS.BLESSINGS_LIST") or {1, 2, 3, 4, 5, 6, 7, 8}

        for _, blessingId in pairs(blessingsList) do
            player:addBlessing(blessingId, blessingsAmount)
        end

        if GlobalSettings.isEnabled("GENERAL.SHOW_MESSAGES") then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Todas as suas blessings foram configuradas para " .. blessingsAmount .. "!")
        end
    end

    -- Aplicar Tibia Coins (apenas para admins por segurança)
    if GlobalSettings.isEnabled("TIBIA_COINS.APPLY_ON_LOGIN") and GlobalSettings.isEnabled("TIBIA_COINS.APPLY_ONLY_TO_ADMINS") then
        if player:getAccountType() >= ACCOUNT_TYPE_GOD then
            local coinsAmount = GlobalSettings.getNumber("TIBIA_COINS.DEFAULT_AMOUNT")
            player:addTibiaCoins(coinsAmount)
            if GlobalSettings.isEnabled("GENERAL.SHOW_MESSAGES") then
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você recebeu " .. coinsAmount .. " Tibia Coins!")
            end
        end
    end
end

-- Comando para aplicar configurações manualmente
local globalConfigCommand = TalkAction("/globalconfig")

function globalConfigCommand.onSay(player, words, param)
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

    applyGlobalConfig(target)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Configurações globais aplicadas para " .. target:getName() .. "!")

    return true
end

globalConfigCommand:groupType("god")
globalConfigCommand:register()

-- Registrar o evento global
globalConfig:register()
