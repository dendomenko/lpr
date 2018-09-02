# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

%w[
  Action
  Adventure
  Animation
  Biography
  Comedy
  Crime
  Documentary
  Drama
  Family
  Fantasy
  Film
  Noir
  History
  Horror
  Music
  Musical
  Mystery
  Romance
  Sci-Fi
  Short
  Sport
  Superhero
  Thriller
  War
  Western
].each do |title|
  Genre.create(title: title)
end


Movie.create([{ title: 'Star Wars', description: 'Lorem ipsum', year: Date.new(2003) }, { title: 'Lord of the Rings', description: 'Lorem ipsum', year: Date.new(2003) }, { title: 'Psycho', description: 'Lorem ipsum', year: Date.new(2003) }, { title: 'It', description: 'Lorem ipsum', year: Date.new(2003) }])
