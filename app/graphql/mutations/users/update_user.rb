# frozen_string_literal: true

module Mutations
  module Users
    class UpdateUser < GraphQL::Schema::Mutation
      argument :id, GraphQL::Types::ID, required: true
      argument :name, String, required: false
      argument :email, String, required: false
      argument :age, Integer, required: false
      argument :password, String, required: false

      field :user, Types::Users::UserType, null: true
      field :errors, [String], null: false

      def resolve(id:, **attrs)
        user = User.find_by(id: id)
        if user.update(attrs.compact)
          { user: user, errors: [] }
        else
          { user: nil, errors: ['User not found'] }
        end
      end
    end
  end
end
