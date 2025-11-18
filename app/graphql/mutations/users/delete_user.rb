module Mutations
  module Users
    class DeleteUser < GraphQL::Schema::Mutation
      argument :id, GraphQL::Types::ID, required: true
      field :errors, [String], null: false

      def resolve(id:)
        user = User.find_by(id: id)
        if user.destroy
          { user: user, errors: [] }
        else
          { user: nil, errors: user.errors.full_messages }
        end
      end
    end
  end
end