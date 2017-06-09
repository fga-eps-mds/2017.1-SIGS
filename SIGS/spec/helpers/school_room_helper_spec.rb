require 'rails_helper'

RSpec.describe SchoolRoomsHelper, type: :helper do

  describe "Testing SchoolRoomsHelper methods" do

    before(:each) do
      @department = Department.create(code: '789', name: 'Engenharia')
      @course = Course.create(code: '10', name: 'Engenharia de Software', department: @department)
      @user = User.create(name: 'Caio Filipe', email: 'caio@unb.br', cpf: '05012345678', registration: '1234567', active: true, password: '123456')
      @coordinator = Coordinator.create(user: @user, course: @course)
      @discipline = Discipline.create(code: '876', name: 'Calculo 3', department: @department)
      @school_room = SchoolRoom.create(name:"YY", vacancies: 50, discipline: @discipline, course_ids: [@course.id])
    end

    it "get name by id" do
      expect(get_name(@school_room.id)).to eq(@school_room.name)
    end

    it "get discipline name by id" do
      expect(get_discipline_name(@school_room.id)).to eq(@school_room.discipline.name)
    end

    it "get get department name by id" do
      expect(get_department_name(@school_room.id)).to eq(@school_room.discipline.department.name)
    end

    it "get get vacancies by id" do
      expect(get_vacancies(@school_room.id)).to eq(@school_room.vacancies)
    end

    it "get get courses by id" do
      expect(get_courses(@school_room.id)).to eq(@school_room.courses)
    end

    it "get get categories by id" do
      expect(get_categories(@school_room.id)).to eq(@school_room.category)
    end
  end
end