# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

buildings = Building.create([
  {code: 'pjc', name: 'Pavilhão João Calmon', wing: 'Norte'},
  {code: 'PAT', name: 'Pavilhão Anísio Teixeira', wing: 'norte'},
  {code: 'BSAS', name: 'Bloco de Salas da Ala Sul', wing: 'sul'},
  {code: 'BSAN', name: 'Bloco de Salas da Ala Norte', wing: 'norte'},          
          ])
