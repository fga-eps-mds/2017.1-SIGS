# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Departaments
department = Department.create(code: '789', name: 'Engenharia', wing: 'SUL')
department_2 = Department.create(code: '781', name: 'PRC', wing: 'SUL')
department_3 = Department.create(code: '156', name: 'Artes', wing: 'NORTE')

# Courses
course = Course.create(code: '10', name: 'Engenharia de Software', department: department, shift: 1)
course_2 = Course.create(code: '12', name: 'Engenharia Eletrônica', department: department, shift: 1)
course_3 = Course.create(code: '12', name: 'Engenharia Automotiva', department: department, shift: 2)
course_4 = Course.create(code: '09', name: 'Artes Visuais', department: department_3, shift: 2)

# Users - Coordinator
user_1 = User.create(name: 'Caio Filipe', email: 'caio@unb.br', cpf: '05012345678', registration: '1234567', active: true, password: '123456')
coordinator = Coordinator.create(user: user_1, course: course_2)
user_2 = User.create(name: 'João Busche', email: 'joao@unb.br', cpf: '05044448888', registration: '1234544', active: false, password: '123456')
coordinator_2 = Coordinator.create(user: user_2, course: course_4)

# Users - Deg
user_3 = User.create(name: 'João Pedro', email: 'pedro@unb.br', cpf: '05012349999', registration: '1234599', active: true, password: '123456')
department_assistant = Deg.create(user: user_3)
user_4 = User.create(name: 'Ateldy Brasil', email: 'ateldy@unb.br', cpf: '05022446688', registration: '1234333', active: false, password: '123456')
department_assistant_2 = Deg.create(user: user_4)

# Users - AdministrativeAssistant
user_5 = User.create(name: 'Wallacy Braz', email: 'wallacy@unb.br', cpf: '05012348888', registration: '1234588', active: true, password: '123456')
administrative_assistant = AdministrativeAssistant.create(user: user_5)
user_6 = User.create(name: 'Carlos Aragon', email: 'carlos@unb.br', cpf: '05022248811', registration: '2224588', active: false, password: '123456')
administrative_assistant_2 = AdministrativeAssistant.create(user: user_6)

# Buildings
buildings = Building.create([
  {code: 'pjc', name: 'Pavilhão João Calmon', wing: 'NORTE'},
  {code: 'PAT', name: 'Pavilhão Anísio Teixeira', wing: 'NORTE'},
  {code: 'BSAS', name: 'Bloco de Salas da Ala Sul', wing: 'SUL'},
  {code: 'BSAN', name: 'Bloco de Salas da Ala Norte', wing: 'NORTE'}
  ])

# Categories
category = Category.create(name: 'Laboratório Químico')
category_2 = Category.create(name: 'Retroprojetor')

# Rooms
room_1 = Room.create(code: '124325', name: 'S10', capacity: 50, active: true, time_grid_id: 1, department: department_3, building: buildings[1], category_ids: [category.id])
room_2 = Room.create(code: '987653', name: 'SS', capacity: 40, active: false, time_grid_id: 2, department: department, building: buildings[2], category_ids: [category.id])
room_3 = Room.create(code: '987655', name: 'S9', capacity: 40, active: false, time_grid_id: 2, department: department_2, building: buildings[2], category_ids: [category.id])
room_4 = Room.create(code: '987654', name: 'S8', capacity: 80, active: true, time_grid_id: 1, department: department, building: buildings[1], category_ids: [category.id])
room_5 = Room.create(code: '987624', name: 'S1', capacity: 80, active: true, time_grid_id: 1, department: department_2, building: buildings[2], category_ids: [category.id])
room_6 = Room.create(code: '987644', name: 'S2', capacity: 80, active: true, time_grid_id: 1, department: department_2, building: buildings[2], category_ids: [category.id])

# Disciplines
discipline = Discipline.create(code: '876', name: 'Cálculo 3', department: department)
discipline_2 = Discipline.create(code: '777', name: 'Cálculo 2', department: department)
discipline_3 = Discipline.create(code: '773', name: 'Cálculo 1', department: department)
discipline_4 = Discipline.create(code: '774', name: 'Artes Visuais', department: department_3)

#SchoolRooms

school_room = SchoolRoom.create(name:'A', discipline: discipline, vacancies: 40, courses: [course_2])
school_room_2 = SchoolRoom.create(name:'B', discipline: discipline, vacancies: 60, courses: [course_3])
school_room_3 = SchoolRoom.create(name:'C', discipline: discipline_3, vacancies: 35, courses: [course_3])
school_room_4 = SchoolRoom.create(name:'D', discipline: discipline, vacancies: 40, courses: [course_2])

# Periods
period = Period.create(period_type:'Alocação', initial_date: '10-01-2018', final_date: '01-02-2018')
period_2 = Period.create(period_type:'Ajuste', initial_date: '23-02-2018', final_date: '01-03-2018')
period_3 = Period.create(period_type:'Letivo', initial_date: '08-03-2018', final_date: '14-07-2018')

# Allocations
allocation1 = Allocation.create(user_id: user_1.id,room_id: room_1.id, school_room_id: school_room_2.id, day: "Segunda", start_time: '12:00:00', final_time: '14:00:00')
allocation2 = Allocation.create(user_id: user_1.id,room_id: room_2.id, school_room_id: school_room_2.id, day: "Quarta", start_time: '12:00:00', final_time: '14:00:00')
allocation3 = Allocation.create(user_id: user_1.id,room_id: room_2.id, school_room_id: school_room_2.id, day: "Sexta", start_time: '12:00:00', final_time: '14:00:00')
allocation4 = Allocation.create(user_id: user_1.id,room_id: room_2.id, school_room_id: school_room_3.id, day: "Segunda", start_time: '12:00:00', final_time: '14:00:00')
allocation5 = Allocation.create(user_id: user_1.id,room_id: room_2.id, school_room_id: school_room_3.id, day: "Quarta", start_time: '12:00:00', final_time: '14:00:00')
allocation6 = Allocation.create(user_id: user_1.id,room_id: room_2.id, school_room_id: school_room_3.id, day: "Sexta", start_time: '12:00:00', final_time: '14:00:00')
allocation7 = Allocation.create(user_id: user_1.id,room_id: room_2.id, school_room_id: school_room_4.id, day: "Segunda", start_time: '12:00:00', final_time: '14:00:00')
allocation8 = Allocation.create(user_id: user_1.id,room_id: room_2.id, school_room_id: school_room_4.id, day: "Quarta", start_time: '12:00:00', final_time: '14:00:00')
allocation9 = Allocation.create(user_id: user_1.id,room_id: room_2.id, school_room_id: school_room_4.id, day: "Sexta", start_time: '12:00:00', final_time: '14:00:00')
