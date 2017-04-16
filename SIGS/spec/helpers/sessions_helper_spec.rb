require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do

  describe "Testing SessionsHelper methods" do

    before(:each) do
      @user = User.create(name: 'teste', email: 'test@test.com', password: '123', active: true)
      @department = Department.create(code:"123",name:"departmentTest")
      @course = Course.create(code:"123",name:"courseTest",department_id: @department.id)
      @coordinator = Coordinator.create(course_id: @course.id,department_id: @department.id, user_id: @user.id)
      sign_in(@user)
    end

    it "Should assign a user_id to session and find a level of permission to current user" do
     expect(session[:user_id]).to eq(@user.id)
     expect(@nvl).to eq(1)
    end

    it "Should find and assign a user to current_user" do
      current_user
      expect(@current_user).to eq(@user)
    end

    #it "Should prevent that a current_user can make a login again" do
      #block_access
      #expect(flash.now[:error]).to eq('Você já está logado')
      #except(response).to redirect_to(current_user_path)
    #end

 end
end
