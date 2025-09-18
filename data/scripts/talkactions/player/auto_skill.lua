-- Comando para adicionar skills a si mesmo
-- Uso: /autoskill <skill>, [amount]
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

local autoSkill = TalkAction("/autoskill")

function autoSkill.onSay(player, words, param)
	-- Create log
	logCommand(player, words, param)

	if param == "" then
		player:sendCancelMessage("Command param required.")
		return true
	end

	local split = param:split(",")
	if #split < 1 then
		player:sendCancelMessage("Usage: /autoskill <skill>, [amount]")
		return true
	end

	local skillParam = split[1]:trim()
	local skillIncreaseAmount = tonumber(split[2]) or 1
	local skillPrefix = skillParam:sub(1, 1)

	if skillPrefix == "l" then
		-- Adicionar level
		local targetNewLevel = player:getLevel() + skillIncreaseAmount
		local targetNewExp = Game.getExperienceForLevel(targetNewLevel)
		local experienceToAdd = targetNewExp - player:getExperience()
		local levelText = (skillIncreaseAmount > 1) and "levels" or "level"

		player:addExperience(experienceToAdd, false)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You have successfully added %d %s to yourself.", skillIncreaseAmount, levelText))
	elseif skillPrefix == "m" then
		-- Adicionar magic level
		for _ = 1, skillIncreaseAmount do
			local requiredManaSpent = player:getVocation():getRequiredManaSpent(player:getBaseMagicLevel() + 1)
			player:addManaSpent(requiredManaSpent - player:getManaSpent(), true)
		end

		local magicText = (skillIncreaseAmount > 1) and "magic levels" or "magic level"
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You have successfully added %d %s to yourself.", skillIncreaseAmount, magicText))
	else
		-- Adicionar skill específico
		local skillId = getSkillId(skillParam)
		for _ = 1, skillIncreaseAmount do
			local requiredSkillTries = player:getVocation():getRequiredSkillTries(skillId, player:getSkillLevel(skillId) + 1)
			player:addSkillTries(skillId, requiredSkillTries - player:getSkillTries(skillId), true)
		end

		local skillText = (skillIncreaseAmount > 1) and "skill levels" or "skill level"
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You have successfully added %d %s %s to yourself.", skillIncreaseAmount, skillParam, skillText))
	end

	return true
end

autoSkill:separator(" ")
autoSkill:groupType("normal") -- Corrigido para groupType 1 (normal players)
autoSkill:register()
