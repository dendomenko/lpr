Types::UserType = GraphQL::ObjectType.define do
    # this type is named `Link`
    name 'User'
  
    # it has the following fields
    field :id, !types.ID
    field :email, !types.String
end