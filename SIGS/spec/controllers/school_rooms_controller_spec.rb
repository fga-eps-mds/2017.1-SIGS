require 'rails_helper'
include SessionsHelper

RSpec.describe SchoolRoomsController, type: :controller do

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #create' do
    it 'returns http success' do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe 'SchoolRooms methods' do

    before(:each) do
      @user = User.create(name: 'joao silva', email: 'joaosilva@unb.br',
        password: '123456', registration:'1100061', cpf:'05601407380', active: true)
      @department = Department.create(name: 'Departamento de Matemática', code: '007')
      @course = Course.create(name:'Matemática', code: '009', department: @department)
      @discipline = Discipline.create(name: 'Anãlise Combinatória', code: '123', department: @department)
      @coordinator = Coordinator.create(user: @user, course: @course)
    end

    it 'should return new view2' do
      post :new
      expect(response).to have_http_status(200)
    end

    it 'should return new view' do
      sign_in(@user)
      get :new
      expect(@school_room).to be_nil
    end

    it 'should create a new school room' do
      sign_in(@user)
<<<<<<< HEAD
      post :create, params:{school_room: {name: 'AA', discipline_id: @discipline.id, course: @course.id}}
=======
      post :create, params:{school_room: {name: 'AA', discipline_id: @discipline.id, course_ids: ['', @course.id]}}
>>>>>>> development
      expect(flash[:success]).to eq('Turma criada')
      expect(SchoolRoom.count).to be(1)
    end

    it 'should create school room with null name' do
      sign_in(@user)
      post :create, params:{school_room: {name: '', discipline_id: @discipline.id, course: @course.id}}
      expect(flash[:error]).to eq('Indique o nome da turma')
    end

    it 'should create school room with existent name' do
      sign_in(@user)
      post :create, params:{school_room: {name: 'AA', discipline_id: @discipline.id, course: @course.id}}
      post :create, params:{school_room: {name: 'AA', discipline_id: @discipline.id, course: @course.id}}
      expect(flash[:error]).to eq('Já existe uma turma com esse nome')
    end

    it 'should create school room force to fail' do
      sign_in(@user)
      post :create, params:{school_room: {name: 'AA', discipline_id: '', course: @course.id}}
      expect(flash[:error]).to eq('Falha ao criar')
    end
  end

end
