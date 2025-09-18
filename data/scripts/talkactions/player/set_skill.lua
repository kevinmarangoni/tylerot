-- Comando para definir skills diretamente
-- Uso: /setskill <playername>, <skill>, <level>
-- Skills disponíveis: sword, axe, club, dist, shield, fish, magic, level

local skillMap = {
	club = SKILL_CLUB,
	sword = SKILL_SWORD,
	axe = SKILL_AXE,
	dist = SKILL_DISTANCE,
	shield = SKILL_SHIELD,
	fish = SKILL_FISHING,
}

local function getSkillId(skillName)
	return skillMap[skillName:match("^%a+")] or SKILL_FIST
end

local setSkill = TalkAction("/setskill")

function setSkill.onSay(player, words, param)
	-- Create log
	logCommand(player, words, param)

	if param == "" then
		player:sendCancelMessage("Command param required.")
		return true
	end

	local split = param:split(",")
	if #split < 3 then
		player:sendCancelMessage("Usage: /setskill <playername>, <skill>, <level>")
		return true
	end

	local targetPlayerName = split[1]:trim()
	local targetPlayer = Player(targetPlayerName)

	if not targetPlayer then
		player:sendCancelMessage("Player not found.")
		return true
	end

	local skillParam = split[2]:trim()
	local skillLevel = tonumber(split[3])

	if not skillLevel or skillLevel < 0 then
		player:sendCancelMessage("Invalid skill level. It should be a positive number.")
		return true
	end

	local skillPrefix = skillParam:sub(1, 1)

	if skillPrefix == "l" then
		-- Definir level
		targetPlayer:setLevel(skillLevel)
		targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("%s has set your level to %d.", player:getName(), skillLevel))
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You have successfully set %s's level to %d.", targetPlayer:getName(), skillLevel))
	elseif skillPrefix == "m" then
		-- Definir magic level
		targetPlayer:setMagicLevel(skillLevel)
		targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("%s has set your magic level to %d.", player:getName(), skillLevel))
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You have successfully set %s's magic level to %d.", targetPlayer:getName(), skillLevel))
	else
		-- Definir skill específico
		local skillId = getSkillId(skillParam)
		targetPlayer:setSkillLevel(skillId, skillLevel)
		targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("%s has set your %s skill to level %d.", player:getName(), skillParam, skillLevel))
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You have successfully set %s's %s skill to level %d.", targetPlayer:getName(), skillParam, skillLevel))
	end

	-- Atualizar stats e skills do player
	targetPlayer:sendStats()
	targetPlayer:sendSkills()

	return true
end

setSkill:separator(" ")
setSkill:groupType("normal") -- Corrigido para groupType 1 (normal players)
setSkill:register()
