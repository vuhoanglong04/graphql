FactoryBot.define do
  factory :user do
    name { "Test User" }
    email { "user@example.com" }
    age { 15 }
    password { "123456" }
  end
end
