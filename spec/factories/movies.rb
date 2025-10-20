FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    synopsis { Faker::Lorem.paragraph }
    release_year { Faker::Number.between(from: 1900, to: 2024) }
    duration { Faker::Number.between(from: 60, to: 240) }
    director { Faker::Name.name }
    user
  end
end
