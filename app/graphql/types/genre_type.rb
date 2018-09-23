Types::GenreType = GraphQL::ObjectType.define do
  name 'Genre'
  
  field :id, !types.ID
  field :title, !types.String
end