# frozen_string_literal: true

require 'faker'

5.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    age: Faker::Number.number(digits: 2),
    password: '123456'
  )
end

puts 'Seeded 5 users!'
