# frozen_string_literal: true

module Mutations
  module Users
    class CreateUser < GraphQL::Schema::Mutation
      # 1️⃣ Define direct arguments
      argument :name, String, required: true
      argument :email, String, required: true
      argument :age, Integer, required: false
      argument :password, String, required: true

      # 2️⃣ Define return fields
      field :user, Types::Users::UserType, null: true
      field :errors, [String], null: false

      # 3️⃣ Define the resolve method
      def resolve(name:, email:, password:, age:)
        user = User.new(name: name, email: email, password: password, age: age)
        if user.save
          { user: user, errors: [] }
        else
          { user: nil, errors: user.errors.full_messages }
        end
      end
    end
  end
end
