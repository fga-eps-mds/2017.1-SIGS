require 'rails_helper'

RSpec.describe SchoolRoomsController, type: :controller do

  describe 'SchoolRooms methods' do

    before(:each) do
      @user = User.create(name: 'joao silva', email: 'joaosilva@unb.br',
        password: '123456', registration:'1100061', cpf:'05601407380', active: true)
      @department = Department.create(name: 'Departamento de Matemática', code: '007')
      @department2 = Department.create(name: 'Departamento de Artes', code: '009')
      @course = Course.create(name:'Matemática', code: '009', department: @department)
      @discipline1 = Discipline.create(name: 'Anãlise Combinatória', code: '123', department: @department)
      @discipline2 = Discipline.create(name: 'Fisica 1', code: '193', department: @department)
      @discipline3 = Discipline.create(name: 'Artes Visuais', code: '194', department: @department2)
      @coordinator = Coordinator.create(user: @user, course: @course)
    end

    it 'should return new' do
      sign_in(@user)
      post :new
      expect(response).to have_http_status(200)
    end

    it 'should create a new school room' do
      sign_in(@user)

      post :create, params:{school_room: {name: 'AA', vacancies: 5, discipline_id: @discipline1.id, course: @course.id}}
      expect(flash[:success]).to eq('Turma criada')
      expect(SchoolRoom.count).to be(1)
    end

    it 'should create school room with null name' do
      sign_in(@user)
      post :create, params:{school_room: {name: '', vacancies: 5, discipline_id: @discipline1.id, course: @course.id}}
      expect(flash[:error]).to eq('Turma não pode ser vazia')
    end

    it 'should create school room with existent name' do
      sign_in(@user)
      post :create, params:{school_room: {name: 'AA',  vacancies: 5, discipline_id: @discipline1.id, course: @course.id}}
      post :create, params:{school_room: {name: 'AA',  vacancies: 5, discipline_id: @discipline1.id, course: @course.id}}
      expect(flash[:error]).to eq('Turma com nome já cadastrado')
    end

    it 'not should create school room with null discipline' do
      sign_in(@user)
      post :create, params:{school_room: {name: 'AA',  vacancies: 200, discipline: '', course: @course.id}}
      expect(flash[:error]).to include('Disciplina não pode ser vazia')
    end

    it 'not should create school room with low vacancies' do
      sign_in(@user)
      post :create, params:{school_room: {name: 'AA',  vacancies: 4, discipline: @discipline2, course: @course.id}}
      expect(flash[:error]).to include('A capacidade mínima é 5 vagas')
    end

    it 'not should create school room with high vacancies' do
      sign_in(@user)
      post :create, params:{school_room: {name: 'AA',  vacancies: 800, discipline: Discipline.last, course: @course.id}}
      expect(flash[:error]).to include('A capacidade máxima é 500 vagas')
    end

    it 'not should create school room with blank vacancies' do
      sign_in(@user)
      post :create, params:{school_room: {name: 'AA', vacancies: '', discipline: @discipline2, course: @course.id}}
      expect(flash[:error]).to include('Capacidade não pode ser vazia')
    end

    it 'returns http success' do
      sign_in(@user)
      school_room = SchoolRoom.create(name: 'AA',vacancies: 50, discipline_id: @discipline1.id)
      get :edit, params:{id: school_room.id}
      expect(response).to have_http_status(200)
    end

    it 'should update with valid data' do
      sign_in(@user)
      school_room = SchoolRoom.create(name: 'AA',vacancies: 50, discipline_id: @discipline1.id)
      get :update, params:{id: school_room.id, school_room:{discipline_id: @discipline2.id}}
      expect(SchoolRoom.find(school_room.id).discipline_id).to eq(@discipline2.id)
    end

    it 'not should update with null discipline' do
      sign_in(@user)
      school_room = SchoolRoom.create(name: 'AA',vacancies: 50, discipline_id: @discipline1.id)
      get :update, params:{id: school_room.id, school_room:{discipline_id: nil}}
      expect(flash[:error]).to include('Disciplina não pode ser vazia')
    end

    it 'should delete school room' do
      sign_in(@user)
      school_room = SchoolRoom.create(name: 'AA',vacancies: 50, discipline_id: @discipline1.id)
      get :destroy, params:{id: school_room.id}
      expect(flash[:success]).to include('A turma foi excluída com sucesso')
    end

    it 'not should delete school room because user not have permission' do
      sign_in(@user)
      school_room = SchoolRoom.create(name: 'AA',vacancies: 50, discipline_id: @discipline3.id)
      get :destroy, params:{id: school_room.id}
      expect(flash[:error]).to include('Permissão negada')
    end
  end
end
