require 'rails_helper'

RSpec.describe AllocationsController, type: :controller do
  describe 'Allocation new,create and destroy methods' do
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
      @school_room = SchoolRoom.create(name:'A', active:true, discipline: @discipline, vacancies: 40, course_ids: [@course.id])
      @school_room2 = SchoolRoom.create(name:'B', active:true, discipline: @discipline, vacancies: 40, course_ids: [@course.id])
      @school_room3 = SchoolRoom.create(name:'C', active:true, discipline: @discipline2, vacancies: 40, course_ids: [@course.id])
      @school_room4 = SchoolRoom.create(name:'D', active:true, discipline: @discipline, vacancies: 10, course_ids: [@course.id])
      @school_room5 = SchoolRoom.create(name:'E', active:true, discipline: @discipline, vacancies: 20, course_ids: [@course.id])
      @period = Period.create(period_type:'Letivo', initial_date: '08-03-2018', final_date: '14-07-2018')
    end


    # New
    it 'should return new view' do
      get  :new
      expect(response).to have_http_status(200)
    end

    it 'should return a new catogory' do
      sign_in(@user)
      get :new
      expect(@allocation).to be_nil
    end

    # Create

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

    it "should not create an allocation with invalid shift" do
      sign_in(@user)
      post :create, params: {allocation: {user_id:@user.id,room_id:@room.id,school_room_id:@school_room.id, day:"segunda",start_time:"18:00",final_time:"19:00"}}
      expect(response).to redirect_to(allocations_new_path)
      expect(flash[:error]).to eq('Horário inválido')
    end

    it "should not create an allocation if already exists an allocation with the same time and different discipline" do
      sign_in(@user)
      @allocation = Allocation.create(user_id:@user.id,room_id:@room.id,school_room_id:@school_room3.id, day:"Quinta",start_time:"12:00",final_time:"14:00")
      post :create, params: {allocation: {user_id:@user.id,room_id:@room.id,school_room_id:@school_room.id, day:"Quinta",start_time:"12:00",final_time:"14:00"}}
      expect(response).to redirect_to(allocations_new_path)
      expect(flash[:error]).to eq('Alocação com horário não vago ou capacidade da sala cheia')
    end

    it "should not create an allocation if already exists an allocation with the same time and school_room" do
      sign_in(@user)
      @allocation = Allocation.create(user_id:@user.id,room_id:@room.id,school_room_id:@school_room.id, day:"Segunda",start_time:"12:00",final_time:"14:00")
      post :create, params: {allocation: {user_id:@user.id,room_id:@room.id,school_room_id:@school_room.id, day:"Segunda",start_time:"12:00",final_time:"14:00"}}
      expect(response).to redirect_to(allocations_new_path)
      expect(flash[:error]).to eq('Alocação com horário não vago ou capacidade da sala cheia')
    end

    it "should not create an allocation if already exists an allocation
    with the same time,discipline and different school_room and capacity of room is above the permitted" do
      sign_in(@user)
      @allocation = Allocation.create(user_id:@user.id,room_id:@room.id,school_room_id:@school_room.id, day:"Quarta",start_time:"12:00",final_time:"14:00")
      post :create, params: {allocation: {user_id:@user.id,room_id:@room.id,school_room_id:@school_room2.id, day:"Quarta",start_time:"12:00",final_time:"14:00"}}
      expect(response).to redirect_to(allocations_new_path)
      expect(flash[:error]).to eq('Alocação com horário não vago ou capacidade da sala cheia')
    end

    it "should create an allocation if already exists an allocation with the same time and discipline and different school_room" do
      sign_in(@user)
      @allocation = Allocation.create(user_id:@user.id,room_id:@room.id,school_room_id:@school_room4.id, day:"Terça",start_time:"12:00",final_time:"14:00")
      post :create, params: {allocation: {user_id:@user.id,room_id:@room.id,school_room_id:@school_room5.id, day:"Terça",start_time:"12:00",final_time:"14:00"}}
      expect(response).to redirect_to(allocations_new_path)
      expect(flash[:success]).to eq('Alocação feita com sucesso')
    end


    it "test create allocation with day friday" do
      sign_in(@user)
      post :create, params: {allocation: {user_id:@user.id,room_id:@room.id,school_room_id:@school_room5.id, day:"Sexta",start_time:"12:00",final_time:"14:00"}}
      expect(flash[:success]).to eq('Alocação feita com sucesso')
    end

    it "test create allocation with day Saturday" do
      sign_in(@user)
      post :create, params: {allocation: {user_id:@user.id,room_id:@room.id,school_room_id:@school_room5.id, day:"Sabado",start_time:"12:00",final_time:"14:00"}}
      expect(flash[:success]).to eq('Alocação feita com sucesso')
    end

    it "test create allocation with day Monday" do
      sign_in(@user)
      post :create, params: {allocation: {user_id:@user.id,room_id:@room.id,school_room_id:@school_room5.id, day:"Segunda",start_time:"12:00",final_time:"14:00"}}
      expect(flash[:success]).to eq('Alocação feita com sucesso')
    end

    it "test create allocation with day Wednesday" do
      sign_in(@user)
      post :create, params: {allocation: {user_id:@user.id,room_id:@room.id,school_room_id:@school_room5.id, day:"Quarta",start_time:"12:00",final_time:"14:00"}}
      expect(flash[:success]).to eq('Alocação feita com sucesso')
    end

    it "test create allocation with day Thursday" do
      sign_in(@user)
      post :create, params: {allocation: {user_id:@user.id,room_id:@room.id,school_room_id:@school_room5.id, day:"Quinta",start_time:"12:00",final_time:"14:00"}}
      expect(flash[:success]).to eq('Alocação feita com sucesso')
    end











    # Destroy

    it "should destroy an allocation" do
      sign_in(@user)
      @allocation = Allocation.create(user_id:@user.id,room_id:@room.id,school_room_id:@school_room4.id, day:"Segunda",start_time:"12:00",final_time:"14:00")
      get :destroy, params: {id:@allocation.id}
      expect(response).to redirect_to(current_user)
      expect(flash[:success]).to eq('Alocação excluída com sucesso')
    end








  end
end
