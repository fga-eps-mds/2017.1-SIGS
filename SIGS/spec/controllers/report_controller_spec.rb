require 'rails_helper'
include SessionsHelper

RSpec.describe ReportsController, type: :controller do
  describe 'report controller methods' do
    before(:each) do
      @user = User.create(name: 'joao silva', email: 'joaosilva@unb.br', password: '123456', registration:'1100061', cpf:'05601407380', active: true)
      @department = Department.create(name: 'Departamento de Matemática', code: '007')
      @course = Course.create(name:'Matemática', code: '009', department: @department)
      @coordinator = Coordinator.create(user: @user, course: @course)

      @period_1 = Period.create(period_type:'Alocação', initial_date: '10-01-2018', final_date: '01-02-2018')
      @period_2 = Period.create(period_type:'Ajuste', initial_date: '23-02-2018', final_date: '01-03-2018')
      @period_3 = Period.create(period_type:'Letivo', initial_date: '08-03-2018', final_date: '14-07-2018')
      @building = Building.create(code: 'ICC', name: 'ICC', wing: 'norte')
      @building2 = Building.create(code: 'FT', name: 'FT', wing: 'norte')
      @discipline = Discipline.create(name: 'Análise Combinatória', code: '123', department: @department)
      @discipline2 = Discipline.create(name: 'Geografia', code: '321', department: @department)
      @disciplin3 = Discipline.create(name: 'Teologia', code: '666', department: @department)

      @school_room = SchoolRoom.create(name:"YY", vacancies: 50, discipline: @discipline, course_ids: [@course.id])
      @school_room_2 = SchoolRoom.create(name:"XY", vacancies: 50, discipline: @discipline, course_ids: [@course.id])

      @room = Room.create(code: 'S10', name: 'Superior 10', capacity: 50, active: true, time_grid_id: 1, building: @building, department: @department )
      @room_2 = Room.create(code: 'S11', name: 'Superior 11', capacity: 50, active: true, time_grid_id: 1, building: @building, department: @department )

      @allocation = Allocation.create(active: true, start_time: '14:00', final_time: '16:00', day: 'Segunda',user: @user, room: @room, school_room: @school_room)
      @allocation2 = Allocation.create(active: true, start_time: '14:00', final_time: '16:00', day: 'Terça',user: @user, room: @room2, school_room: @school_room)

      sign_in(@user)
    end

    it 'should return report page' do
      get :by_room
      expect(response).to have_http_status(200)
    end

    it 'should return room of department json page' do
      get :json_of_rooms_by_department, params:{department_code: @department.id}
      expect(response).to have_http_status(200)
    end

    it 'should return room with part of name json page' do
      get :json_of_rooms_with_parts_of_name, params:{department_code: @department.id}
      expect(response).to have_http_status(200)
    end

    it 'should return report' do
      post :generate_by_room, params:{reports_by_room:{all_rooms: 0,
                                                       room_code: @room.id,
                                                       departments: @department.id
                                                      }}
      expect(response).to have_http_status(200)
    end

    it 'should return report all rooms' do
      post :generate_by_room, params:{reports_by_room:{all_rooms: 1,
                                                       departments: @department.id
                                                      }}
      expect(response).to have_http_status(200)
    end

    it 'check pdf created of one page' do
      post :generate_by_room, params:{reports_by_room:{all_rooms: 0,
                                                       room_code: @room.id,
                                                       departments: @department.id
                                                      }}, format: :pdf

      analysis = PDF::Inspector::Text.analyze response.body

      expect(analysis.strings).to include ("Sala: #{@room.name}")
    end

    it 'check pdf created of many page' do
      post :generate_by_room, params:{reports_by_room:{all_rooms: 1,
                                                       departments: @department.id
                                                      }}, format: :pdf

      analysis = PDF::Inspector::Text.analyze response.body

      expect(analysis.strings).to include ("Sala: #{@room.name}")
      expect(analysis.strings).to include ("Sala: #{@room_2.name}")
    end

    it 'should return report by building page' do
      get :by_building
      expect(response).to have_http_status(200)
    end

    it 'should return all buildings' do
      get :by_building
      buildings = [@building, @building2]
      expect(assigns(:buildings)).to eq(buildings)
    end

    it 'should return a specific building' do
      get :by_building, params:{search: "F"}
      building = [@building2]
      expect(assigns(:buildings)).to eq(building)
    end

    it 'should return none building' do
      get :by_building, params:{search: "H"}
      no_building = []
      expect(assigns(:buildings)).to eq(no_building)
    end

    it 'shoudl create a pdf of all rooms' do
      get :generate_by_building, params:{id: @building.id}
      analysis = PDF::Inspector::Text.analyze response.body
      expect(analysis.strings).to include ("Sala: #{@room.name}")
      expect(analysis.strings).to include ("Sala: #{@room_2.name}")
    end

    it 'shoudl returun a flash message for dont have rooms' do
      get :generate_by_building, params:{id: @building2.id}
      expect(flash[:error]).to eq('Este prédio não possui salas')
      expect(response).to render_template(:by_building)
    end
  end
end
