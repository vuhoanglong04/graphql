module GraphqlHelpers
  def execute_graphql(query:, variables: {}, context: {})
    GraphqlSchema.execute(
      query,
      variables: variables,
      context: context
    ).deep_symbolize_keys
  end
end
