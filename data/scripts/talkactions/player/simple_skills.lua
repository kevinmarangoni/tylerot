-- Comandos simplificados para skills
-- Uso: /level 100, /ml 120, /sword 130, etc.

print(">> [Simple Skills] Carregando comandos de skills simplificados...")

-- Mapeamento das skills (baseado no set_skill.lua)
local skillMap = {
    club = SKILL_CLUB,
    sword = SKILL_SWORD,
    axe = SKILL_AXE,
    distance = SKILL_DISTANCE,
    shielding = SKILL_SHIELD,
    fishing = SKILL_FISHING,
    fist = SKILL_FIST,
}

local function handleSkillCommand(player, skillType, level)
    local skillId = nil
    local skillName = ""

    -- Mapeamento dos comandos para as skills
    if skillType == "level" then
        -- Para level, calcular experiência necessária (baseado no addskill.lua)
        local targetNewExp = Game.getExperienceForLevel(level)
        local currentExp = player:getExperience()
        local experienceToAdd = targetNewExp - currentExp

        -- Se a diferença for negativa (level menor), usar setExperience
        if experienceToAdd < 0 then
            player:setExperience(targetNewExp)
        else
            player:addExperience(experienceToAdd, false)
        end

        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Level definido para " .. level)
        player:sendStats()
        return true
    elseif skillType == "ml" then
        skillId = SKILL_MAGLEVEL
        skillName = "Magic Level"
        if level > 150 then
            player:sendCancelMessage("Magic Level máximo é 150")
            return true
        end
    else
        -- Para skills normais, usar o mapeamento
        skillId = skillMap[skillType]
        skillName = skillType:gsub("^%l", string.upper) -- Primeira letra maiúscula

        if not skillId then
            player:sendCancelMessage("Skill inválida: " .. skillType)
            return true
        end

        if level > 150 then
            player:sendCancelMessage("Skill máxima é 150")
            return true
        end
    end

    -- Aplicar a skill
    if skillId == SKILL_MAGLEVEL then
        player:setMagicLevel(level)
    else
        player:setSkillLevel(skillId, level)
    end

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, skillName .. " definida para " .. level)
    player:sendSkills()
    return true
end

-- Comando /level
local levelCommand = TalkAction("/level")
function levelCommand.onSay(player, words, param)
    if not param or param == "" then
        player:sendCancelMessage("Uso: /level [nivel]")
        return true
    end

    local level = tonumber(param)
    if not level or level < 1 then
        player:sendCancelMessage("Nível deve ser maior que 0")
        return true
    end

    return handleSkillCommand(player, "level", level)
end

-- Comando /ml
local mlCommand = TalkAction("/ml")
function mlCommand.onSay(player, words, param)
    if not param or param == "" then
        player:sendCancelMessage("Uso: /ml [nivel]")
        return true
    end

    local level = tonumber(param)
    if not level or level < 1 then
        player:sendCancelMessage("Nível deve ser maior que 0")
        return true
    end

    return handleSkillCommand(player, "ml", level)
end

-- Comando /sword
local swordCommand = TalkAction("/sword")
function swordCommand.onSay(player, words, param)
    if not param or param == "" then
        player:sendCancelMessage("Uso: /sword [nivel]")
        return true
    end

    local level = tonumber(param)
    if not level or level < 1 then
        player:sendCancelMessage("Nível deve ser maior que 0")
        return true
    end

    return handleSkillCommand(player, "sword", level)
end

-- Comando /club
local clubCommand = TalkAction("/club")
function clubCommand.onSay(player, words, param)
    if not param or param == "" then
        player:sendCancelMessage("Uso: /club [nivel]")
        return true
    end

    local level = tonumber(param)
    if not level or level < 1 then
        player:sendCancelMessage("Nível deve ser maior que 0")
        return true
    end

    return handleSkillCommand(player, "club", level)
end

-- Comando /axe
local axeCommand = TalkAction("/axe")
function axeCommand.onSay(player, words, param)
    if not param or param == "" then
        player:sendCancelMessage("Uso: /axe [nivel]")
        return true
    end

    local level = tonumber(param)
    if not level or level < 1 then
        player:sendCancelMessage("Nível deve ser maior que 0")
        return true
    end

    return handleSkillCommand(player, "axe", level)
end

-- Comando /fist
local fistCommand = TalkAction("/fist")
function fistCommand.onSay(player, words, param)
    if not param or param == "" then
        player:sendCancelMessage("Uso: /fist [nivel]")
        return true
    end

    local level = tonumber(param)
    if not level or level < 1 then
        player:sendCancelMessage("Nível deve ser maior que 0")
        return true
    end

    return handleSkillCommand(player, "fist", level)
end

-- Comando /distance
local distanceCommand = TalkAction("/distance")
function distanceCommand.onSay(player, words, param)
    if not param or param == "" then
        player:sendCancelMessage("Uso: /distance [nivel]")
        return true
    end

    local level = tonumber(param)
    if not level or level < 1 then
        player:sendCancelMessage("Nível deve ser maior que 0")
        return true
    end

    return handleSkillCommand(player, "distance", level)
end

-- Comando /fishing
local fishingCommand = TalkAction("/fishing")
function fishingCommand.onSay(player, words, param)
    if not param or param == "" then
        player:sendCancelMessage("Uso: /fishing [nivel]")
        return true
    end

    local level = tonumber(param)
    if not level or level < 1 then
        player:sendCancelMessage("Nível deve ser maior que 0")
        return true
    end

    return handleSkillCommand(player, "fishing", level)
end

-- Comando /shielding
local shieldingCommand = TalkAction("/shielding")
function shieldingCommand.onSay(player, words, param)
    if not param or param == "" then
        player:sendCancelMessage("Uso: /shielding [nivel]")
        return true
    end

    local level = tonumber(param)
    if not level or level < 1 then
        player:sendCancelMessage("Nível deve ser maior que 0")
        return true
    end

    return handleSkillCommand(player, "shielding", level)
end

-- Registrar todos os comandos
levelCommand:separator(" ")
levelCommand:groupType("normal")
levelCommand:register()

mlCommand:separator(" ")
mlCommand:groupType("normal")
mlCommand:register()

swordCommand:separator(" ")
swordCommand:groupType("normal")
swordCommand:register()

clubCommand:separator(" ")
clubCommand:groupType("normal")
clubCommand:register()

axeCommand:separator(" ")
axeCommand:groupType("normal")
axeCommand:register()

fistCommand:separator(" ")
fistCommand:groupType("normal")
fistCommand:register()

distanceCommand:separator(" ")
distanceCommand:groupType("normal")
distanceCommand:register()

fishingCommand:separator(" ")
fishingCommand:groupType("normal")
fishingCommand:register()

shieldingCommand:separator(" ")
shieldingCommand:groupType("normal")
shieldingCommand:register()

print(">> [Simple Skills] Comandos de skills simplificados carregados!")
