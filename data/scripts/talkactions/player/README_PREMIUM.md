# 🎉 SISTEMA DE PREMIUM MANAGER - COMANDOS PARA TODOS!

## 📋 **Descrição**
Sistema completo para gerenciar premium dos jogadores. Qualquer jogador pode adicionar, remover e verificar premium para si mesmo ou para outros jogadores.

## 🚀 **Comandos Disponíveis**

### 1️⃣ **Comando Simples - 1 Ano de Premium**
```
/1ano                    # ✅ Adiciona 1 ano de premium para você
/1ano NomeJogador       # ✅ Adiciona 1 ano de premium para outro jogador
```

### 2️⃣ **Comando Direto - Add Premium**
```
/addpremium             # ✅ Adiciona 1 ano de premium para você
/addpremium NomeJogador # ✅ Adiciona 1 ano de premium para outro jogador
```

### 3️⃣ **Sistema Completo - Premium Manager**
```
/premium help           # ❓ Mostra todos os comandos disponíveis
```

#### **Adicionar Premium:**
```
/premium add 1ano <nome>      # ✅ Adiciona 1 ano de premium
/premium add 6meses <nome>    # ✅ Adiciona 6 meses de premium
/premium add 1mes <nome>      # ✅ Adiciona 1 mês de premium
/premium add 1semana <nome>   # ✅ Adiciona 1 semana de premium
/premium add 1dia <nome>      # ✅ Adiciona 1 dia de premium
```

#### **Gerenciar Premium:**
```
/premium remove <nome>        # 🔄 Remove premium do jogador
/premium status <nome>        # 📊 Mostra status do premium
/premium list                 # 📋 Lista jogadores com premium
```

## 🎯 **Como Usar**

### **Para Você Mesmo:**
```
/1ano                      # Adiciona 1 ano de premium
/addpremium                # Adiciona 1 ano de premium
/premium add 1ano          # Adiciona 1 ano de premium
```

### **Para Outros Jogadores:**
```
/1ano Joao                 # Adiciona 1 ano para Joao
/addpremium Maria          # Adiciona 1 ano para Maria
/premium add 1ano Pedro    # Adiciona 1 ano para Pedro
```

### **Verificar Status:**
```
/premium status Joao       # Mostra status do premium de Joao
```

### **Listar Premium:**
```
/premium list              # Lista todos os jogadores com premium online
```

## ⏰ **Tempos Disponíveis**

| Comando | Tempo | Dias |
|---------|-------|------|
| `1ano` | 1 Ano | 365 dias |
| `6meses` | 6 Meses | 180 dias |
| `1mes` | 1 Mês | 30 dias |
| `1semana` | 1 Semana | 7 dias |
| `1dia` | 1 Dia | 1 dia |

## 🔧 **Funcionalidades**

### ✅ **Adicionar Premium:**
- Adiciona tempo ao premium existente
- Se não tiver premium, cria novo
- Suporta múltiplos períodos de tempo
- Atualiza automaticamente o jogador

### 🔄 **Remover Premium:**
- Remove todo o premium do jogador
- Define premium para 0 dias
- Atualiza automaticamente o jogador

### 📊 **Verificar Status:**
- Mostra se premium está ativo
- Dias restantes
- Tempo restante em anos/meses/dias
- Data de expiração

### 📋 **Listar Premium:**
- Lista todos os jogadores com premium online
- Ordenados por tempo de premium (maior para menor)
- Mostra tempo restante formatado

## 📝 **Exemplos Práticos**

### **Cenário 1: Jogador quer premium para si**
```
/1ano
```
**Resultado:** Adiciona 1 ano de premium para o jogador

### **Cenário 2: Jogador quer dar premium para amigo**
```
/1ano Joao
```
**Resultado:** Adiciona 1 ano de premium para Joao

### **Cenário 3: Verificar status do premium**
```
/premium status Joao
```
**Resultado:** Mostra status completo do premium de Joao

### **Cenário 4: Listar todos com premium**
```
/premium list
```
**Resultado:** Lista todos os jogadores online com premium

## ⚠️ **Importante**

- **Todos os jogadores** podem usar estes comandos
- **Não é necessário ser administrador**
- **Premium é adicionado ao tempo existente**
- **Jogador é atualizado automaticamente**
- **Sistema funciona para qualquer jogador online**

## 📁 **Arquivos do Sistema**

1. **`premium_1ano.lua`** - Comando simples `/1ano`
2. **`add_premium_year.lua`** - Comando `/addpremium`
3. **`premium_manager.lua`** - Sistema completo `/premium`
4. **`README_PREMIUM.md`** - Este arquivo de documentação

## 🎊 **Resumo Rápido**

**Para adicionar 1 ano de premium:**
- **Comando mais simples:** `/1ano`
- **Comando direto:** `/addpremium`
- **Sistema completo:** `/premium add 1ano`

**Para outro jogador:**
- Adicione o nome após o comando: `/1ano Joao`

---

## 🎉 **RESULTADO FINAL:**

**Agora QUALQUER JOGADOR pode:**
- ✅ Adicionar 1 ano de premium para si mesmo
- 🎯 Adicionar 1 ano de premium para outros
- 📊 Verificar status de premium
- 📋 Listar jogadores com premium
- 🔄 Remover premium
- ⏰ Adicionar diferentes períodos de tempo

**O sistema está 100% funcional e acessível para todos!** 🚀
