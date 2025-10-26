# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "🌱 Iniciando seed..."

# Criar usuário padrão
puts "👤 Criando usuário padrão..."
user = User.find_or_create_by!(email: 'admin@moviecatalog.com') do |u|
  u.password = 'password123'
  u.password_confirmation = 'password123'
end
puts "✅ Usuário criado: #{user.email}"

# Criar categorias
puts "\n🏷️ Criando categorias..."
categories_data = [
  'Ação', 'Aventura', 'Animação', 'Comédia', 'Crime',
  'Documentário', 'Drama', 'Fantasia', 'Ficção Científica',
  'Guerra', 'História', 'Horror', 'Mistério', 'Romance',
  'Suspense', 'Thriller', 'Faroeste'
]

categories = {}
categories_data.each do |name|
  category = Category.find_or_create_by!(name: name)
  categories[name.downcase] = category
  puts "  ✓ #{category.name}"
end

# Criar filmes
puts "\n🎬 Criando filmes..."

movies_data = [
  {
    title: 'O Poderoso Chefão',
    director: 'Francis Ford Coppola',
    release_year: 1972,
    duration: 175,
    rating: 4.9,
    synopsis: 'A saga da família Corleone, uma das mais poderosas famílias do crime organizado de Nova York. O patriarca Vito Corleone transfere o controle do império criminoso para seu filho Michael.',
    categories: ['crime', 'drama'],
    poster_url: 'https://image.tmdb.org/t/p/w500/3bhkrj58Vtu7enYsRolD1fZdja1.jpg'
  },
  {
    title: 'Um Sonho de Liberdade',
    director: 'Frank Darabont',
    release_year: 1994,
    duration: 142,
    rating: 4.9,
    synopsis: 'Dois homens presos se reúnem ao longo de vários anos, encontrando consolo e eventual redenção através de atos de decência comum.',
    categories: ['drama'],
    poster_url: 'https://image.tmdb.org/t/p/w500/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg'
  },
  {
    title: 'Batman: O Cavaleiro das Trevas',
    director: 'Christopher Nolan',
    release_year: 2008,
    duration: 152,
    rating: 4.8,
    synopsis: 'Batman enfrenta seu maior desafio quando o Coringa cria o caos em Gotham City, forçando o herói a questionar seus próprios limites morais.',
    categories: ['ação', 'crime', 'drama'],
    poster_url: 'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg'
  },
  {
    title: 'A Lista de Schindler',
    director: 'Steven Spielberg',
    release_year: 1993,
    duration: 195,
    rating: 4.8,
    synopsis: 'Na Polônia durante a Segunda Guerra Mundial, Oskar Schindler gradualmente se preocupa com sua força de trabalho judaica depois de testemunhar sua perseguição pelos nazistas.',
    categories: ['drama', 'história', 'guerra'],
    poster_url: 'https://image.tmdb.org/t/p/w500/sF1U4EUQS8YHUYjNl3pMGNIQyr0.jpg'
  },
  {
    title: 'O Senhor dos Anéis: O Retorno do Rei',
    director: 'Peter Jackson',
    release_year: 2003,
    duration: 201,
    rating: 4.8,
    synopsis: 'Gandalf e Aragorn lideram o mundo dos homens contra o exército de Sauron para distrair seu olhar de Frodo e Sam enquanto se aproximam da Montanha da Perdição com o Um Anel.',
    categories: ['aventura', 'fantasia', 'ação'],
    poster_url: 'https://image.tmdb.org/t/p/w500/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg'
  },
  {
    title: 'Pulp Fiction: Tempo de Violência',
    director: 'Quentin Tarantino',
    release_year: 1994,
    duration: 154,
    rating: 4.7,
    synopsis: 'As vidas de dois assassinos da máfia, um boxeador, um gângster e sua esposa se entrelaçam em quatro contos de violência e redenção.',
    categories: ['crime', 'drama'],
    poster_url: 'https://image.tmdb.org/t/p/w500/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg'
  },
  {
    title: 'Forrest Gump',
    director: 'Robert Zemeckis',
    release_year: 1994,
    duration: 142,
    rating: 4.7,
    synopsis: 'As presidências de Kennedy e Johnson, os eventos do Vietnã, Watergate e outras histórias se desenrolam através da perspectiva de um homem do Alabama com um QI de 75.',
    categories: ['drama', 'romance'],
    poster_url: 'https://image.tmdb.org/t/p/w500/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg'
  },
  {
    title: 'A Origem',
    director: 'Christopher Nolan',
    release_year: 2010,
    duration: 148,
    rating: 4.7,
    synopsis: 'Um ladrão que rouba segredos corporativos através do uso da tecnologia de compartilhamento de sonhos recebe a tarefa inversa de plantar uma ideia na mente de um CEO.',
    categories: ['ação', 'ficção científica', 'thriller'],
    poster_url: 'https://image.tmdb.org/t/p/w500/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg'
  },
  {
    title: 'Matrix',
    director: 'Lana Wachowski',
    release_year: 1999,
    duration: 136,
    rating: 4.6,
    synopsis: 'Um hacker de computador aprende com misteriosos rebeldes sobre a verdadeira natureza de sua realidade e seu papel na guerra contra seus controladores.',
    categories: ['ação', 'ficção científica'],
    poster_url: 'https://image.tmdb.org/t/p/w500/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg'
  },
  {
    title: 'Os Bons Companheiros',
    director: 'Martin Scorsese',
    release_year: 1990,
    duration: 145,
    rating: 4.6,
    synopsis: 'A história da ascensão e queda de Henry Hill e seus amigos através de três décadas de crime organizado.',
    categories: ['crime', 'drama'],
    poster_url: 'https://image.tmdb.org/t/p/w500/aKuFiU82s5ISJpGZp7YkIr3kCUd.jpg'
  },
  {
    title: 'Clube da Luta',
    director: 'David Fincher',
    release_year: 1999,
    duration: 139,
    rating: 4.6,
    synopsis: 'Um insone e um vendedor de sabão formam um clube de luta clandestino que evolui para algo muito mais.',
    categories: ['drama'],
    poster_url: 'https://image.tmdb.org/t/p/w500/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg'
  },
  {
    title: 'Interestelar',
    director: 'Christopher Nolan',
    release_year: 2014,
    duration: 169,
    rating: 4.6,
    synopsis: 'Uma equipe de exploradores viaja através de um buraco de minhoca no espaço na tentativa de garantir a sobrevivência da humanidade.',
    categories: ['aventura', 'drama', 'ficção científica'],
    poster_url: 'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg'
  },
  {
    title: 'Parasita',
    director: 'Bong Joon Ho',
    release_year: 2019,
    duration: 132,
    rating: 4.6,
    synopsis: 'Ganância e discriminação de classe ameaçam a relação simbiótica entre a família Park, rica, e o clã Kim, pobre.',
    categories: ['comédia', 'drama', 'thriller'],
    poster_url: 'https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg'
  },
  {
    title: 'O Rei Leão',
    director: 'Roger Allers',
    release_year: 1994,
    duration: 88,
    rating: 4.5,
    synopsis: 'O príncipe leão Simba e seu pai são alvos do tio Scar, que quer assumir o trono.',
    categories: ['animação', 'aventura', 'drama'],
    poster_url: 'https://image.tmdb.org/t/p/w500/sKCr78MXSLixwmZ8DyJLrpMsd15.jpg'
  },
  {
    title: 'De Volta para o Futuro',
    director: 'Robert Zemeckis',
    release_year: 1985,
    duration: 116,
    rating: 4.5,
    synopsis: 'Marty McFly, um estudante de 17 anos, é acidentalmente enviado 30 anos ao passado em um DeLorean viajante do tempo inventado por seu amigo, o Dr. Emmett Brown.',
    categories: ['aventura', 'comédia', 'ficção científica'],
    poster_url: 'https://image.tmdb.org/t/p/w500/fNOH9f1aA7XRTzl1sAOx9iF553Q.jpg'
  },
  {
    title: 'O Iluminado',
    director: 'Stanley Kubrick',
    release_year: 1980,
    duration: 146,
    rating: 4.5,
    synopsis: 'Uma família vai para um hotel isolado para o inverno onde uma presença sinistra influencia o pai à violência, enquanto seu filho psíquico vê horríveis premonições do passado e do futuro.',
    categories: ['drama', 'horror'],
    poster_url: 'https://image.tmdb.org/t/p/w500/xazWoLealQwEgqZ89MLZklLZD3k.jpg'
  },
  {
    title: 'Gladiador',
    director: 'Ridley Scott',
    release_year: 2000,
    duration: 155,
    rating: 4.5,
    synopsis: 'Um ex-general romano procura vingança contra o imperador corrupto que assassinou sua família e o enviou à escravidão.',
    categories: ['ação', 'aventura', 'drama'],
    poster_url: 'https://image.tmdb.org/t/p/w500/ty8TGRuvJLPUmAR1H1nRIsgwvim.jpg'
  },
  {
    title: 'Django Livre',
    director: 'Quentin Tarantino',
    release_year: 2012,
    duration: 165,
    rating: 4.5,
    synopsis: 'Com a ajuda de um caçador de recompensas alemão, um ex-escravo parte para resgatar sua esposa de um brutal proprietário de plantação do Mississippi.',
    categories: ['drama', 'faroeste'],
    poster_url: 'https://image.tmdb.org/t/p/w500/7oWY8VDWW7thTzWh3OKYRkWUlD5.jpg'
  }
]

movies_data.each do |data|
  movie = Movie.find_or_initialize_by(title: data[:title])
  
  if movie.new_record?
    movie.assign_attributes(
      director: data[:director],
      release_year: data[:release_year],
      duration: data[:duration],
      rating: data[:rating],
      synopsis: data[:synopsis],
      poster_url: data[:poster_url],
      user: user
    )
    
    # Adicionar categorias
    movie_categories = data[:categories].map { |cat| categories[cat] }.compact
    movie.categories = movie_categories
    
    if movie.save
      puts "  ✓ #{movie.title} (#{movie.release_year})"
    else
      puts "  ✗ Erro ao criar #{data[:title]}: #{movie.errors.full_messages.join(', ')}"
    end
  else
    puts "  → #{movie.title} já existe"
  end
end

puts "\n✨ Seed concluído!"
puts "📊 Resumo:"
puts "  - #{User.count} usuário(s)"
puts "  - #{Category.count} categoria(s)"
puts "  - #{Movie.count} filme(s)"
