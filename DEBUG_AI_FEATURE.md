# Debug: Feature de IA não está funcionando

## Passos para Debug

### 1. Verificar se o servidor está rodando
```bash
# No terminal, verifique se o Rails está ativo
# Se não estiver, inicie com:
rails server
```

### 2. Abrir o Console do Navegador
1. Abra a página `/movies/new`
2. Pressione F12 (ou Ctrl+Shift+I no Linux)
3. Vá na aba "Console"
4. Recarregue a página (F5)
5. Procure por:
   - ✅ Mensagem: "Movie form controller connected"
   - ❌ Erros em vermelho

### 3. Verificar se o Stimulus está carregado
No console do navegador, digite:
```javascript
window.Stimulus
```

Deve retornar um objeto. Se retornar `undefined`, o Stimulus não está carregado.

### 4. Testar manualmente o controller
No console do navegador, digite:
```javascript
document.querySelector('[data-controller="movie-form"]')
```

Deve retornar o elemento do formulário. Se retornar `null`, o elemento não existe.

### 5. Verificar CSRF Token
No console do navegador, digite:
```javascript
document.querySelector('meta[name="csrf-token"]').content
```

Deve retornar uma string longa. Se der erro, o token CSRF não está configurado.

## Soluções Comuns

### Problema: "Movie form controller connected" não aparece

**Solução 1: Reiniciar o servidor**
```bash
# Pressione Ctrl+C para parar o servidor
# Depois inicie novamente:
rails server
```

**Solução 2: Limpar assets**
```bash
rails assets:clobber
rails assets:precompile
rails server
```

### Problema: Erro "Failed to fetch" ou "NetworkError"

**Verificar se a rota existe:**
```bash
rails routes | grep fetch_ai_data
```

Deve mostrar:
```
fetch_ai_data_movies POST /movies/fetch_ai_data(.:format) movies#fetch_ai_data
```

### Problema: Erro 422 ou 500 na requisição

**Verificar os logs do Rails:**
```bash
tail -f log/development.log
```

Clique no botão e veja o que aparece nos logs.

### Problema: "GEMINI_API_KEY não configurada"

**Verificar se o .env existe e está configurado:**
```bash
cat .env | grep GEMINI_API_KEY
```

Deve mostrar:
```
GEMINI_API_KEY=sua_chave_aqui
```

Se estiver como `your_gemini_api_key_here`, você precisa substituir pela sua chave real.

## Como obter mais informações

### Adicionar debug no JavaScript

Abra o arquivo: `app/javascript/controllers/movie_form_controller.js`

Na função `fetchAiData`, adicione `console.log`:

```javascript
async fetchAiData() {
  console.log("fetchAiData called!") // ADICIONE ESTA LINHA
  const movieTitle = this.aiSearchInputTarget.value.trim()
  console.log("Movie title:", movieTitle) // ADICIONE ESTA LINHA
  // ... resto do código
}
```

Salve e reinicie o servidor.

### Verificar requisição no Network

1. Abra F12 → aba "Network"
2. Clique no botão "Buscar Dados"
3. Procure por uma requisição para `fetch_ai_data`
4. Clique nela e veja:
   - **Status**: deve ser 200 (sucesso) ou 422/500 (erro)
   - **Response**: a resposta do servidor
   - **Headers**: verifique se o CSRF token foi enviado

## Teste Rápido

Execute este comando para testar a API diretamente:

```bash
rails runner "
gemini = GeminiService.new
result = gemini.fetch_movie_data('Matrix')
puts result.inspect
"
```

Isso vai mostrar se a integração com o Gemini está funcionando.
