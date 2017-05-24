require 'rails_helper'

RSpec.describe CoordinatorHelper, type: :helper do

  describe "Testing CoordinatorHelper methods" do

    before(:each) do
      @department = Department.create(code: '789', name: 'Engenharia')
      @course = Course.create(code: '10', name: 'Engenharia de Software', department: @department)
      @user = User.create(name: 'Caio Filipe', email: 'caio@unb.br', cpf: '05012345678', registration: '1234567', active: true, password: '123456')
      @coordinator = Coordinator.create(user: @user, course: @course)
      @discipline = Discipline.create(code: '876', name: 'Calculo 3', department: @department)
    end

    it "get disciplines by user_id" do
      disciplines = get_disciplines(@user)
      expect(disciplines[0]).to eq(@discipline)
    end
  end
end