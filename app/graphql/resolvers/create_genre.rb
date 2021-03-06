class Resolvers::CreateGenre < GraphQL::Function
    # arguments passed as "args"
    argument :title, !types.String
  
    # return type from the mutation
    type Types::GenreType
  
    # the mutation method
    # _obj - is parent object, which in this case is nil
    # args - are the arguments passed
    # _ctx - is the GraphQL context (which would be discussed later)
    def call(_obj, args, _ctx)
      Genre.create!(
        title: args[:title]
      )
    end
  end