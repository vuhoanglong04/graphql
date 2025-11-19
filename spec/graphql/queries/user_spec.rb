require "rails_helper"

RSpec.describe "GraphQL Query: user", type: :request do
  let(:user) { create(:user) }


  let(:query) do
    <<~GQL
      query GetUser($id: ID!) {
        user(id: $id) {
          id
          name
          email
          age
        }
      }
    GQL
  end

  it "returns user data" do
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
