# frozen_string_literal: true

module Types
  class PaginateType < Types::BaseObject
    field_class GraphQL::Schema::Field

    def self.create(item_type)
      Class.new(Types::BaseObject) do
        graphql_name "#{item_type.graphql_name}Paginate"

        field :items, [item_type], null: false
        field :total_pages, Integer, null: false
        field :current_page, Integer, null: false
        field :total_count, Integer, null: false
      end
    end
  end
end
