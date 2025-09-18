# 🌟 Sistema de Premium Global - Canary Server

## **Descrição**
Sistema automático que aplica premium status para todas as contas do servidor, incluindo contas existentes e novas contas que fazem login.

## **Funcionalidades**

### **✅ Aplicação Automática**
- **No Startup**: Aplica premium em todas as contas existentes ao iniciar o servidor
- **No Login**: Aplica premium automaticamente quando um jogador faz login
- **Configurável**: Pode ser ativado/desativado facilmente

### **🎯 Configurações Personalizáveis**
- **Dias de Premium**: 999.999 dias (aproximadamente 2.739 anos)
- **Tipo de Conta**: Pode ser configurado como Premium (2) ou GOD (3)
- **Mensagens**: Pode mostrar ou ocultar mensagens para jogadores
- **Logs**: Registra todas as ações no console do servidor

## **📁 Arquivos Criados**

1. **`data/scripts/config/premium_settings.lua`** - Configurações principais
2. **`data/scripts/globalevents/global_premium.lua`** - Sistema automático
3. **`data/scripts/talkactions/god/apply_premium.lua`** - Comando manual
4. **`data/scripts/talkactions/god/mass_premium.lua`** - Comando em massa

## **🚀 Como Usar**

### **Aplicação Automática**
O sistema funciona automaticamente após a instalação:
- **Startup**: Aplica premium em todas as contas existentes
- **Login**: Aplica premium em novas contas automaticamente

### **Comandos Manuais**
- **`/applypremium [nome_jogador]`** - Aplica premium para um jogador específico
- **`/masspremium`** - Aplica premium em todas as contas de uma vez

## **⚙️ Configurações**

### **Editar `premium_settings.lua`:**
```lua
PremiumSettings = {
    ENABLE_GLOBAL_PREMIUM = true,    -- Ativar/desativar sistema
    APPLY_ON_LOGIN = true,           -- Aplicar no login
    APPLY_ON_STARTUP = true,         -- Aplicar no startup
    PREMIUM_DAYS = 999999,           -- Dias de premium
    PREMIUM_ACCOUNT_TYPE = 3,        -- Tipo de conta (1=Normal, 2=Premium, 3=GOD)
    SHOW_MESSAGES = true,            -- Mostrar mensagens
    LOG_ACTIONS = true               -- Registrar logs
}
```

## **🔧 Instalação**

1. **Copiar arquivos** para as pastas corretas
2. **Reiniciar servidor** para ativar o sistema
3. **Verificar logs** no console para confirmar funcionamento

## **📊 Benefícios**

- **✅ Todas as contas são premium automaticamente**
- **✅ Sem necessidade de configuração manual**
- **✅ Funciona com contas existentes e novas**
- **✅ Configurável e flexível**
- **✅ Comandos manuais para controle adicional**

## **⚠️ Importante**

- **Reiniciar servidor** após instalação
- **Verificar permissões** de banco de dados
- **Backup** antes de aplicar em servidores de produção
- **Testar** em ambiente de desenvolvimento primeiro

## **🎮 Resultado Final**

Após a instalação, **TODAS as contas** terão:
- ✅ Status Premium ativo
- ✅ 999.999 dias de premium
- ✅ Acesso a todas as funcionalidades premium
- ✅ Aplicação automática para novas contas

---

**🌟 Sistema Premium Global ativado com sucesso!**
