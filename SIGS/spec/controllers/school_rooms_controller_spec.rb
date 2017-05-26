require 'rails_helper'
include SessionsHelper

RSpec.describe SchoolRoomsController, type: :controller do

  describe 'SchoolRooms methods' do

    before(:each) do
      @user = User.create(name: 'joao silva', email: 'joaosilva@unb.br',
        password: '123456', registration:'1100061', cpf:'05601407380', active: true)
      @department = Department.create(name: 'Departamento de Matemática', code: '007')
      @course1 = Course.create(name:'Matemática', code: '009', department: @department, shift: 1)
      @course2 = Course.create(name:'Matemática', code: '001', department: @department, shift: 2)
      @course3 = Course.create(name:'Fisica', code: '011', department: @department, shift: 1)
      @course4 = Course.create(name:'Fisica', code: '121', department: @department, shift: 2)
      @discipline1 = Discipline.create(name: 'Anãlise Combinatória', code: '123', department: @department)
      @discipline2 = Discipline.create(name: 'Fisica 1', code: '193', department: @department)
      @coordinator = Coordinator.create(user: @user, course: @course1)
    end

    it 'should return new' do
      sign_in(@user)
      post :new
      expect(response).to have_http_status(200)
    end

    it 'should create a new school room' do
      sign_in(@user)
      post :create, params:{school_room: {name: 'AA', capacity: 5, discipline_id: @discipline1.id, course_ids: [@course1.id, @course3.id]}}
      expect(flash[:success]).to eq('Turma criada')
      expect(SchoolRoom.count).to be(1)
    end

    it 'should create school room with null name' do
      sign_in(@user)
      post :create, params:{school_room: {name: '', capacity: 5, discipline_id: @discipline1.id, course_ids: [@course1.id, @course3.id]}}
      expect(flash[:error]).to eq('Turma não pode ser vazia')
    end

    it 'should create school room with existent name' do
      sign_in(@user)
      post :create, params:{school_room: {name: 'AA',  capacity: 5, discipline_id: @discipline1.id, course_ids: [@course1.id, @course3.id]}}
      post :create, params:{school_room: {name: 'AA',  capacity: 5, discipline_id: @discipline1.id, course_ids: [@course1.id, @course3.id]}}
      expect(flash[:error]).to eq('Turma com nome já cadastrado')
    end

    it 'not should create school room with null discipline' do
      sign_in(@user)
      post :create, params:{school_room: {name: 'AA',  capacity: 200, discipline: '', course_ids: [@course1.id, @course3.id]}}
      expect(flash[:error]).to include('Disciplina não pode ser vazia')
    end

    it 'not should create school room with low capacity' do
      sign_in(@user)
      post :create, params:{school_room: {name: 'AA',  capacity: 4, discipline: @discipline2, course_ids: [@course1.id, @course3.id]}}
      expect(flash[:error]).to include('A capacidade mínima é 5 vagas')
    end

    it 'not should create school room with high capacity' do
      sign_in(@user)
      post :create, params:{school_room: {name: 'AA',  capacity: 800, discipline: Discipline.last, course_ids: [@course1.id, @course3.id]}}
      expect(flash[:error]).to include('A capacidade máxima é 500 vagas')
    end

    it 'not should create school room with blank capacity' do
      sign_in(@user)
      post :create, params:{school_room: {name: 'AA', capacity: '', discipline: @discipline2, course_ids: [@course1.id, @course3.id]}}
      expect(flash[:error]).to include('Capacidade não pode ser vazia')
    end

    it 'returns http success' do
      sign_in(@user)
      school_room = SchoolRoom.create(name: 'AA',capacity: 50, discipline_id: @discipline1.id, course_ids: [@course1.id, @course3.id])
      get :edit, params:{id: school_room.id}
      expect(response).to have_http_status(200)
    end

    it 'should update with valid data' do
      sign_in(@user)
      school_room = SchoolRoom.create(name: 'AA',capacity: 50, discipline_id: @discipline1.id, course_ids: [@course1.id, @course3.id])
      get :update, params:{id: school_room.id, school_room:{discipline_id: @discipline2.id,capacity: 50, course_ids: [@course1.id, @course3.id]}}
      expect(SchoolRoom.find(school_room.id).discipline_id).to eq(@discipline2.id)
    end

    it 'not should update with null discipline' do
      sign_in(@user)
      school_room = SchoolRoom.create(name: 'AA',capacity: 50, discipline_id: @discipline1.id, course_ids: [@course1.id, @course3.id])
      get :update, params:{id: school_room.id, school_room:{discipline_id: nil,capacity: 50, course_ids: [@course1.id, @course3.id]}}
      expect(flash[:error]).to include('Disciplina não pode ser vazia')
    end

    it 'not should update with courses with diferent periods' do
      sign_in(@user)
      school_room = SchoolRoom.create(name: 'AA',capacity: 50, discipline_id: @discipline1.id, course_ids: [@course1.id, @course3.id])
      get :update, params:{id: school_room.id, school_room:{discipline_id: @discipline1.id,capacity: 50, course_ids: [@course1.id, @course2.id]}}
      expect(flash[:error]).to include('Cursos devem ser do mesmo período')
    end
  end
end
