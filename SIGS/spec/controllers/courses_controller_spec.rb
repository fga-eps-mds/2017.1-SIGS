require 'rails_helper'

RSpec.describe CoursesController, type: :controller do

  describe "GET #courses_by_user" do
    it "returns http success" do
      get :courses_by_user
      expect(response).to have_http_status(:success)
    end
  end

end
