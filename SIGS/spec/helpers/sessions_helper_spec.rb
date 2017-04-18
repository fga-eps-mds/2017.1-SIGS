require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do

  describe "Testing SessionsHelper methods" do

    before(:each) do
      @user = User.create(name: 'teste', email: 'test@test.com', password: '123', active: true)
      @department = Department.create(code:"123",name:"departmentTest")
      @course = Course.create(code:"123",name:"courseTest",department_id: @department.id)
      @coordinator = Coordinator.create(course_id: @course.id,department_id: @department.id, user_id: @user.id)
      @user1 = User.create(name: 'teste1', email: 'test1@test.com', password: '123', active: true)
      @user2 = User.create(name: 'teste2', email: 'test2@test.com', password: '123', active: true)
      @department_assistant = DepartmentAssistant.create(department_id: @department.id,user_id: @user1.id)
      @administrative_assistant = AdministrativeAssistant.create(user_id: @user2.id)
    end

    it "Should assign a user_id to session" do
      sign_in(@user)
    end

    it "Should find and assign a user to current_user" do
      sign_in(@user)
      current_user
      expect(@current_user).to eq(@user)
    end

    it "Should unassign a current_user, user_id and permission from session " do
      sign_in(@user)
      sign_out
      expect(session[:user_id]).to eq(nil)
      expect(@current_user).to eq(nil)
      expect(@permission).to eq(nil)
      expect(@level).to eq(nil)
    end

    it "Should return a level of permission to current_user" do
      sign_in(@user)
      permission
      expect(@permission).to eq(1)
      sign_out
      sign_in(@user1)
      permission
      expect(@permission).to eq(2)
      sign_out
      sign_in(@user2)
      permission
      expect(@permission).to eq(3)
    end
 end
end
