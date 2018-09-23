Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :createGenre, function: Resolvers::CreateGenre.new
end