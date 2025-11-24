# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    include Types::Users::UserQueries
  end
end
