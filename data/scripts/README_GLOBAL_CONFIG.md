# 🌟 CONFIGURAÇÕES GLOBAIS DO SERVIDOR CANARY

## 📋 Visão Geral
Este sistema permite aplicar configurações globais automaticamente para todos os jogadores do servidor, incluindo:
- **Dinheiro**: 9.999.999.999 gold coins
- **Blessings**: 120 de cada blessing
- **Tibia Coins**: 9.999.999.999 coins

## 🚀 Como Usar

### **1. Configuração Automática**
O sistema aplica as configurações automaticamente:
- **No startup do servidor** para jogadores online
- **No login** de cada jogador
- **Via comandos** para aplicação manual

### **2. Comandos Disponíveis**

#### **`/globalconfig [nome_jogador]`**
- Aplica todas as configurações globais
- Se não especificar nome, aplica no próprio jogador
- **Permissão**: GOD

#### **`/addcoins <nome_jogador>, [quantidade]`**
- Adiciona Tibia Coins ao jogador
- Quantidade padrão: 9.999.999.999
- **Permissão**: GOD

#### **`/massupdate`**
- Atualiza TODOS os jogadores e contas no banco de dados
- **Permissão**: GOD
- **⚠️ ATENÇÃO**: Este comando afeta TODOS os dados!

### **3. Personalização das Configurações**

Edite o arquivo `data/scripts/config/global_settings.lua`:

```lua
GlobalSettings = {
    MONEY = {
        DEFAULT_AMOUNT = 9999999999,        -- Quantidade de dinheiro
        APPLY_ON_LOGIN = true,              -- Aplicar no login?
        APPLY_ON_STARTUP = true             -- Aplicar no startup?
    },

    BLESSINGS = {
        DEFAULT_AMOUNT = 120,               -- Quantidade de cada blessing
        APPLY_ON_LOGIN = true,              -- Aplicar no login?
        APPLY_ON_STARTUP = true,            -- Aplicar no startup?
        BLESSINGS_LIST = {1, 2, 3, 4, 5, 6, 7, 8} -- IDs das blessings
    },

    TIBIA_COINS = {
        DEFAULT_AMOUNT = 9999999999,        -- Quantidade de tibia coins
        APPLY_ON_LOGIN = false,             -- Aplicar no login? (por segurança)
        APPLY_ON_STARTUP = false,           -- Aplicar no startup?
        APPLY_ONLY_TO_ADMINS = true         -- Apenas admins recebem automaticamente
    },

    GENERAL = {
        ENABLE_AUTO_APPLY = true,           -- Habilitar aplicação automática?
        SHOW_MESSAGES = true,               -- Mostrar mensagens?
        LOG_ACTIONS = true,                 -- Logar ações?
        DELAY_ON_LOGIN = 1000               -- Delay em ms para aplicar no login
    }
}
```

## 🔧 Instalação

### **1. Arquivos Necessários**
Certifique-se de que estes arquivos estão na pasta correta:
```
data/scripts/
├── config/
│   └── global_settings.lua
├── globalevents/
│   ├── global_config.lua
│   └── mass_update_database.lua
└── talkactions/god/
    └── add_coins.lua
```

### **2. Reiniciar o Servidor**
Após adicionar os arquivos, reinicie o servidor para carregar as configurações.

## ⚠️ IMPORTANTE

### **Segurança**
- **Tibia Coins** não são aplicados automaticamente por padrão
- Use o comando `/addcoins` para distribuir manualmente
- Apenas **GODs** podem usar os comandos

### **Performance**
- O sistema verifica valores antes de aplicar
- Não aplica se o jogador já tiver os valores corretos
- Delay configurável para evitar problemas no login

### **Banco de Dados**
- O comando `/massupdate` atualiza TODOS os dados
- **Faça backup** antes de usar
- Use apenas quando necessário

## 🎯 Casos de Uso

### **Servidor de Teste**
- Configure `APPLY_ON_LOGIN = true` para todos
- Aplicação automática em cada login

### **Servidor de Produção**
- Configure `APPLY_ON_LOGIN = false` para tibia coins
- Use comandos manuais para distribuir

### **Eventos Especiais**
- Modifique temporariamente os valores
- Reverta após o evento

## 🆘 Suporte

Se encontrar problemas:
1. Verifique os logs do servidor
2. Confirme permissões dos comandos
3. Verifique se os arquivos estão na pasta correta
4. Reinicie o servidor após modificações

## 📝 Logs

O sistema registra todas as ações no console do servidor:
```
>> [Global Config] Aplicando configurações globais...
>> [Global Config] Configurações aplicadas para jogadores online!
>> [Mass Update] Atualização em massa concluída!
```

---

**🎮 Divirta-se com seu servidor configurado!**
