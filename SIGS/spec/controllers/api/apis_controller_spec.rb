require 'rails_helper'
require 'json'

RSpec.describe Api::ApisController, type: :controller do
	describe 'Test methods of API Controller' do
		before(:each) do
			@user = User.create(name: 'Caio Filipe', email: 'caio@unb.br', cpf: '05012345678', registration: '1234567', active: true, password: '123456')
			SECRET ||= '$2a$10$reXHMgegkckEKlceQ.0S5u/L44tbhU46C8TCdSn8HOePlEvnGYTI.'
			TOKEN ||= 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoiQW5hIFBhdWxhIENoYXZlcyIsImVtYWlsIjoiYW5hcGF1bGEuY2hhdmVzQGdtYWlsLmNvbSJ9.2ZOfSu2AbDH6EdIblImBG5ciVoXogLlXvUaWJAz17qc'
			TOKEN_2 ||= 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoiR3VzdGF2byBGcmVpcmUgT2xpdmVpcmEiLCJlbWFpbCI6ImZyZWlyZS5vbGl2ZWlyYUBob3RtYWlsLmNvbSJ9.vNfwaSxpdVosGsnaS06JWt9NtMoAkOqwnjWcIAnFCy4'
			@api_user = ApiUser.create(name: 'Ana Paula Chaves', email: 'anapaula.chaves@gmail.com', secret: SECRET, token: TOKEN, user: @user)
			@department = Department.create(code: '789', name: 'Engenharia', wing: 'SUL')
			@category = Category.create(name: 'Laboratório Químico')
			@building = Building.create(code: 'pjc', name: 'Pavilhão João Calmon', wing: 'NORTE')
			@room = Room.create(code: '124325', name: 'S10', capacity: 50, active: true, time_grid_id: 1, department: @department, building: @building, category_ids: [@category.id])
			@room2 = Room.create(code: '124325', name: 'S9', capacity: 50, active: true, time_grid_id: 1, department: @department, building: @building, category_ids: [@category.id])
			@course_2 = Course.create(code: '12', name: 'Engenharia Eletrônica', department: @department, shift: 1)
			@discipline = Discipline.create(code: '876', name: 'Cálculo 3', department: @department)
			@school_room = SchoolRoom.create(name:'A', discipline: @discipline, vacancies: 40, courses: [@course_2])
			@school_room2 = SchoolRoom.create(name:'B', discipline: @discipline, vacancies: 40, courses: [@course_2])
			@allocation = Allocation.create(user_id: @user.id, room_id: @room.id, school_room_id: @school_room.id, day: "Segunda", start_time: '14:00:00', final_time: '16:00:00', active: true)
			@allocation2 = Allocation.create(user_id: @user.id, room_id: @room2.id, school_room_id: @school_room2.id, day: "Segunda", start_time: '14:00:00', final_time: '16:00:00', active: true)
			@request.env['HTTP_ACCEPT'] = 'application/vnd.api+json'
			@request.env['HTTP_AUTHORIZATION'] = 'Token ' + @api_user.token
		end

		it 'should return the all rooms json' do
			get :all_rooms, params: { default: { format: :json } }
			expect(response).to have_http_status(200)
			expect(JSON.parse(response.body)) == @room.to_json
		end

		it 'should return HTTP Token denied' do
			@request.env['HTTP_ACCEPT'] = 'application/vnd.api+json'
			@request.env['HTTP_AUTHORIZATION'] = 'Token ' + TOKEN_2
			get :all_rooms, params: { default: { format: :json } }
			expect(response).to have_http_status(401)
		end

		it 'should get json response all scholl_rooms' do
		  get :all_school_rooms, params: { default: { format: :json } }
		  expect(response).to have_http_status(200)
		end

		it 'should get json response school_rooms_of_room' do
			get :school_rooms_of_room, params: { code: '124325', default: { format: :json } }
			expect(response).to have_http_status(200)
		end

		it 'should get allocations of school_room' do
			get :school_rooms_of_room, params: { code: '124325', default: { format: :json } }
			teste = [@allocation, @allocation2]
			expect(JSON.parse(response.body)) == teste.to_json
		end


	end
end
