require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "testqqcoisa" do
    it "Testing session instance" do
      get :new
      expect(response).to be_success
    end
  end
end
