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

		it 'should get json response' do
		  get :all_school_rooms, params: { default: { format: :json } }
		  expect(response).to have_http_status(200)
		end

	end
end
