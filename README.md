# 🎬 Catálogo de Filmes: A Essência da 7ª Arte

Um catálogo de filmes moderno e elegante, desenvolvido com Ruby on Rails, inspirado nas melhores interfaces de streaming como Netflix, Disney+ e HBO Max.

## ✨ Design & Conceito

Este catálogo foi concebido com uma estética moderna e elegante, utilizando:

- **Paleta de Cores**: Preto profundo e cinzas escuros com toques de dourado e vermelho borgonha para criar um contraste luxuoso
- **Tipografia**: Montserrat para títulos e Open Sans para corpo de texto
- **Layout**: Design responsivo com cards elegantes, sombras sutis e animações suaves

## 🚀 Funcionalidades Principais

- 🔍 **Busca Dinâmica**: Pesquise filmes por título, diretor ou sinopse em tempo real
- ⭐ **Sistema de Avaliação**: Exibição de notas com estrelas douradas (0-5)
- 🏷️ **Filtro por Gênero**: Organize filmes por categorias/gêneros
- 🖥️ **Design Responsivo**: Layout otimizado para desktop, tablet e dispositivos móveis
- 💬 **Comentários**: Sistema de comentários para usuários registrados e visitantes
- 👤 **Autenticação**: Sistema completo com Devise (registro, login, perfil)
- 📝 **CRUD Completo**: Criação, edição e exclusão de filmes (usuários autenticados)

## 🛠️ Tecnologias Utilizadas

### Backend
- **Ruby**: 3.3+
- **Rails**: 8.0
- **PostgreSQL**: Banco de dados
- **Devise**: Autenticação de usuários
- **Active Storage**: Upload de pôsters

### Frontend
- **Bootstrap 5.3**: Framework CSS
- **Google Fonts**: Montserrat & Open Sans
- **Turbo Rails**: Navegação SPA-like
- **JavaScript ES6+**: Interatividade

### Infraestrutura
- **Docker**: Containerização
- **Kamal**: Deploy

## 📋 Pré-requisitos

- Ruby 3.3 ou superior
- PostgreSQL 14+
- Node.js 18+ (para asset pipeline)
- Yarn ou npm

## 🔧 Instalação e Execução

### 1. Clonar o Repositório

```bash
git clone https://github.com/devaleixo/movie_catalog.git
cd movie_catalog
```

### 2. Instalar Dependências

```bash
# Instalar gems do Ruby
bundle install

# Instalar pacotes JavaScript
yarn install
# ou
npm install
```

### 3. Configurar Banco de Dados

```bash
# Criar banco de dados
rails db:create

# Executar migrations
rails db:migrate

# (Opcional) Popular com dados de exemplo
rails db:seed
```

### 4. Executar a Aplicação

```bash
# Modo desenvolvimento
rails server

# ou usar bin/dev para incluir assets
bin/dev
```

### 5. Acessar

O catálogo estará disponível em: **http://localhost:3000**

## 🎨 Estrutura de Dados

### Modelo de Filme

| Campo | Tipo | Descrição |
|-------|------|-----------|
| title | String | Título do filme |
| director | String | Nome do diretor |
| synopsis | Text | Sinopse/descrição |
| release_year | Integer | Ano de lançamento |
| duration | Integer | Duração em minutos |
| rating | Decimal | Avaliação (0.0 - 5.0) |
| poster | ActiveStorage | Imagem do pôster |

### Relacionamentos

- `Movie` belongs_to `User` (criador)
- `Movie` has_many `Comments`
- `Movie` has_and_belongs_to_many `Categories`

## 🧪 Testes

```bash
# Executar suite completa de testes
rspec

# Executar testes específicos
rspec spec/models/movie_spec.rb
```

## 🐳 Docker

```bash
# Build da imagem
docker build -t movie_catalog .

# Executar container
docker run -p 3000:3000 movie_catalog
```

## 📱 Responsividade

O design é totalmente responsivo com breakpoints em:

- **Desktop**: ≥992px (3 colunas de cards)
- **Tablet**: 768px - 991px (2 colunas)
- **Mobile**: ≤767px (1 coluna, layout otimizado)

## 🎯 Decisões Técnicas

### Frontend
- **Bootstrap 5.3**: Escolhido pela robustez e componentes prontos
- **CSS Variables**: Para fácil customização e tema escuro
- **Turbo Rails**: SPA-like sem complexidade de frameworks JS
- **Auto-submit Search**: Debounce de 500ms para melhor UX

### Backend
- **PostgreSQL**: ILIKE para buscas case-insensitive
- **Devise**: Solução madura para autenticação
- **Active Storage**: Upload direto para cloud-ready
- **Kaminari**: Paginação eficiente

### Estilização
- **Arquitetura Modular**: CSS organizado por componentes
- **Mobile-First**: Design responsivo desde o início
- **Acessibilidade**: Contraste adequado e focus states

## 👨‍💻 Desenvolvedor

**Devaleixo**

- 💼 [LinkedIn](https://www.linkedin.com/in/devaleixo/)
- 🐙 [GitHub](https://github.com/devaleixo)

## 📄 Licença

Este projeto está sob licença MIT. Veja o arquivo LICENSE para mais detalhes.

## 🙏 Agradecimentos

Design inspirado pelas melhores plataformas de streaming e sites de cinema profissionais, com foco em criar uma experiência premium para os amantes da 7ª Arte.

---

**Desenvolvido com ❤️ e ☕ por Devaleixo**
