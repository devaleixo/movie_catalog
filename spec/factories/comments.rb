FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.sentence }
    author_name { Faker::Name.name }
    association :movie
    association :user, factory: :user, strategy: :create
  end
end
