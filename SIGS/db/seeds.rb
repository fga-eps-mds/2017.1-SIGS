# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Departaments
department = Department.create(code: '789', name: 'Engenharia')
department_1 = Department.create(code: '781', name: 'PRC')

# Courses
course = Course.create(code: '10', name: 'Engenharia de Software', department: department)
course = Course.create(code: '12', name: 'Engenharia Eletrônica', department: department)

# Users - Coordinator
user_1 = User.create(name: 'Caio Filipe', email: 'caio@unb.br', cpf: '05012345678', registration: '1234567', active: true, password: '123456')
coordinator = Coordinator.create(user: user_1, course: course)
user_2 = User.create(name: 'João Busche', email: 'joao@unb.br', cpf: '05044448888', registration: '1234544', active: false, password: '123456')
coordinator = Coordinator.create(user: user_2, course: course)

# Users - DepartmentAssistant
user_3 = User.create(name: 'João Pedro', email: 'pedro@unb.br', cpf: '05012349999', registration: '1234599', active: true, password: '123456')
department_assistant = DepartmentAssistant.create(user: user_3, department: department)
user_4 = User.create(name: 'Ateldy Brasil', email: 'ateldy@unb.br', cpf: '05022446688', registration: '1234333', active: false, password: '123456')
department_assistant = DepartmentAssistant.create(user: user_4, department: department)

# Users - AdministrativeAssistant
user_5 = User.create(name: 'Wallacy Braz', email: 'wallacy@unb.br', cpf: '05012348888', registration: '1234588', active: true, password: '123456')
administrative_assistant = AdministrativeAssistant.create(user: user_5)
user_6 = User.create(name: 'Carlos Aragon', email: 'carlos@unb.br', cpf: '05022248811', registration: '2224588', active: false, password: '123456')
administrative_assistant = AdministrativeAssistant.create(user: user_6)

# Buildings
buildings = Building.create([
  {code: 'pjc', name: 'Pavilhão João Calmon', wing: 'Norte'},
  {code: 'PAT', name: 'Pavilhão Anísio Teixeira', wing: 'norte'},
  {code: 'BSAS', name: 'Bloco de Salas da Ala Sul', wing: 'sul'},
  {code: 'BSAN', name: 'Bloco de Salas da Ala Norte', wing: 'norte'}
  ])

# Rooms
room_1 = Room.create(code: '124325', name: 'S10', capacity: 50, active: true, time_grid_id: 1, department: department, building: buildings[1])
room_2 = Room.create(code: '987653', name: 'SS', capacity: 40, active: false, time_grid_id: 2, department: department, building: buildings[2])
room_3 = Room.create(code: '987655', name: 'S9', capacity: 40, active: false, time_grid_id: 2, department: department_1, building: buildings[2])


# Disciplines
discipline = Discipline.create(code: '876', name: 'Cálculo 3', department_id: 1)
discipline_2 = Discipline.create(code: '777', name: 'Cálculo 2', department_id: 1)
discipline_3 = Discipline.create(code: '773', name: 'Cálculo 1', department_id: 1)

#SchoolRooms
school_room = SchoolRoom.create(name:"A",active:true, capacity: 50, discipline: discipline)
school_room2 = SchoolRoom.create(name:"B",active:true, capacity: 35, discipline: discipline)

#Categoris
category = Category.create(name: 'Retroprojetor')
category = Category.create(name: 'Laboratório Químico')

# Periods
period_1 = Period.create(period_type:'Alocação', initial_date: DateTime.strptime('10-01-2018 00:00', '%d-%m-%Y %H:%M'), final_date: DateTime.strptime('01-02-2018 18:00', '%d-%m-%Y %H:%M'))
period_2 = Period.create(period_type:'Ajuste', initial_date: DateTime.strptime('23-02-2018 00:00', '%d-%m-%Y %H:%M'), final_date: DateTime.strptime('01-03-2018 16:32', '%d-%m-%Y %H:%M'))
period_3 = Period.create(period_type:'Letivo', initial_date: DateTime.strptime('08-03-2018 00:00', '%d-%m-%Y %H:%M'), final_date: DateTime.strptime('14-07-2018 23:59', '%d-%m-%Y %H:%M'))
