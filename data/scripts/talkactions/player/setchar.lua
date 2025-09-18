-- Comando para teleportar para Thais e definir vocação
-- Uso: /setchar [nome_jogador] [vocacao]
-- Vocacoes: 1=Sorcerer, 2=Druid, 3=Paladin, 4=Knight, 5=MS, 6=ED, 7=RP, 8=EK
-- Abreviacoes: MS, ED, RP, EK, SOR, DRU, PAL, KNI

local setChar = TalkAction("/setchar")

-- Função para converter abreviações de vocação para IDs
function getVocationId(vocationName)
    local vocations = {
        -- Abreviações
        ["MS"] = 5,   -- Master Sorcerer
        ["ED"] = 6,   -- Elder Druid
        ["RP"] = 7,   -- Royal Paladin
        ["EK"] = 8,   -- Elite Knight
        ["SOR"] = 1,  -- Sorcerer
        ["DRU"] = 2,  -- Druid
        ["PAL"] = 3,  -- Paladin
        ["KNI"] = 4,  -- Knight
        -- Nomes completos
        ["SORCERER"] = 1,
        ["DRUID"] = 2,
        ["PALADIN"] = 3,
        ["KNIGHT"] = 4,
        ["MASTER SORCERER"] = 5,
        ["ELDER DRUID"] = 6,
        ["ROYAL PALADIN"] = 7,
        ["ELITE KNIGHT"] = 8,
        -- Números
        ["1"] = 1,
        ["2"] = 2,
        ["3"] = 3,
        ["4"] = 4,
        ["5"] = 5,
        ["6"] = 6,
        ["7"] = 7,
        ["8"] = 8
    }

    return vocations[vocationName]
end

function setChar.onSay(player, words, param)
    local target = nil
    local desiredVocation = nil

    if param == "" then
        -- Se não foi fornecido nome, aplicar para o próprio jogador
        target = player
    else
        -- Separar parâmetros: nome e vocação
        local params = param:split(",")
        local targetName = params[1]:trim()

        if targetName == "" then
            target = player
        else
            target = Player(targetName)
            if not target then
                player:sendCancelMessage("Jogador '" .. targetName .. "' não encontrado!")
                return true
            end
        end

        -- Verificar se foi especificada uma vocação
        if params[2] then
            local vocationParam = params[2]:trim():upper()
            desiredVocation = getVocationId(vocationParam)
            if not desiredVocation then
                player:sendCancelMessage("Vocação inválida! Use: MS, ED, RP, EK, SOR, DRU, PAL, KNI ou números 1-8")
                return true
            end
        end
    end

    -- Teleportar para Thais (coordenadas do templo)
    local thaisTemple = Position(32360, 32241, 7)
    target:teleportTo(thaisTemple)

        -- Definir vocação
    local currentVocation = target:getVocation():getId()
    local finalVocation = desiredVocation or currentVocation

    -- Se não foi especificada vocação, usar a atual
    if not desiredVocation then
        finalVocation = currentVocation
    end

    -- Aplicar vocação
    if finalVocation ~= currentVocation then
        target:setVocation(Vocation(finalVocation))
        target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Vocação alterada para " .. Vocation(finalVocation):getName() .. "!")
    end

    -- Mensagens de confirmação
    if target == player then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você foi teleportado para Thais e sua vocação foi configurada!")
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Jogador " .. target:getName() .. " foi teleportado para Thais e vocação configurada!")
        target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você foi teleportado para Thais por " .. player:getName() .. " e sua vocação foi configurada!")
    end

    -- Log do comando
    logCommand(player, words, param)

    return true
end

setChar:separator(" ")
setChar:groupType("normal")
setChar:register()

print(">> [SetChar] Comando /setchar registrado!")
