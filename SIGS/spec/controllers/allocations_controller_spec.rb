require 'rails_helper'

RSpec.describe AllocationsController, type: :controller do
  describe 'Allocation new and create methods' do
    before(:each) do
      @department = Department.create(code: '789', name: 'Engenharia')
      @discipline = Discipline.create(code: '876', name: 'Cálculo 3', department: @department)
      @course = Course.create(code: '10', name: 'Engenharia de Software', department: @department, shift: 1)
      @building = Building.create(code: 'pjc', name: 'Pavilhão João Calmon', wing: 'Norte')
      @category = Category.create(name: 'Retroprojetor')
      @user = User.create(name: 'Caio Filipe', email: 'caio@unb.br', cpf: '05012345678', registration: '1234567', active: true, password: '123456')
      @room = Room.create(code: '124325', name: 'S10', capacity: 50, active: true, time_grid_id: 1, department: @department, building: @building, category_ids: [@category.id])
      @school_room = SchoolRoom.create(name:'A', active:true, discipline: @discipline, vacancies: 40, course_ids: [@course.id])
      @period = Period.create(period_type:'Letivo', initial_date: '08-03-2018', final_date: '14-07-2018')
    end


    it 'should return new view' do
      get  :new
      expect(response).to have_http_status(200)
    end

    it 'should create a new allocation' do
      sign_in(@user)
      post :create, params: {allocation: {user_id:@user.id,room_id:@room.id,school_room_id:@school_room.id, day:"segunda",start_time:"12:00",final_time:"14:00"}}
      expect(response).to redirect_to(allocations_new_path)
      expect(flash[:success]).to eq('Alocação feita com sucesso')
    end


    it "shouldn't create an allocation without some arguments" do
      sign_in(@user)
      post :create, params: {allocation: {user_id:@user.id,school_room_id:@school_room.id, day:"segunda",start_time:"12:00",final_time:"14:00"}}
      expect(response).to redirect_to(allocations_new_path)
      expect(flash[:error]).to eq('Falha ao realizar alocação')
    end

    it 'should not create an allocation with invalid time' do
      sign_in(@user)
      post :create, params: {allocation: {user_id:@user.id,room_id:@room.id,school_room_id:@school_room.id, day:"segunda",start_time:"12:00",final_time:"12:00"}}
      expect(response).to redirect_to(allocations_new_path)
      expect(flash[:error]).to eq('Horário inválido')
    end

    it "shoud not create an alloaction with invalid shift" do
      sign_in(@user)
      post :create, params: {allocation: {user_id:@user.id,room_id:@room.id,school_room_id:@school_room.id, day:"segunda",start_time:"18:00",final_time:"19:00"}}
      expect(response).to redirect_to(allocations_new_path)
      expect(flash[:error]).to eq('Horário inválido')
    end




  end


end
