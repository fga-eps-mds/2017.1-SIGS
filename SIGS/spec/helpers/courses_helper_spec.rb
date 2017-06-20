require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the CoursesHelper. For example:
#
# describe CoursesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe CoursesHelper, type: :helper do

  describe "Testing CoursesHelper methods" do

    before(:each) do
      @user = User.create(name: 'teste123', cpf: '05365052170', registration: '1234567' , email: 'test@unb.br', password: '123123', active: true)
      @user1 = User.create(name: 'teste1234', cpf: '05365052171', registration: '1234568', email: 'test1@unb.br', password: '1231234', active: true)
      @department = Department.create(code:"123",name:"departmentTest")
      @course = Course.create(code:"123",name:"courseTest",department_id: @department.id)
      @coordinator_test = Coordinator.create(course_id: @course.id, user_id: @user.id)
      @user2 = User.create(name: 'teste12345', cpf: '05365052172', registration: '1234569', email: 'test2@unb.br', password: '12312345', active: true)
      @department_assistant_test = DepartmentAssistant.create(department_id: @department.id,user_id: @user1.id)
      @administrative_assistant_test = AdministrativeAssistant.create(user_id: @user2.id)
    end

    it 'should return courses of coordinator user' do
      sign_in(@user)
      courses_by_user
      expect(@coordinator.id).to eq(@coordinator_test.id)
      expect(@courses).to_not eq(nil)
    end

    it 'should return courses of department assistant user' do
      sign_in(@user1)
      courses_by_user
      expect(@department_assistant.id).to eq(@department_assistant_test.id)
      expect(@department_assistant).to_not eq(nil)
    end
  end
end
