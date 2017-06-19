require 'rails_helper'

RSpec.describe Api::ApiSchoolRoomsController, type: :controller do
  describe 'Api SchoolRoom methods' do
    before(:each) do
      @department = Department.create(code: '789', name: 'Engenharia')
      @discipline = Discipline.create(code: '876', name: 'Cálculo 3', department: @department)
      @discipline2 = Discipline.create(code: '286', name: 'Cálculo 4', department: @department)
      @course = Course.create(code: '10', name: 'Engenharia de Software', department: @department, shift: 1)
      @building = Building.create(code: 'pjc', name: 'Pavilhão João Calmon', wing: 'Norte')
      @category = Category.create(name: 'Retroprojetor')
      @user = User.create(name: 'Caio Filipe', email: 'caio@unb.br', cpf: '05012345678', registration: '1234567', active: true, password: '123456')
      @coordinator = Coordinator.create(user_id: @user.id,course_id:@course.id)
      @room = Room.create(code: '124325', name: 'S10', capacity: 50, active: true, time_grid_id: 1, department: @department, building: @building, category_ids: [@category.id])
      @school_room = SchoolRoom.create(name:'A', discipline: @discipline, vacancies: 40, course_ids: [@course.id])
      @school_room2 = SchoolRoom.create(name:'B', discipline: @discipline, vacancies: 40, course_ids: [@course.id])
      @school_room3 = SchoolRoom.create(name:'C', discipline: @discipline2, vacancies: 40, course_ids: [@course.id])
      @school_room4 = SchoolRoom.create(name:'D', discipline: @discipline, vacancies: 10, course_ids: [@course.id])
      @school_room5 = SchoolRoom.create(name:'E', discipline: @discipline, vacancies: 20, course_ids: [@course.id])
      @period = Period.create(period_type:'Letivo', initial_date: '08-03-2018', final_date: '14-07-2018')
    end

    it 'should get json response' do
      sign_in(@user)
      get :index, :format => :json
      expect(response).to have_http_status(200)
    end

  end
end
