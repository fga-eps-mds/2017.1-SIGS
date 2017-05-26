require 'rails_helper'
include SessionsHelper

RSpec.describe SchoolRoomsController, type: :controller do

  describe 'SchoolRooms methods' do

    before(:each) do
      @user = User.create(name: 'joao silva', email: 'joaosilva@unb.br',
        password: '123456', registration:'1100061', cpf:'05601407380', active: true)
      @department = Department.create(name: 'Departamento de Matemática', code: '007')
      @course = Course.create(name:'Matemática', code: '009', department: @department)
      @discipline1 = Discipline.create(name: 'Análise Combinatória', code: '123', department: @department)
      @discipline2 = Discipline.create(name: 'Fisica 1', code: '193', department: @department)
      @coordinator = Coordinator.create(user: @user, course: @course)
      @school_room = SchoolRoom.create(name:"YY", capacity: 50, discipline: @discipline1)
    end

    it 'should return new' do
      sign_in(@user)
      post :new
      expect(response).to have_http_status(200)
    end

    it 'should create a new school room' do
      sign_in(@user)
      post :create, params:{school_room: {name: 'AA', discipline_id: @discipline1.id, course: @course.id}}
      expect(flash[:success]).to eq('Turma criada')
      expect(SchoolRoom.count).to be(2)
    end

    it 'should create school room with null name' do
      sign_in(@user)
      post :create, params:{school_room: {name: '', discipline_id: @discipline1.id, course: @course.id}}
      expect(flash[:error]).to eq('Indique o nome da turma')
    end

    it 'should create school room with existent name' do
      sign_in(@user)
      post :create, params:{school_room: {name: 'AA', discipline_id: @discipline1.id, course: @course.id}}
      post :create, params:{school_room: {name: 'AA', discipline_id: @discipline1.id, course: @course.id}}
      expect(flash[:error]).to eq('Já existe uma turma com esse nome')
    end

    it 'should create school room force to fail' do
      sign_in(@user)
      post :create, params:{school_room: {name: 'AA', discipline_id: '', course: @course.id}}
      expect(flash[:error]).to eq('Falha ao criar')
    end
    

    it 'returns http success' do
      sign_in(@user)
      post :create, params:{school_room: {name: 'AA', discipline_id: @discipline1.id, course: @course.id}}
      get :edit, params:{id: SchoolRoom.last.id}
      expect(response).to have_http_status(200)
    end

    it 'should update with valid data' do
      sign_in(@user)
      school_room = SchoolRoom.create(name: 'AA',capacity: 50, discipline_id: @discipline1.id)
      get :update, params:{id: school_room.id, school_room:{discipline_id: @discipline2.id}}
      expect(SchoolRoom.find(school_room.id).discipline_id).to eq(@discipline2.id)
    end  

    it 'should update with force error' do
      sign_in(@user)
      school_room = SchoolRoom.create(name: 'AA',capacity: 50, discipline_id: @discipline1.id)
      get :update, params:{id: school_room.id, school_room:{discipline_id: nil}}
      expect(flash[:error]).to eq('A turma não pode ser alterada')
    end 

    it 'should get index view' do
      sign_in(@user)
      get :index
      expect(response).to have_http_status(200)
    end

    it 'should get index view' do
      sign_in(@user)
      get :show, params:{id: @school_room.id}
      expect(response).to have_http_status(200)
    end

    it 'should get index view' do
      sign_in(@user)
      post :search_disciplines , params: {current_search: {search: 'fis'}}
      expect(response).to have_http_status(200)
    end    

  end
end
