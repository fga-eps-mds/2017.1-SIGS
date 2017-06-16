require 'rails_helper'

RSpec.describe ReportsDisciplinesController, type: :controller do
    before(:each) do
      @user = User.create(name: 'joao silva', email: 'joaosilva@unb.br', password: '123456', registration:'1100061', cpf:'05601407380', active: true)
      @department = Department.create(name: 'Departamento de Matemática', code: '007')
      @course = Course.create(name:'Matemática', code: '009', department: @department)
      @coordinator = Coordinator.create(user: @user, course: @course)

      @period_1 = Period.create(period_type:'Alocação', initial_date: '10-01-2018', final_date: '01-02-2018')
      @period_2 = Period.create(period_type:'Ajuste', initial_date: '23-02-2018', final_date: '01-03-2018')
      @period_3 = Period.create(period_type:'Letivo', initial_date: '08-03-2018', final_date: '14-07-2018')
      @building = Building.create(code: 'ICC', name: 'ICC', wing: 'norte')
      @discipline = Discipline.create(name: 'Análise Combinatória', code: '123', department: @department)
      @discipline2 = Discipline.create(name: 'Geografia', code: '321', department: @department)
      @discipline3 = Discipline.create(name: 'Teologia', code: '666', department: @department)

      @school_room = SchoolRoom.create(name:"YY", vacancies: 50, discipline: @discipline, course_ids: [@course.id])
      @school_room2 = SchoolRoom.create(name:"AAA", vacancies: 50, discipline: @discipline3, course_ids: [@course.id])
      @school_room3 = SchoolRoom.create(name:"BBB", vacancies: 50, discipline: @discipline3, course_ids: [@course.id])
      @room = Room.create(code: 'S10', name: 'Superior 10', capacity: 50, active: true, time_grid_id: 1, building: @building, department: @department )
      @room_2 = Room.create(code: 'S11', name: 'Superior 10', capacity: 50, active: true, time_grid_id: 1, building: @building, department: @department )

      @allocation = Allocation.create(active: true, start_time: '14:00', final_time: '16:00', day: 'Segunda',user: @user, room: @room, school_room: @school_room)
      @allocation2 = Allocation.create(active: true, start_time: '14:00', final_time: '16:00', day: 'Terça',user: @user, room: @room2, school_room: @school_room)
      @allocation3 = Allocation.create(active: true, start_time: '14:00', final_time: '16:00', day: 'Quinta',user: @user, room: @room2, school_room: @school_room2)

      sign_in(@user)
    end

    it 'should find disciplines' do
      get :by_discipline
      expect(response).to be_success
    end

    it 'should return all disciplines' do
      get :by_discipline
      teste= [@discipline, @discipline2, @discipline3]
      expect(assigns(:disciplines)).to eq(teste)
    end

    it 'should return specific discipline' do
      post :by_discipline, params:{name: "C"}
      teste= [@discipline]
      expect(assigns(:disciplines)).to eq(teste)
    end

    it 'should return no discipline' do
      post :by_discipline, params:{name: "V"}
      teste= []
      expect(assigns(:disciplines)).to eq(teste)
    end

    it 'should generate_by_discipline' do
      get :generate_by_discipline, params:{id: @discipline.id}
      analysis = PDF::Inspector::Text.analyze response.body
      expect(analysis.strings).to include ("Turma: #{@school_room.name}")
    end

    it 'should generate_by_discipline with no school_room' do
      get :generate_by_discipline, params:{id: @discipline2}
      analysis = PDF::Inspector::Text.analyze response.body
      expect(analysis.strings).to include ("Disciplina sem turmas")
    end

    it 'should generate_by_discipline with school_rooms variables' do
      get :generate_by_discipline, params:{id: @discipline3}
      analysis = PDF::Inspector::Text.analyze response.body
      expect(analysis.strings).to include ("Não alocada")
    end
end
