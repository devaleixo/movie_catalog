# Feature: Preenchimento Automático com IA

## Descrição

Esta feature permite preencher automaticamente os dados de um filme usando a API do Google Gemini. Ao digitar o nome de um filme, a IA busca informações como sinopse, ano de lançamento, duração, diretor, avaliação e gêneros.

## Configuração

### 1. Instalar as dependências

```bash
bundle install
```

### 2. Obter chave da API Gemini

1. Acesse: https://aistudio.google.com/app/apikey
2. Faça login com sua conta Google
3. Crie uma nova API Key
4. Copie a chave gerada

### 3. Configurar variáveis de ambiente

1. Copie o arquivo de exemplo:
```bash
cp .env.example .env
```

2. Edite o arquivo `.env` e adicione sua chave:
```
GEMINI_API_KEY=sua_chave_aqui
```

### 4. Reiniciar o servidor

```bash
# Parar o servidor atual (Ctrl+C)
# Reiniciar
rails server
```

## Como Usar

1. Acesse a página de criação de novo filme: `/movies/new`
2. No topo do formulário, você verá uma seção "✨ Preencher com IA"
3. Digite o nome do filme no campo de busca
4. Clique no botão "🤖 Buscar Dados" ou pressione Enter
5. Aguarde alguns segundos enquanto a IA busca as informações
6. Os campos do formulário serão preenchidos automaticamente
7. Revise os dados e faça ajustes se necessário
8. Clique em "Create Movie" para salvar

## Arquivos Criados/Modificados

### Novos Arquivos

- `.env.example` - Template para variáveis de ambiente
- `app/services/gemini_service.rb` - Serviço de integração com Gemini API
- `app/javascript/controllers/movie_form_controller.js` - Controller Stimulus

### Arquivos Modificados

- `Gemfile` - Adicionadas gems `dotenv-rails` e `faraday`
- `.gitignore` - Atualizado para permitir `.env.example`
- `config/routes.rb` - Nova rota `POST /movies/fetch_ai_data`
- `app/controllers/movies_controller.rb` - Nova action `fetch_ai_data`
- `app/views/movies/_form.html.erb` - Interface de busca por IA adicionada

## Tecnologias Utilizadas

- **Google Gemini API** - Modelo de IA generativa
- **Stimulus.js** - Framework JavaScript para interatividade
- **Faraday** - Cliente HTTP para Ruby
- **dotenv-rails** - Gerenciamento de variáveis de ambiente

## Limitações

- A qualidade dos dados depende do conhecimento do modelo Gemini sobre o filme
- Filmes muito obscuros ou recentes podem não ser encontrados
- As categorias retornadas pela IA são mapeadas para as categorias existentes no sistema
- É necessário ter uma conexão com a internet ativa

## Solução de Problemas

### Erro: "GEMINI_API_KEY não configurada"

- Verifique se o arquivo `.env` existe na raiz do projeto
- Confirme que a variável `GEMINI_API_KEY` está definida no arquivo
- Reinicie o servidor Rails

### Erro: "Erro ao buscar dados"

- Verifique sua conexão com a internet
- Confirme que a API Key é válida
- Verifique se você não excedeu a quota gratuita da API

### O botão não responde

- Abra o Console do navegador (F12) e verifique se há erros JavaScript
- Confirme que o Stimulus está carregado corretamente
- Verifique se o Rails está rodando

## Custos

A API do Google Gemini possui um plano gratuito generoso:
- 15 requisições por minuto
- 1500 requisições por dia
- 1 milhão de tokens por mês

Para mais informações sobre limites e preços: https://ai.google.dev/pricing
