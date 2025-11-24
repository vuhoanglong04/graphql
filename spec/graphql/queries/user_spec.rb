# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GraphQL Query', type: :request do
  describe 'query: user' do
    let(:user) { create(:user) }

    let(:query) do
      <<~GQL
        query($id: ID!) {
          user(id: $id) {
            id
            name
            email
            age
          }
        }
      GQL
    end

    it 'returns user data' do
      result = execute_graphql(
        query: query,
        variables: { id: user.id }
      )

      data = result[:data][:user]

      expect(data[:id]).to eq(user.id.to_s)
      expect(data[:name]).to eq(user.name)
      expect(data[:email]).to eq(user.email)
      expect(data[:age]).to eq(user.age)
    end
  end

  # describe "query: users" do
  #   let(:query) do
  #     <<~GQL
  #       query {
  #         users {
  #           id
  #           name
  #           email
  #           age
  #         }
  #       }
  #     GQL
  #   end
  #   it "returns users data" do
  #     users = create_list(:user, 3)
  #
  #     result = execute_graphql(
  #       query: query
  #     )
  #
  #     data = result[:data][:users][:items]
  #     expect(data.size).to eq(3)
  #   end
  #
  # end
end
