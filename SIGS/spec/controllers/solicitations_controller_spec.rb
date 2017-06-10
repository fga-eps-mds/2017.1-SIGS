require 'rails_helper'

RSpec.describe SolicitationsController, type: :controller do
  describe 'Solicitation allocation in allocation period' do
    before(:each) do
      @user1 = User.create(name: 'joao silva', email: 'joaosilva@unb.br',
        password: '123456', registration:'1100061', cpf:'05601407380', active: true)
      @user2 = User.create(name: 'kleber matos', email: 'kleber@unb.br',
        password: '123456', registration:'1100078', cpf:'05601407378', active: true)
      @user3 = User.create(name: 'maria jose', email: 'majose@unb.br',
        password: '123456', registration:'1102278', cpf:'23601407378', active: true)
      @department1 = Department.create(name: 'Departamento de Matemática', code: '007')
      @department2 = Department.create(name: 'Departamento de Física', code: '008')
      @course1 = Course.create(name:'Matemática', code: '009', department: @department1, shift: 1)
      @course2 = Course.create(name:'Matemática', code: '001', department: @department2, shift: 2)
      @discipline1 = Discipline.create(name: 'Anãlise Combinatória', code: '123', department: @department1)
      @coordinator1 = Coordinator.create(user: @user1, course: @course1)
      @coordinator2 = Coordinator.create(user: @user2, course: @course2)
      @school_room1 = SchoolRoom.create(name:"YY", vacancies: 50, discipline: @discipline1, course_ids: [@course1.id])
      @school_room2 = SchoolRoom.create(name:"YY", vacancies: 50, discipline: @discipline1, course_ids: [@course2.id])
      @period = Period.create(period_type:'Alocação', initial_date: Date.current - 5.days, final_date: Date.current + 5.days)
      sign_in(@user1)
    end

    it 'should open allocation period page' do
      get :allocation_period, params: {school_room_id: @school_room1.id}
      expect(response).to have_http_status(200)
    end
    
    it 'should create new solicitation' do
      post :save_allocation_period, params: {solicitation: {school_room_id: @school_room1.id, departments: @department1.id, justify: 'texto qualquer'}, segunda: {'12': '1'}}
      expect(Solicitation.all.count).to eq(1)
    end

    it 'should create new solicitation with merge hours' do
      post :save_allocation_period, params: {solicitation: {school_room_id: @school_room1.id, departments: @department1.id, justify: 'texto qualquer'}, segunda: {'12': '1', '13': '1'}}
      expect(Solicitation.all.count).to eq(1)
    end

    it 'should not create new solicitation because no have hours' do
      post :save_allocation_period, params: {solicitation: {school_room_id: @school_room1.id, departments: @department1.id, justify: 'texto qualquer'}}
      expect(flash[:error]).to eq('Selecione o horário que deseja')
    end

    it 'should not create new solicitation because no have justify' do
      post :save_allocation_period, params: {solicitation: {school_room_id: @school_room1.id, departments: @department1.id}, segunda: {'12': '1'}}
      expect(flash[:error]).to eq('A solicitação deve conter uma justificativa')
    end

    it 'should not create new solicitation because no have permission' do
      sign_in(@user2)
      post :save_allocation_period, params: {solicitation: {school_room_id: @school_room1.id, departments: @department1.id, justify: 'texto qualquer'}, segunda: {'12': '1'}}
      expect(flash[:error]).to eq('Você não tem permissão para alocar essa turma')
    end

    it 'should not create new solicitation because user is not a coordinator' do
      sign_in(@user3)
      post :save_allocation_period, params: {solicitation: {school_room_id: @school_room1.id, departments: @department1.id, justify: 'texto qualquer'}, segunda: {'12': '1'}}
      expect(flash[:error]).to eq('Acesso negado.')
    end

  end
end
