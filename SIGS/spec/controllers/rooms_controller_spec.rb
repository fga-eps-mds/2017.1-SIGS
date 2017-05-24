require 'rails_helper'

RSpec.describe RoomsController, type: :controller do

  describe 'Rooms controller methods' do
    before(:each) do
      @building = Building.create(code: 'ICC', name: 'ICC', wing: 'norte')

      @department = Department.create(code: '789', name: 'Engenharia')

      @room = Room.create(code: 'S10', name: 'Superior 10', capacity: 50,
       active: true, time_grid_id: 1, building: @building, department: @department)

      @user = User.create(name: 'joao silva', email: 'joaosilva@unb.br',
        password: '123456', registration:'1100061', cpf:'05601407380', active: true)

      @administrative_assistant = AdministrativeAssistant.create(user: @user)

      sign_in(@user)
    end

    it 'should return all room' do
      get :index
      expect(response).to have_http_status(200)
    end

    it 'should return edit room' do
      get :edit, params:{id: @room.id}
      expect(response).to have_http_status(200)
    end

    it 'should return one room' do
      get :show, params:{id: @room.id}
      expect(response).to have_http_status(200)
    end

    it 'should update room' do
      get :update, params:{id: @room.id, room: {code: 'S11ew0', name: 'Superior 10', capacity: 50,
       active: true, time_grid_id: 1, building_id: @building.id}}
      expect(flash.now[:success]).to eq('Dados da sala atualizados com sucesso')
    end

    it 'should not update room because code is nil' do
      get :update, params:{id: @room.id, room: {name: 'Novo Nome', code: ''}}
      expect(flash.now[:error]).to eq('Dados não foram atualizados')
    end

    it 'should not update room because code exists' do
      Room.create(code: 'S110', name: 'Superior 10', capacity: 50,
       active: true, time_grid_id: 1, department: @department, building: @building)
      get :update, params:{id: @room.id, room: {code: 'S110'}}
      expect(flash.now[:error]).to eq('Dados não foram atualizados')
    end

    it 'should not update room because name has one character' do
      get :update, params:{id: @room.id, room: {name: 'S'}}
      expect(flash.now[:error]).to eq('Dados não foram atualizados')
    end

    it 'should not update room because name is long' do
      get :update, params:{id: @room.id, room: {name: '012345678901234567890123456789012345678901234567890'}}
      expect(flash.now[:error]).to eq('Dados não foram atualizados')
    end

    it 'should not update room because capacity is less than 5' do
      get :update, params:{id: @room.id, room: {capacity: 2}}
      expect(flash.now[:error]).to eq('Dados não foram atualizados')
    end

    it 'should not update room because capacity is more than 500' do
      get :update, params:{id: @room.id, room: {capacity: 800}}
      expect(flash.now[:error]).to eq('Dados não foram atualizados')
    end

  end
end
