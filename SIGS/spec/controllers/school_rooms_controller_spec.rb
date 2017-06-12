require 'rails_helper'
include SessionsHelper
include SchoolRoomsHelper
include UserHelper

RSpec.describe SchoolRoomsController, type: :controller do
  describe 'SchoolRooms methods' do
    before(:each) do
      @user = User.create(name: 'joao silva', email: 'joaosilva@unb.br',
        password: '123456', registration:'1100061', cpf:'05601407380', active: true)
      @user_2 = User.create(name: 'joao silva', email: 'joaferrera@unb.br',
        password: '123456', registration:'1100069', cpf:'04601407380', active: true)
      @department = Department.create(name: 'Departamento de Matemática', code: '007')
      @course1 = Course.create(name:'Matemática', code: '009', department: @department, shift: 1)
      @course2 = Course.create(name:'Matemática', code: '001', department: @department, shift: 2)
      @course3 = Course.create(name:'Fisica', code: '011', department: @department, shift: 1)
      @course4 = Course.create(name:'Fisica', code: '121', department: @department, shift: 2)
      @discipline1 = Discipline.create(name: 'Anãlise Combinatória', code: '123', department: @department)
      @discipline2 = Discipline.create(name: 'Fisica 1', code: '193', department: @department)
      @coordinator = Coordinator.create(user: @user, course: @course1)
      @department2 = Department.create(name: 'Departamento de Artes', code: '009')
      @discipline3 = Discipline.create(name: 'Artes Visuais', code: '194', department: @department2)
      @coordinator_joao = Coordinator.create(user: @user, course: @course)
      @school_room = SchoolRoom.create(name: 'YY',vacancies: 50, discipline: @discipline1, course_ids: [@course1.id, @course3.id])
      @school_room2 = SchoolRoom.create(name:"AAA", vacancies: 50, discipline: @discipline3, course_ids: [@course1.id, @course3.id])
      @deg = Deg.create(user: @user_2)
      sign_in(@user)
    end

    it 'should get index view' do
      post :index
      expect(response).to have_http_status(200)
    end

    it 'should return all school rooms' do
      school_rooms = [@school_room, @school_room2]
      sign_out
      sign_in(@user_2)
      get :index
      expect(assigns(:my_school_rooms)).to eq(school_rooms)
    end

    it 'should search for a discipline' do
      post :search_disciplines , params: {current_search: {search: 'fis'}}
      expect(response).to have_http_status(200)
    end

    it 'should search for a not existent discipline' do
      post :search_disciplines , params: {current_search: {search: 'aaaaa'}}
      expect(flash[:notice]).to include("Nenhuma turma encontrada")
    end

    it 'should return new' do
      post :new
      expect(response).to have_http_status(200)
    end

    it 'should create a new school room' do
      post :create, params:{school_room: {name: 'AA', vacancies: 5, discipline_id: @discipline1.id, course_ids: [@course1.id, @course3.id]}}
      expect(flash[:success]).to eq('Turma criada')
      expect(SchoolRoom.count).to be(3)
    end

    it 'should create school room with null name' do
      post :create, params:{school_room: {name: '', vacancies: 5, discipline_id: @discipline1.id, course_ids: [@course1.id, @course3.id]}}
      expect(flash[:error]).to eq('Turma não pode ser vazia')
    end

    it 'should create school room with existent name' do
      post :create, params:{school_room: {name: 'AA',  vacancies: 5, discipline_id: @discipline1.id, course_ids: [@course1.id, @course3.id]}}
      post :create, params:{school_room: {name: 'AA',  vacancies: 5, discipline_id: @discipline1.id, course_ids: [@course1.id, @course3.id]}}
      expect(flash[:error]).to eq('Turma com nome já cadastrado')
    end

    it 'not should create school room with null discipline' do
      post :create, params:{school_room: {name: 'AA',  vacancies: 200, discipline: '', course_ids: [@course1.id, @course3.id]}}
      expect(flash[:error]).to include('Disciplina não pode ser vazia')
    end

    it 'not should create school room with low capacity' do
      post :create, params:{school_room: {name: 'AA',  vacancies: 4, discipline: @discipline2, course_ids: [@course1.id, @course3.id]}}
      expect(flash[:error]).to include('A capacidade mínima é 5 vagas')
    end

    it 'not should create school room with high capacity' do
      post :create, params:{school_room: {name: 'AA',  vacancies: 800, discipline: Discipline.last, course: [@course1.id, @course3.id]}}
      expect(flash[:error]).to include('A capacidade máxima é 500 vagas')
    end

    it 'not should create school room with blank capacity' do
      post :create, params:{school_room: {name: 'AA', vacancies: '', discipline: @discipline2, course_ids: [@course1.id, @course3.id]}}
      expect(flash[:error]).to include('Capacidade não pode ser vazia')
    end

    it 'returns http success' do
      school_room = SchoolRoom.create(name: 'AA',vacancies: 50, discipline_id: @discipline1.id, course_ids: [@course1.id, @course3.id])
      get :edit, params:{id: school_room.id}
      expect(response).to have_http_status(200)
    end

    it 'should update with valid data' do
      school_room = SchoolRoom.create(name: 'AA',vacancies: 50, discipline_id: @discipline1.id, course_ids: [@course1.id, @course3.id])
      get :update, params:{id: school_room.id, school_room:{discipline_id: @discipline2.id,vacancies: 50, course_ids: [@course1.id, @course3.id]}}
      expect(SchoolRoom.find(school_room.id).discipline_id).to eq(@discipline2.id)
    end

    it 'not should update with null discipline' do
      school_room = SchoolRoom.create(name: 'AA',vacancies: 50, discipline_id: @discipline1.id, course_ids: [@course1.id, @course3.id])
      get :update, params:{id: school_room.id, school_room:{discipline_id: nil,vacancies: 50, course_ids: [@course1.id, @course3.id]}}
      expect(flash[:error]).to include('Disciplina não pode ser vazia')
    end

    it 'not should update with courses with diferent periods' do
      sign_in(@user)
      school_room = SchoolRoom.create(name: 'AA',vacancies: 50, discipline_id: @discipline1.id, course_ids: [@course1.id, @course3.id])
      get :update, params:{id: school_room.id, school_room:{discipline_id: @discipline1.id,vacancies: 50, course_ids: [@course1.id, @course2.id]}}
      expect(flash[:error]).to include('Cursos devem ser do mesmo período')
    end

    it 'should delete school room' do
      school_room = SchoolRoom.create(name: 'AA',vacancies: 50, discipline_id: @discipline1.id, course_ids: [@course1.id, @course3.id])
      get :destroy, params:{id: school_room.id}
      expect(flash[:success]).to include('A turma foi excluída com sucesso')
    end

    it 'not should delete school room because user not have permission' do
      school_room = SchoolRoom.create(name: 'AA',vacancies: 50, discipline_id: @discipline3.id, course_ids: [@course1.id, @course3.id])
      get :destroy, params:{id: school_room.id}
      expect(flash[:error]).to include('Permissão negada')
    end
  end
end
