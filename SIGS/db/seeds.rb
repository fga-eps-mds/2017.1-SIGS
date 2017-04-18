# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Departaments
department = Department.create(code: '789', name: 'Engenharia')

# Courses
course = Course.create(code: '10', name: 'Engenharia de Software', department: department)

# Users - Coordinator
user_1 = User.create(name: 'Caio Filipe', email: 'caio@unb.br', cpf: '05012345678', registration: '1234567', active: true, password: '123456')
coordinator = Coordinator.create(user: user_1, course: course, department_id: department.id)

# Users - DepartmentAssistant
user_2 = User.create(name: 'João Pedro', email: 'joao@unb.br', cpf: '05012349999', registration: '1234599', active: true, password: '123456')
department_assistant = DepartmentAssistant.create(user: user_2, department: department)

# Users - AdministrativeAssistant
user_3 = User.create(name: 'Wallacy Braz', email: 'wallacy@unb.br', cpf: '05012348888', registration: '1234588', active: true, password: '123456')
administrative_assistant = AdministrativeAssistant.create(user: user_3)
buildings = Building.create([
  {code: 'pjc', name: 'Pavilhão João Calmon', wing: 'Norte'},
  {code: 'PAT', name: 'Pavilhão Anísio Teixeira', wing: 'norte'},
  {code: 'BSAS', name: 'Bloco de Salas da Ala Sul', wing: 'sul'},
  {code: 'BSAN', name: 'Bloco de Salas da Ala Norte', wing: 'norte'},          
          ])

