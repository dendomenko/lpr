Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  # queries are just represented as fields
  field :users, !types[Types::UserType] do
    # resolve would be called in order to fetch data for that field
    resolve -> (obj, args, ctx) { User.all }
  end

  field :genres, !types[Types::GenreType] do
    resolve -> (obj, args, ctx) { Genre.all }
  end
end
