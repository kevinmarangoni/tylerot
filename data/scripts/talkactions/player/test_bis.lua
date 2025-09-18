-- Comando de teste simples
local testCommand = TalkAction("/testbis")

function testCommand.onSay(player, words, param)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Comando de teste funcionando!")
    return true
end

testCommand:separator(" ")
testCommand:groupType("normal")
testCommand:register()

print(">> [Test] Comando /testbis registrado!")
