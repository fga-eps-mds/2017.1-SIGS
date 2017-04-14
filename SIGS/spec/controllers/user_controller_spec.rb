require 'rails_helper'

RSpec.describe UserController, type: :controller do
  describe 'User' do
		before(:each) do
			@user = User.create(name: 'teste', email: 'test@test.com', password: '123', active: true)
		end
end
