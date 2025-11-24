# frozen_string_literal: true

module Types
  module Users
    class UserInputType < Types::BaseInputObject
      argument :name, String, required: true
      argument :email, String, required: true
      argument :age, Int, required: true
      argument :password, String, required: true
    end
  end
end
