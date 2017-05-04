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
coordinator = Coordinator.create(user: user_1, course: course)
user_2 = User.create(name: 'João Busche', email: 'joao@unb.br', cpf: '05044448888', registration: '1234544', active: false, password: '123456')
coordinator = Coordinator.create(user: user_2, course: course)

# Users - DepartmentAssistant
user_3 = User.create(name: 'João Pedro', email: 'joao@unb.br', cpf: '05012349999', registration: '1234599', active: true, password: '123456')
department_assistant = DepartmentAssistant.create(user: user_3, department: department)
user_4 = User.create(name: 'Ateldy Brasil', email: 'ateldy@unb.br', cpf: '05022446688', registration: '1234333', active: false, password: '123456')
department_assistant = DepartmentAssistant.create(user: user_4, department: department)

# Users - AdministrativeAssistant
user_5 = User.create(name: 'Wallacy Braz', email: 'wallacy@unb.br', cpf: '05012348888', registration: '1234588', active: true, password: '123456')
administrative_assistant = AdministrativeAssistant.create(user: user_5)
user_6 = User.create(name: 'Carlos Aragon', email: 'carlos@unb.br', cpf: '05022248811', registration: '2224588', active: false, password: '123456')
administrative_assistant = AdministrativeAssistant.create(user: user_6)

buildings = Building.create([
  {code: 'pjc', name: 'Pavilhão João Calmon', wing: 'Norte'},
  {code: 'PAT', name: 'Pavilhão Anísio Teixeira', wing: 'norte'},
  {code: 'BSAS', name: 'Bloco de Salas da Ala Sul', wing: 'sul'},
  {code: 'BSAN', name: 'Bloco de Salas da Ala Norte', wing: 'norte'},
          ])

# Disciplines
discipline = Discipline.create(code: '876', name: 'Cálculo 3', department_id: 1)
discipline_2 = Discipline.create(code: '777', name: 'Cálculo 2', department_id: 1)
