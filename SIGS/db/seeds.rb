# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ======= Departament =========
department_1 = Department.new
department_1.code = '789'
department_1.name = 'Engenharia'
department_1.save!

# ========= Courses ===============
course_1 = Course.new
course_1.code = '10'
course_1.name = 'Engenharia de Software'
course_1.department_id = department_1.id
course_1.save!

# ========== User - Coordinator ==============
user_1 = User.new
user_1.name = 'Caio Filipe'
user_1.email = 'caio@unb.br'
user_1.password = '123456'
user_1.cpf = '05012345678'
user_1.registration = '1234567'
user_1.save!

coordinator_1 = Coordinator.new
coordinator_1.user_id = user_1.id
coordinator_1.course_id = course_1.id
coordinator_1.department_id = department_1.id
coordinator_1.save!

# ========== User - DepartmentAssistant =================
user_1 = User.new
user_1.name = 'João Pedro'
user_1.email = 'joao@unb.br'
user_1.password = '123456'
user_1.cpf = '05012349999'
user_1.registration = '1234599'
user_1.save!

department_assistant_1 = DepartmentAssistant.new
department_assistant_1.user_id = user_1.id
department_assistant_1.department_id = department_1.id
department_assistant_1.save!

# ========== User - AdministrativeAssistant =================
user_1 = User.new
user_1.name = 'Wallacy Braz'
user_1.email = 'wallacy@unb.br'
user_1.password = '123456'
user_1.cpf = '05012348888'
user_1.registration = '1234588'
user_1.save!

administrative_assistant_1 = AdministrativeAssistant.new
administrative_assistant_1.user_id = user_1.id
administrative_assistant_1.save!
