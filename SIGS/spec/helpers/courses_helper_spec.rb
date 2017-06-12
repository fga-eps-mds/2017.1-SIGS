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
      @department = Department.create(code:"123",name:"departmentTest")
      @course = Course.create(code:"123",name:"courseTest",department: @department)
      @coordinator_test = Coordinator.create(course: @course, user: @user)
    end

    it 'should return courses of coordinator user' do
      sign_in(@user)
      courses_by_user
      expect(@coordinator.id).to eq(@coordinator_test.id)
      expect(@courses).to_not eq(nil)
    end
  end
end
