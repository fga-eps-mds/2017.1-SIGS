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
      @discipline = Discipline.create(name: 'Análise Combinatória', code: '123', department: @department)
      @school_room = SchoolRoom.create(name:"YY", vacancies: 50, discipline: @discipline)
      @school_room_2 = SchoolRoom.create(name:"XY", vacancies: 50, discipline: @discipline)

      @room = Room.create(code: 'S10', name: 'Superior 10', capacity: 50, active: true, time_grid_id: 1, building: @building, department: @department )
      @room_2 = Room.create(code: 'S11', name: 'Superior 10', capacity: 50, active: true, time_grid_id: 1, building: @building, department: @department )

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

      expect(analysis.strings).to include ("Sala: #{@room.code}")
    end


    it 'check pdf created of many page' do
      post :generate_by_room, params:{reports_by_room:{all_rooms: 1,
                                                       departments: @department.id
                                                      }}, format: :pdf

      analysis = PDF::Inspector::Text.analyze response.body

      expect(analysis.strings).to include ("Sala: #{@room.code}")
      expect(analysis.strings).to include ("Sala: #{@room_2.code}")
    end

<<<<<<< HEAD
    it "should return all school rooms" do
      get :report_school_room_all

      expect(Allocation.count).to eq(2)
    end
=======
>>>>>>> 82442fa50c44bc0c04b7444b44ee50f0e2bc4002
  end
end
