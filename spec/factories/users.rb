FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    age { rand(1..99) }
    password { "123456" }
  end
end
