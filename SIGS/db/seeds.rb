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
user = User.create(name: 'Caio Filipe', email: 'caio@unb.br', cpf: '05012345678', registration: '1234567', active: 1, password: '123456')
coordinator = Coordinator.create(user: user, course: course_2)
user_2 = User.create(name: 'João Busche', email: 'joao@unb.br', cpf: '05044448888', registration: '1234544', active: 0, password: '123456')
coordinator_2 = Coordinator.create(user: user_2, course: course_4)

# Users - Deg
user_3 = User.create(name: 'João Pedro', email: 'pedro@unb.br', cpf: '05012349999', registration: '1234599', active: 1, password: '123456')
department_assistant = Deg.create(user: user_3)
user_4 = User.create(name: 'Ateldy Brasil', email: 'ateldy@unb.br', cpf: '05022446688', registration: '1234333', active: 0, password: '123456')
department_assistant_2 = Deg.create(user: user_4)

# Users - AdministrativeAssistant
user_5 = User.create(name: 'Wallacy Braz', email: 'wallacy@unb.br', cpf: '05012348888', registration: '1234588', active: 1, password: '123456')
administrative_assistant = AdministrativeAssistant.create(user: user_5)
user_6 = User.create(name: 'Carlos Aragon', email: 'carlos@unb.br', cpf: '05022248811', registration: '2224588', active: 0, password: '123456')
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
room = Room.create(code: '124325', name: 'S10', capacity: 50, active: true, time_grid_id: 1, department: department_3, building: buildings[1], category_ids: [category.id])
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
school_room_5 = SchoolRoom.create(name:'AA', discipline: discipline_4, vacancies: 40, course_ids: [course_4.id])
school_room_6 = SchoolRoom.create(name:'BB', discipline: discipline_4, vacancies: 40, course_ids: [course_4.id])

# Periods
period = Period.create(period_type:'Alocação', initial_date: '10-01-2018', final_date: '01-02-2018')
period_2 = Period.create(period_type:'Ajuste', initial_date: '23-02-2018', final_date: '01-03-2018')
period_3 = Period.create(period_type:'Letivo', initial_date: '08-03-2018', final_date: '14-07-2018')

# Allocations
allocation = Allocation.create(user_id: user.id, room_id: room.id, school_room_id: school_room_2.id, day: "Segunda", start_time: '14:00:00', final_time: '16:00:00')
allocation_2 = Allocation.create(user_id: user.id, room_id: room_2.id, school_room_id: school_room_2.id, day: "Quarta", start_time: '14:00:00', final_time: '16:00:00')
allocation_3 = Allocation.create(user_id: user.id, room_id: room_2.id, school_room_id: school_room_2.id, day: "Sexta", start_time: '14:00:00', final_time: '16:00:00')
allocation_4 = Allocation.create(user_id: user.id, room_id: room_2.id, school_room_id: school_room_3.id, day: "Segunda", start_time: '08:00:00', final_time: '10:00:00')
allocation_5 = Allocation.create(user_id: user.id, room_id: room_2.id, school_room_id: school_room_3.id, day: "Quarta", start_time: '08:00:00', final_time: '10:00:00')
allocation_6 = Allocation.create(user_id: user.id, room_id: room_2.id, school_room_id: school_room_3.id, day: "Sexta", start_time: '08:00:00', final_time: '10:00:00')
allocation_7 = Allocation.create(user_id: user.id, room_id: room_2.id, school_room_id: school_room_4.id, day: "Segunda", start_time: '10:00:00', final_time: '12:00:00')
allocation_8 = Allocation.create(user_id: user.id, room_id: room_2.id, school_room_id: school_room_4.id, day: "Quarta", start_time: '10:00:00', final_time: '12:00:00')
allocation_9 = Allocation.create(user_id: user.id, room_id: room_2.id, school_room_id: school_room_4.id, day: "Sexta", start_time: '10:00:00', final_time: '12:00:00')
allocation_10 = Allocation.create(user_id: user.id, room_id: room_4.id, school_room_id: school_room_5.id, day: "Terça", start_time: '10:00:00', final_time: '12:00:00')
allocation_11 = Allocation.create(user_id: user.id, room_id: room_4.id, school_room_id: school_room_6.id, day: "Terça", start_time: '10:00:00', final_time: '12:00:00')
allocation_10 = Allocation.create(user_id: user.id, room_id: room_4.id, school_room_id: school_room_5.id, day: "Quinta", start_time: '10:00:00', final_time: '12:00:00')
allocation_11 = Allocation.create(user_id: user.id, room_id: room_4.id, school_room_id: school_room_6.id, day: "Sexta", start_time: '10:00:00', final_time: '12:00:00')
allocation_12 = Allocation.create(user_id: user.id, room_id: room_4.id, school_room_id: school_room_6.id, day: "Quarta", start_time: '14:00:00', final_time: '18:00:00')

# Extension Allocations
allocation_extension_1 = AllocationExtension.create(user_id: user.id, room_id: room.id, start_time: '18:00:00', final_time: '19:00:00', inicial_date: '06-07-2017', final_date: '06-07-2017', periodicity: "Quinzenal")

# Token and Secrets
SECRET ||= '$2a$10$reXHMgegkckEKlceQ.0S5u/L44tbhU46C8TCdSn8HOePlEvnGYTI.'
TOKEN ||= 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoiQW5hIFBhdWxhIENoYXZlcyIsImVtYWlsIjoiYW5hcGF1bGEuY2hhdmVzQGdtYWlsLmNvbSJ9.2ZOfSu2AbDH6EdIblImBG5ciVoXogLlXvUaWJAz17qc'
SECRET_2 ||= '$2a$10$F1DO6yDclNdFPvzg7KG51.1Gk9cNWGA3CRvp6.D1PWArKlsev7QMG'
TOKEN_2 ||= 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoiR3VzdGF2byBGcmVpcmUgT2xpdmVpcmEiLCJlbWFpbCI6ImZyZWlyZS5vbGl2ZWlyYUBob3RtYWlsLmNvbSJ9.vNfwaSxpdVosGsnaS06JWt9NtMoAkOqwnjWcIAnFCy4'
SECRET_3 ||= '$2a$10$OzJkJBid71H2SRlVxv71buTP2hHoDFe4dIqIV9QjWebYy222W4Uoa'
TOKEN_3 ||= 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoiTWF0aGV1cyBGcmFuY2lzY28gZG9zIFNhbnRvcyIsImVtYWlsIjoibWF0aGV1cy1mcmFuY2lzY29AeWFob28uY29tIn0.-z3L4M7C5-7JYNeKv_UrKaRhEVtdtsP5ho3w66Xl6PM'

# API Users
api_user = ApiUser.create(name: 'Ana Paula Chaves', email: 'anapaula.chaves@gmail.com', secret: SECRET, token: TOKEN, user: user_5)
api_user_2 = ApiUser.create(name: 'Gustavo Freire Oliveira', email: 'freire.oliveira@hotmail.com', secret: SECRET_2, token: TOKEN_2, user: user_5)
api_user_3 = ApiUser.create(name: 'Matheus Francisco dos Santos', email: 'matheus-francisco@yahoo.com', secret: SECRET_3, token: TOKEN_3, user: user)
