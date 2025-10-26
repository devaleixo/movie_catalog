# 🎬 Catálogo de Filmes - Desafio Técnico Mainô

Um catálogo de filmes moderno e elegante, desenvolvido com Ruby on Rails, inspirado nas melhores interfaces de streaming como Netflix, Disney+ e HBO Max.

> **Projeto desenvolvido como parte do Desafio Técnico Mainô**

---

## 📑 Índice

- [Design & Conceito](#-design--conceito)
- [Funcionalidades Implementadas](#-funcionalidades-implementadas)
- [Tecnologias Utilizadas](#️-tecnologias-utilizadas)
- [Instalação e Execução Local](#-instalação-e-execução-local)
- [Como Rodar Sidekiq](#-como-rodar-sidekiq)
- [Importação em Massa de Filmes (CSV)](#-importação-em-massa-de-filmes-csv)
- [Autopreenchimento com IA (Gemini)](#-autopreenchimento-com-ia-gemini)
- [Estrutura de Dados](#-estrutura-de-dados)
- [Testes](#-testes)
- [Status do Desafio](#-status-do-desafio)

---

## ✨ Design & Conceito

Este catálogo foi concebido com uma estética moderna e elegante, utilizando:

- **Paleta de Cores**: Preto profundo (#0a0a0a) e cinzas escuros com toques de dourado (#d4af37) e vermelho borgonha (#800020) para criar um contraste luxuoso
- **Tipografia**: Montserrat para títulos e Open Sans para corpo de texto
- **Layout**: Design responsivo com cards elegantes, sombras sutis e animações suaves
- **Inspiração**: Netflix, Disney+, HBO Max e sites de cinema profissionais

---

## 🚀 Funcionalidades Implementadas

### 📌 Funcionalidades Obrigatórias

#### Área Pública (sem login)
- ✅ **Listagem de Filmes**: Com paginação (6 filmes por página via Kaminari)
- ✅ **Ordenação**: Do mais novo para o mais antigo (por `release_year`)
- ✅ **Visualização de Detalhes**: Página completa com todas as informações do filme
- ✅ **Comentários Anônimos**: Qualquer visitante pode comentar informando apenas nome e conteúdo
- ✅ **Autenticação**: Sistema completo com Devise (cadastro, login, recuperação de senha)

#### Área Autenticada (com login)
- ✅ **CRUD Completo de Filmes**: Usuários autenticados podem criar, editar e excluir **apenas seus próprios filmes**
- ✅ **Comentários Autenticados**: Usuários logados podem comentar sem informar nome (usa dados do perfil)
- ✅ **Edição de Perfil**: Alteração de senha e dados pessoais

### 🌟 Funcionalidades Opcionais Implementadas

- ✅ **Categorias e Tags**: Relação many-to-many entre filmes e categorias, com filtros na interface
- ✅ **Busca e Filtros**: 
  - Busca dinâmica por título, diretor ou sinopse
  - Filtros por categoria
  - Auto-submit com debounce de 500ms
- ✅ **Upload de Imagem**: Active Storage para pôsteres de filmes
- ✅ **Sistema de Avaliação**: Rating de 0.0 a 5.0 estrelas com exibição visual elegante

### 🎯 Super Diferenciais Implementados

#### 1️⃣ Importação em Massa (CSV + Sidekiq)
- ✅ Upload de arquivo CSV com múltiplos filmes
- ✅ Processamento assíncrono em segundo plano com **Sidekiq Worker**
- ✅ Modelo `ImportStatus` para rastrear progresso (pending → processing → completed/failed)
- ✅ Notificação por email quando a importação é concluída
- ✅ Interface de acompanhamento com auto-refresh a cada 5s
- ✅ Tratamento de erros individuais por linha
- ✅ Histórico de importações paginado

#### 2️⃣ Integração com IA (Gemini API)
- ✅ Autopreenchimento de dados do filme ao digitar o título
- ✅ Integração com **Google Gemini 2.5 Flash API**
- ✅ Preenchimento automático de: sinopse, ano, duração, diretor, rating e categorias
- ✅ Interface AJAX elegante com feedback visual
- ✅ Tratamento de erros de integração

---

## 🛠️ Tecnologias Utilizadas

### Backend
- **Ruby**: 3.3+
- **Rails**: 8.0.3
- **PostgreSQL**: Banco de dados relacional
- **Devise**: Autenticação de usuários
- **Active Storage**: Upload de pôsteres
- **Sidekiq**: Processamento assíncrono de jobs
- **Kaminari**: Paginação

### Frontend
- **Bootstrap 5.3**: Framework CSS responsivo
- **Google Fonts**: Montserrat & Open Sans
- **Turbo Rails**: Navegação SPA-like
- **Stimulus.js**: Framework JavaScript
- **JavaScript ES6+**: Interatividade e AJAX

### Integrações
- **Google Gemini API**: IA generativa para autopreenchimento
- **Redis**: Backend para Sidekiq
- **Action Mailer**: Notificações por email

### Infraestrutura
- **Docker**: Containerização
- **Kamal**: Deploy

---

## 💻 Instalação e Execução Local

### 1. Pré-requisitos

- **Ruby** 3.3 ou superior
- **PostgreSQL** 14+
- **Redis** (necessário para Sidekiq)
- **Node.js** 18+ (para asset pipeline)

### 2. Clonar o Repositório

```bash
git clone https://github.com/devaleixo/movie_catalog.git
cd movie_catalog
```

### 3. Instalar Dependências

```bash
# Instalar gems do Ruby
bundle install

# Instalar pacotes JavaScript
yarn install
# ou
npm install
```

### 4. Configurar Variáveis de Ambiente

```bash
# Copiar arquivo de exemplo
cp .env.example .env

# Editar .env e adicionar suas credenciais
# GEMINI_API_KEY=sua_chave_aqui (opcional - para feature de IA)
```

### 5. Configurar Banco de Dados

```bash
# Criar banco de dados
rails db:create

# Executar migrations
rails db:migrate

# (Opcional) Popular com dados de exemplo
rails db:seed
```

### 6. Instalar e Iniciar Redis

Redis é necessário para o Sidekiq funcionar.

**Ubuntu/Debian:**
```bash
sudo apt-get install redis-server
redis-server
```

**macOS:**
```bash
brew install redis
brew services start redis
```

**Verificar se Redis está rodando:**
```bash
redis-cli ping
# Deve retornar: PONG
```

### 7. Executar a Aplicação

**Terminal 1 - Rails Server:**
```bash
rails server
# ou
bin/dev
```

**Terminal 2 - Sidekiq (para importação CSV):**
```bash
bundle exec sidekiq
```

### 8. Acessar a Aplicação

- **Aplicação Principal**: http://localhost:3000
- **Sidekiq Dashboard**: http://localhost:3000/sidekiq
- **Criar Conta/Login**: http://localhost:3000/users/sign_up

---

## 🚀 Como Rodar Sidekiq

Sidekiq é usado para processamento assíncrono da importação de filmes via CSV.

### Requisitos
- Redis deve estar instalado e rodando

### Executar Sidekiq

**Em um terminal separado**, execute:

```bash
bundle exec sidekiq
```

**Saída esperada:**
```
         m,
         `$b
    .ss,  $$:         .,d$
    `$$P,d$P'    .,md$P"'
     ,$$$$$b/md$$$P^'
   .d$$$$$$/$$$P'
   $$^' `"/$$$'       ____  _     _      _    _
   $:     ,$$:       / ___|(_) __| | ___| | _(_) __ _
   `b     :$$        \___ \| |/ _` |/ _ \ |/ / |/ _` |
          $$:         ___) | | (_| |  __/   <| | (_| |
          $$         |____/|_|\__,_|\___|_|\_\_|\__, |
        .d$$                                       |_|
```

### Monitoramento

Acesse a interface web do Sidekiq em:
**http://localhost:3000/sidekiq**

Lá você pode:
- Ver jobs em execução
- Verificar filas
- Ver histórico de jobs
- Reprocessar jobs com falha

### Configuração de Produção

Em produção, use um processo gerenciador como:
- **systemd** (Linux)
- **Heroku/Render Workers**
- **Docker Compose**

**Nota**: No plano gratuito do Render, Sidekiq pode não estar disponível. O código está pronto, mas o processamento será síncrono.

---

## 📂 Importação em Massa de Filmes (CSV)

### Como Usar

1. **Acesse**: http://localhost:3000/imports/new (precisa estar logado)
2. **Faça upload** do arquivo CSV
3. **Acompanhe** o progresso em tempo real
4. **Receba** email quando concluído

### Formato Esperado do CSV

#### Estrutura do Arquivo

```csv
title,synopsis,release_year,duration,director,rating,categories
```

#### Descrição das Colunas

| Coluna | Tipo | Obrigatório | Descrição | Exemplo |
|--------|------|-------------|-----------|---------|
| **title** | String | ✅ Sim | Título do filme (único) | Matrix |
| **synopsis** | Text | ✅ Sim | Sinopse/descrição | Um hacker descobre a realidade |
| **release_year** | Integer | ✅ Sim | Ano de lançamento | 1999 |
| **duration** | Integer | ✅ Sim | Duração em minutos | 136 |
| **director** | String | ✅ Sim | Nome do diretor | Lana Wachowski |
| **rating** | Decimal | ❌ Não | Avaliação de 0 a 5 | 4.6 |
| **categories** | String | ❌ Não | Gêneros separados por \| | Ação\|Ficção Científica |

#### Arquivo de Exemplo

**Disponível em**: `public/example_movies.csv`

**Download**: http://localhost:3000/example_movies.csv

**Conteúdo do exemplo:**

```csv
title,synopsis,release_year,duration,director,rating,categories
Matrix,Um hacker descobre a verdade sobre a realidade,1999,136,Lana Wachowski,4.6,Ação|Ficção Científica
O Poderoso Chefão,A saga de uma família mafiosa em Nova York,1972,175,Francis Ford Coppola,5.0,Crime|Drama
Pulp Fiction,Histórias interligadas do submundo do crime,1994,154,Quentin Tarantino,4.8,Crime|Drama
```

### Dicas de Formatação

1. **Encoding**: Use UTF-8
2. **Delimitador**: Vírgula (,)
3. **Aspas**: Use aspas duplas se houver vírgulas no texto
   ```csv
   "Matrix, O Filme","Um hacker, chamado Neo, descobre",1999,136,Lana Wachowski,4.6,Ação
   ```
4. **Categorias**: Separe múltiplas categorias com pipe (|)
5. **Títulos duplicados**: Serão ignorados (validação de unicidade)

### Validações Automáticas

- ✅ Títulos e diretores são formatados em Title Case
- ✅ Categorias são criadas automaticamente se não existirem
- ✅ Erros em uma linha não param o processamento das outras
- ✅ Relatório detalhado de erros é fornecido

### Acompanhamento

- **Interface web**: Auto-refresh a cada 5s durante processamento
- **Email**: Notificação automática ao concluir
- **Sidekiq Dashboard**: Monitor em tempo real
- **Histórico**: Lista de todas as importações com status

---

## 🤖 Autopreenchimento com IA (Gemini)

### Configuração

#### 1. Obter Chave da API

1. Acesse: https://aistudio.google.com/app/apikey
2. Faça login com sua conta Google
3. Clique em "Create API Key"
4. Copie a chave gerada

#### 2. Configurar no Projeto

Edite o arquivo `.env` e adicione:

```env
GEMINI_API_KEY=sua_chave_aqui
```

#### 3. Reiniciar o Servidor

```bash
# Parar o servidor (Ctrl+C) e reiniciar
rails server
```

### Como Usar

1. **Acesse**: http://localhost:3000/movies/new
2. **Localize** a seção "✨ Preencher com IA" no topo do formulário
3. **Digite** o nome do filme no campo de busca
4. **Clique** em "🤖 Buscar Dados" ou pressione Enter
5. **Aguarde** alguns segundos (2-5s)
6. **Revise** os dados preenchidos automaticamente
7. **Ajuste** se necessário e salve

### O que é Preenchido

A IA retorna automaticamente:
- ✅ Título completo
- ✅ Sinopse detalhada
- ✅ Ano de lançamento
- ✅ Duração em minutos
- ✅ Nome do diretor
- ✅ Avaliação (rating 0-5)
- ✅ Categorias/gêneros

### Limitações

- Filmes muito obscuros ou recentes podem não ser encontrados
- A qualidade depende do conhecimento do modelo Gemini
- Necessita conexão com internet ativa
- Plano gratuito: 15 requisições/minuto, 1500/dia

### Custos

**Plano Gratuito do Gemini:**
- 15 requisições por minuto
- 1.500 requisições por dia
- 1 milhão de tokens por mês

**Totalmente suficiente para desenvolvimento e uso moderado.**

Mais informações: https://ai.google.dev/pricing

---

## 🎨 Estrutura de Dados

### Modelo `Movie` (Filme)

| Campo | Tipo | Validações | Descrição |
|-------|------|-----------|-----------|
| title | String | Obrigatório, único | Título do filme |
| director | String | Obrigatório | Nome do diretor |
| synopsis | Text | Obrigatório | Sinopse/descrição |
| release_year | Integer | Obrigatório | Ano de lançamento |
| duration | Integer | Obrigatório | Duração em minutos |
| rating | Decimal(3,1) | 0.0 - 5.0 | Avaliação do filme |
| user_id | Integer | FK | Criador do filme |
| poster | ActiveStorage | - | Imagem do pôster |

### Modelo `User` (Usuário)

| Campo | Tipo | Descrição |
|-------|------|-----------|
| email | String | Email único |
| encrypted_password | String | Senha criptografada (Devise) |
| name | String | Nome do usuário |

### Modelo `Comment` (Comentário)

| Campo | Tipo | Descrição |
|-------|------|-----------|
| content | Text | Conteúdo do comentário |
| author_name | String | Nome (anônimos) |
| user_id | Integer | FK (opcional - autenticados) |
| movie_id | Integer | FK |

### Modelo `Category` (Categoria)

| Campo | Tipo | Descrição |
|-------|------|-----------|
| name | String | Nome da categoria |

### Modelo `ImportStatus` (Status de Importação)

| Campo | Tipo | Descrição |
|-------|------|-----------|
| user_id | Integer | FK |
| filename | String | Nome do arquivo CSV |
| status | String | pending/processing/completed/failed |
| total_rows | Integer | Total de linhas |
| processed_rows | Integer | Linhas processadas |
| success_count | Integer | Sucessos |
| error_count | Integer | Erros |
| error_messages | Text | Detalhes dos erros |
| started_at | DateTime | Início do processamento |
| completed_at | DateTime | Fim do processamento |

### Relacionamentos

```ruby
# Movie
belongs_to :user
has_many :comments
has_and_belongs_to_many :categories

# User
has_many :movies
has_many :comments
has_many :import_statuses

# Comment
belongs_to :movie
belongs_to :user, optional: true

# Category
has_and_belongs_to_many :movies

# ImportStatus
belongs_to :user
```

---

## 🧪 Testes

### Executar Testes

```bash
# Suite completa
rspec

# Testes específicos
rspec spec/models/movie_spec.rb
rspec spec/controllers/movies_controller_spec.rb
```

### Cobertura de Testes

- ✅ Models (validações e métodos)
- ✅ Controllers (ações e autorização)
- ✅ Integração básica

---

## 📊 Status do Desafio

### ✅ Funcionalidades Obrigatórias (100%)

| Funcionalidade | Status |
|---------------|--------|
| Listagem de filmes (pública) | ✅ Implementado |
| Paginação (6 por página) | ✅ Implementado |
| Visualização de detalhes | ✅ Implementado |
| Comentários anônimos | ✅ Implementado |
| Autenticação (Devise) | ✅ Implementado |
| CRUD de filmes (autenticado) | ✅ Implementado |
| Autorização (apenas próprios filmes) | ✅ Implementado |
| Comentários autenticados | ✅ Implementado |
| Edição de perfil | ✅ Implementado |

### ✅ Funcionalidades Opcionais (100%)

| Funcionalidade | Status |
|---------------|--------|
| Categorias e Tags | ✅ Implementado |
| Busca e Filtros | ✅ Implementado |
| Upload de Imagem | ✅ Implementado |

### 🌟 Super Diferenciais (100%)

| Funcionalidade | Status | Detalhes |
|---------------|--------|----------|
| **Importação CSV + Sidekiq** | ✅ Implementado | Worker, emails, tracking completo |
| **Integração com IA** | ✅ Implementado | Google Gemini API, autopreenchimento |

---

## 📱 Responsividade

O design é totalmente responsivo com breakpoints em:

- **Desktop**: ≥992px (3 colunas de cards)
- **Tablet**: 768px - 991px (2 colunas)
- **Mobile**: ≤767px (1 coluna, layout otimizado)

---

## 🎯 Decisões Técnicas

### Frontend
- **Bootstrap 5.3**: Framework robusto e componentes prontos
- **CSS Variables**: Fácil customização e tema escuro consistente
- **Turbo Rails**: SPA-like sem complexidade de frameworks JS pesados
- **Stimulus.js**: Interatividade moderna e organizada
- **Auto-submit Search**: Debounce de 500ms para melhor UX

### Backend
- **PostgreSQL**: ILIKE para buscas case-insensitive eficientes
- **Devise**: Solução madura e testada para autenticação
- **Active Storage**: Upload direto, cloud-ready
- **Kaminari**: Paginação simples e eficiente
- **Sidekiq**: Processamento assíncrono escalável
- **Service Objects**: Lógica de negócio isolada (GeminiService)

### Estilização
- **Arquitetura Modular**: CSS organizado por componentes
- **Mobile-First**: Design responsivo desde o início
- **Acessibilidade**: Contraste adequado (WCAG AA) e focus states
- **Animações**: Transições suaves e feedback visual

---

## 📚 Documentação Adicional

Mais detalhes sobre features específicas:

- `CSV_IMPORT_FEATURE.md` - Importação em massa detalhada
- `AI_AUTOFILL_FEATURE.md` - Integração com IA
- `IMPLEMENTATION-SUMMARY.md` - Resumo técnico da implementação
- `RESPONSIVE-DESIGN.MD` - Decisões de design

---

## 👨‍💻 Desenvolvedor

**Devaleixo**

- 💼 [LinkedIn](https://www.linkedin.com/in/devaleixo/)
- 🐙 [GitHub](https://github.com/devaleixo)

---

## 🙏 Agradecimentos

Projeto desenvolvido como parte do **Desafio Técnico Mainô**, com design inspirado pelas melhores plataformas de streaming (Netflix, Disney+, HBO Max) e sites de cinema profissionais, criando uma experiência premium para os amantes da 7ª Arte.

---

**Desenvolvido com ❤️ e ☕ por Devaleixo**
