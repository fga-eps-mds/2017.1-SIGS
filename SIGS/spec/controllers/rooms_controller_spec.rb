require 'rails_helper'

RSpec.describe RoomsController, type: :controller do

  describe 'Rooms controller methods' do
    before(:each) do
      @building = Building.create(code: 'ICC', name: 'ICC', wing: 'norte')

      @department = Department.create(code: '789', name: 'Engenharia')

      @department_2 = Department.create(code: '749', name: 'PRC')

      @discipline = Discipline.create(code: '876', name: 'Cálculo 3', department: @department)

      @course = Course.create(name: 'Musica', department: @department)

      @category = Category.create(name: 'Laboratório Químico')

      @room = Room.create(code: 'S10', name: 'Superior 10', capacity: 50,
       active: true, time_grid_id: 1, building: @building, department: @department, category: [@category])

      @room_2 = Room.create(code: 'S9', name: 'Superior 9', capacity: 20,
       active: true, time_grid_id: 1, building: @building, department: @department_2, category: [@category])

      @user = User.create(name: 'joao silva', email: 'joaosilva@unb.br',
        password: '123456', registration:'1100061', cpf:'05601407380', active: true)

      @user_2 = User.create(name: 'joao silva', email: 'joaferrera@unb.br',
        password: '123456', registration:'1100069', cpf:'04601407380', active: true)

      @administrative_assistant = AdministrativeAssistant.create(user: @user)

      @school_room = SchoolRoom.create(name:'A', vacancies: 40, courses: [@course], discipline: @discipline)

      @coordinator = Coordinator.create(user: @user_2, course: @course)

      @allocation = Allocation.create(user: @user,room: @room, school_room: @school_room, day: "Segunda", start_time: '14:00:00', final_time: '16:00:00')
    end

    it 'should return all room prc' do
      sign_in(@user)
      get :index
      expect(response).to have_http_status(200)
    end

    it 'should return all room coordinator' do
      sign_in(@user_2)
      get :index
      expect(response).to have_http_status(200)
    end

    it 'should return edit room' do
      sign_in(@user)
      get :edit, params:{id: @room.id}
      expect(response).to have_http_status(200)
    end

    it 'should return one room' do
      sign_in(@user)
      get :show, params:{id: @room.id}
      expect(response).to have_http_status(200)
    end

    it 'should update room' do
      sign_in(@user)
      get :update, params:{id: @room.id, room: {code: 'S11ew0', name: 'Superior 10', capacity: 50,
       active: true, time_grid_id: 1, building_id: @building.id}}
      expect(flash.now[:success]).to eq('Dados da sala atualizados com sucesso')
    end

    it 'should not update room because code is nil' do
      sign_in(@user)
      get :update, params:{id: @room.id, room: {name: 'Novo Nome', code: ''}}
      expect(flash.now[:error]).to eq('Dados não foram atualizados')
    end
    it 'should not update room because code exists' do
      sign_in(@user)
      Room.create(code: 'S110', name: 'Superior 10', capacity: 50,
       active: true, time_grid_id: 1, department: @department, building: @building)
      get :update, params:{id: @room.id, room: {code: 'S110'}}
      expect(flash.now[:error]).to eq('Dados não foram atualizados')
    end

    it 'should not update room because name has one character' do
      sign_in(@user)
      get :update, params:{id: @room.id, room: {name: 'S'}}
      expect(flash.now[:error]).to eq('Dados não foram atualizados')
    end

    it 'should not update room because name is long' do
      sign_in(@user)
      get :update, params:{id: @room.id, room: {name: '012345678901234567890123456789012345678901234567890'}}
      expect(flash.now[:error]).to eq('Dados não foram atualizados')
    end

    it 'should not update room because capacity is less than 5' do
      sign_in(@user)
      get :update, params:{id: @room.id, room: {capacity: 2}}
      expect(flash.now[:error]).to eq('Dados não foram atualizados')
    end

    it 'should not update room because capacity is more than 500' do
      sign_in(@user)
      get :update, params:{id: @room.id, room: {capacity: 800}}
      expect(flash.now[:error]).to eq('Dados não foram atualizados')
    end

    it 'should delete the room from the database, by coordinator' do
      sign_in(@user)
      get :destroy, params:{id: @room_2.id}
      expect(flash[:success]).to eq('Sala excluida com sucesso')
      expect(response).to redirect_to(room_index_path)
    end

    it 'should delete the room from the database, by administrative assistant' do
      sign_in(@user_2)
      get :destroy, params:{id: @room.id}
      expect(flash[:success]).to eq('Sala excluida com sucesso')
      expect(response).to redirect_to(room_index_path)
    end

    it 'should not delete the room from the databasebecause the room belongs to another department' do
      sign_in(@user)
      get :destroy, params:{id: @room.id}
      expect(flash[:error]).to eq('Não possui permissão para excluir sala')
      expect(response).to redirect_to(room_index_path)
    end

    it 'should get json response' do
      sign_in(@user)
      get :json_of_categories_by_school_room, params: {school_room_id: @school_room.id}, :format => :json
      expect(response).to have_http_status(200)
    end

    it 'should filter by capacity' do
      get :index , params: {capacity: 25}
      rooms_report = [@room]
      expect(assigns[:rooms]).to eq(rooms_report)
    end

    it 'should filter by buildings' do
      get :index , params: {building_id: @building.id}
      buildings_report = [@room, @room_2]
      expect(assigns[:rooms]).to eq(buildings_report)
    end

    it 'should filter by wing' do
      get :index , params: {wing: @building.wing}
      buildings_report = [@room, @room_2]
      expect(assigns[:rooms]).to eq(buildings_report)
    end

    it 'should filter by name' do
      get :index , params: {name: @room.name}
      room_report = [@room]
      expect(assigns[:rooms]).to eq(room_report)
    end

    it 'should filter by code' do
      get :index , params: {code: @room.code}
      room_report = [@room]
      expect(assigns[:rooms]).to eq(room_report)
    end
  end
end
