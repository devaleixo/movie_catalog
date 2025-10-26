# 🔍 Teste Rápido - Feature de IA

## ⚠️ IMPORTANTE: Reinicie o Servidor

O Rails precisa ser reiniciado para carregar o novo controller JavaScript:

```bash
# No terminal onde o Rails está rodando:
# 1. Pressione Ctrl+C para parar
# 2. Execute novamente:
rails server
```

## ✅ Checklist de Verificação

### 1. Servidor está rodando?
```bash
# Em um novo terminal:
curl http://localhost:3000
```
✅ Deve retornar HTML
❌ Se der erro, inicie com: `rails server`

### 2. Configurou a API Key do Gemini?
```bash
cat .env | grep GEMINI_API_KEY
```
✅ Deve mostrar sua chave (não `your_gemini_api_key_here`)
❌ Edite o arquivo `.env` e adicione sua chave

### 3. Instale as gems (se ainda não fez):
```bash
bundle install
```

## 🧪 Como Testar

### Passo 1: Abrir a página
1. Abra o navegador
2. Vá para: `http://localhost:3000/movies/new`

### Passo 2: Abrir o Console do Navegador
1. Pressione **F12**
2. Clique na aba **Console**

### Passo 3: Verificar se o controller carregou
Você deve ver esta mensagem no console:
```
✅ Movie form controller connected successfully!
```

❌ **Se NÃO aparecer:**
- Reinicie o servidor (Ctrl+C e depois `rails server`)
- Recarregue a página (F5)

### Passo 4: Testar o botão
1. Digite "Matrix" no campo de busca IA
2. Clique no botão "🤖 Buscar Dados"
3. No console você deve ver:
```
🚀 fetchAiData() called
Movie title: Matrix
📡 Sending request to server...
🔑 CSRF Token: Found
📥 Response received: 200
📄 Response data: {...}
✅ Success! Filling form with data...
🏁 Request completed
```

## 🐛 Problemas Comuns

### Nada acontece ao clicar no botão

**Causa:** Controller não foi carregado
**Solução:**
1. Reinicie o servidor Rails
2. Recarregue a página
3. Verifique se aparece "✅ Movie form controller connected successfully!" no console

### Erro: "GEMINI_API_KEY não configurada"

**Solução:**
1. Obtenha uma chave em: https://aistudio.google.com/app/apikey
2. Edite o arquivo `.env` na raiz do projeto:
```
GEMINI_API_KEY=sua_chave_aqui
```
3. Reinicie o servidor

### Erro: "Failed to fetch" ou problema de CORS

**Causa:** Servidor Rails não está rodando
**Solução:**
```bash
rails server
```

### Erro 422: "Can't verify CSRF token"

**Causa:** Token CSRF não encontrado
**Solução:** Recarregue a página (F5)

## 📊 Ver logs do servidor

Em outro terminal:
```bash
tail -f log/development.log
```

Clique no botão e veja os logs aparecerem.

## 🎯 Teste direto da API Gemini

Para verificar se a integração com o Gemini funciona:

```bash
rails runner "
result = GeminiService.new.fetch_movie_data('Matrix')
puts JSON.pretty_generate(result)
"
```

✅ Deve retornar dados do filme Matrix
❌ Se der erro, verifique a API key no arquivo `.env`
