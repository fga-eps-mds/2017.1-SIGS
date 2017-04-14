# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ======= Departament =========
department_1 = Department.new
department_1.name = 'Engenharia'
department_1.save!

# ========= Courses ===============
course_1 = Course.new
course_1.code = '10'
course_1.name = 'Engenharia de Software'
course_1.department_id = department_1.id
course_1.save!

# ========== Users ==============
user_1 = User.new
user_1.name = 'Caio'
user_1.email = 'caio@gmail.com'
user_1.password = '12345'
user_1.cpf = '111-111-111.11'
user_1.registration = 'matricula1'
user_1.save!

# ========== Coordinator =================
coordinator_1 = Coordinator.new
coordinator_1.department_id = department_1.id
coordinator_1.course_id = course_1.id
coordinator_1.user_id = user_1.id
coordinator_1.save!
