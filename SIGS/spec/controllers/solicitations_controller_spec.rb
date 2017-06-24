require 'rails_helper'

RSpec.describe SolicitationsController, type: :controller do
  describe 'Solicitation allocation in allocation period' do
    before(:each) do
      @user1 = User.create(name: 'joao silva', email: 'joaosilva@unb.br',
        password: '123456', registration:'1100061', cpf:'05601407380', active: true)
      @user2 = User.create(name: 'kleber matos', email: 'kleber@unb.br',
        password: '123456', registration:'1100078', cpf:'05601407378', active: true)
      @department1 = Department.create(name: 'Departamento de Matemática', code: '007')
      @department2 = Department.create(name: 'Departamento de Física', code: '008')
      @course1 = Course.create(name:'Matemática', code: '009', department: @department1, shift: 1)
      @course2 = Course.create(name:'Matemática', code: '001', department: @department2, shift: 2)
      @discipline1 = Discipline.create(name: 'Anãlise Combinatória', code: '123', department: @department1)
      @coordinator1 = Coordinator.create(user: @user1, course: @course1)
      @prc = AdministrativeAssistant.create(user: @user2)
      @period = Period.create(period_type:'Alocação', initial_date: Date.current - 5.days, final_date: Date.current + 5.days)
    end

    it 'should open index page coordinator' do
      sign_in(@user1)
      get :index
      expect(response).to have_http_status(200)
    end

    it 'should open index page coordinator' do
      sign_in(@user2)
      get :index
      expect(response).to have_http_status(200)
    end
end

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

    it 'should redirect to allocation period page' do
      get :adjustment_period, params: {school_room_id: @school_room1.id}
      expect(response).to have_http_status(302)
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

    it 'should check assigns with status = 0' do
      @solicitation = Solicitation.create(justify: 'aaaa', status: 0, request_date: '10-01-2018', requester_id: @user1.id, school_room_id: @school_room1.id)
      @room_solicitation = RoomSolicitation.create(solicitation_id: @solicitation.id,start: '10-01-2018 12:00:00',final: '10-01-2018 13:00:00',day: "segunda",department_id: @department1.id)
      get :index
      expect(assigns(:solicitations)).not_to be_empty
    end

    it 'should check assigns with status != 0' do
      @solicitation = Solicitation.create(justify: 'aaaa', status: 2, request_date: '10-01-2018', requester_id: @user1.id, school_room_id: @school_room1.id)
      @room_solicitation = RoomSolicitation.create(solicitation_id: @solicitation.id,start: '10-01-2018 12:00:00',final: '10-01-2018 13:00:00',day: "segunda",department_id: @department1.id)
      get :index
      expect(assigns(:solicitations)).to eq([])
    end
  end

  describe 'Solicitation allocation in adjustment period' do
    before(:each) do
      @user1 = User.create(name: 'joao silva', email: 'joaosilva@unb.br',
        password: '123456', registration:'1100061', cpf:'05601407380', active: true)
      @user2 = User.create(name: 'kleber matos', email: 'kleber@unb.br',
        password: '123456', registration:'1100078', cpf:'05601407378', active: true)
      @user3 = User.create(name: 'maria jose', email: 'majose@unb.br',
        password: '123456', registration:'1102278', cpf:'23601407378', active: true)
      @department1 = Department.create(name: 'Departamento de Matemática', code: '007', wing: 'NORTE')
      @department2 = Department.create(name: 'Departamento de Física', code: '008', wing: 'SUL')
      @course1 = Course.create(name:'Matemática', code: '009', department: @department1, shift: 1)
      @course2 = Course.create(name:'Matemática', code: '001', department: @department2, shift: 2)
      @course3 = Course.create(name:'Matemática', code: '011', department: @department1, shift: 1)
      @discipline1 = Discipline.create(name: 'Anãlise Combinatória', code: '123', department: @department1)
      @discipline2 = Discipline.create(name: 'Combinatória', code: '447', department: @department2)
      @coordinator1 = Coordinator.create(user: @user1, course: @course1)
      @coordinator2 = Coordinator.create(user: @user2, course: @course2)
      @school_room1 = SchoolRoom.create(name:"YY", vacancies: 50, discipline: @discipline1, course_ids: [@course1.id, @course3.id])
      @school_room2 = SchoolRoom.create(name:"YY", vacancies: 50, discipline: @discipline2, course_ids: [@course2.id])
      @period = Period.create(period_type:'Alocação', initial_date: Date.current - 10.days, final_date: Date.current - 5.days)
      @building = Building.create(code: 'ICC', name: 'ICC', wing: 'norte')
      @room = Room.create(code: 'S10', name: 'Superior 10', capacity: 50,
                          active: true, time_grid_id: 1, building: @building, department: @department1)
      @allocation = Allocation.create(user_id: @user1.id,room_id: @room.id, school_room_id: @school_room1.id, day: "Segunda", start_time: '16:00:00', final_time: '17:00:00')

      sign_in(@user1)
    end

    it 'should open adjustment period page north' do
      get :adjustment_period, params: {school_room_id: @school_room1.id}
      expect(response).to have_http_status(200)
    end

    it 'should open adjustment period page in ajax' do
      get :avaliable_rooms_by_department, params: {department: @department1.id,
                                                   school_room: @school_room1.id,
                                                   allocations: ['segunda[11]', 'segunda[12]']
                                                  }
      expect(response).to have_http_status(200)
    end

    it 'should open adjustment period page north' do
      get :adjustment_period, params: {school_room_id: @school_room2.id}
      expect(response).to have_http_status(200)
    end

    it 'should redirect to adjustment period page' do
      get :allocation_period, params: {school_room_id: @school_room1.id}
      expect(response).to have_http_status(302)
    end

    it 'should create new solicitation wing' do
      post :save_adjustment_period, params: {solicitation: {school_room_id: @school_room1.id, justify: 'texto qualquer'},
                                             segunda: {'12': '1'},
                                             rooms: [@room.id]}
      expect(Solicitation.all.count).to eq(1)
    end

    it 'should create new solicitation with merge hours' do
      post :save_adjustment_period, params: {solicitation: {school_room_id: @school_room1.id, justify: 'texto qualquer'},
                                             segunda: {'12': '1', '13': '1'},
                                             rooms: [@room.id]}
      expect(Solicitation.all.count).to eq(1)
    end

    it 'should not create new solicitation because no have hours' do
      post :save_adjustment_period, params: {solicitation: {school_room_id: @school_room1.id, justify: 'texto qualquer'},
                                             rooms: [@room.id]}
      expect(flash[:error]).to eq('Selecione o horário que deseja')
    end

    it 'should not create new solicitation because no have justify' do
      post :save_adjustment_period, params: {solicitation: {school_room_id: @school_room1.id},
                                             segunda: {'12': '1'},
                                             rooms: [@room.id]}
      expect(flash[:error]).to eq('A solicitação deve conter uma justificativa')
    end

    it 'should not create new solicitation because no have permission' do
      sign_in(@user2)
      post :save_adjustment_period, params: {solicitation: {school_room_id: @school_room1.id, justify: 'texto qualquer'},
                                             segunda: {'12': '1'},
                                             rooms: [@room.id]}
      expect(flash[:error]).to eq('Você não tem permissão para alocar essa turma')
    end

    it 'should not create new solicitation because user is not a coordinator' do
      sign_in(@user3)
      post :save_adjustment_period, params: {solicitation: {school_room_id: @school_room1.id, justify: 'texto qualquer'},
                                             segunda: {'12': '1'},
                                             rooms: [@room.id]}
      expect(flash[:error]).to eq('Acesso negado.')
    end

    it 'should not create new solicitation because no select rooms' do
      post :save_adjustment_period, params: {solicitation: {school_room_id: @school_room1.id, justify: 'texto qualquer'},
                                             segunda: {'12': '1', '13': '1'}
                                           }
      expect(flash[:error]).to eq('Selecione ao menos uma sala')
    end

    it 'should not create new solicitation because shock hour' do
      get :avaliable_rooms_by_department, params: {department: @department1.id,
                                                   school_room: @school_room1.id,
                                                   allocations: ['segunda[16]', 'segunda[17]']
                                                  }
    end
  end
end
