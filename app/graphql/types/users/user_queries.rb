module Types
  module Users
    module UserQueries
      extend ActiveSupport::Concern
      included do
        field :users, Types::PaginateType.create(Types::Users::UserType), null: false do
          description "Return all users"
          argument :page, Integer, required: false, default_value: 1
          argument :per_page, Integer, required: false, default_value: 5
        end

        field :user, Types::Users::UserType, null: true do
          description "Return a single user"
          argument :id, GraphQL::Types::ID, required: true
        end
      end

      def users(page: 1, per_page: 10)
        paginated = User.order("id desc").page(page).per(per_page)
        {
          items: paginated,
          total_pages: paginated.total_pages,
          current_page: paginated.current_page,
          total_count: paginated.total_count
        }
      end

      def user(id:)
        User.find_by(id: id)
      end
    end
  end
end
