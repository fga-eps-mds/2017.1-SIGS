require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  
  describe "Test methods of Controller Sessions" do

    before(:each) do
      @user = User.create(name: 'teste', email: 'test@test.com', password: '123', active: true)
      @user1 = User.create(name: 'teste1', email: 'test1@test.com', password: '123', active: false)
    end

    it "Testing session instance" do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "Should create a session with corrects arguments" do
      post :create ,params: {session: {email: 'test@test.com',password: '123'}}
      expect(session[:user_id]).to eq(@user.id)
      expect(flash[:notice]).to eq('Login realizado com sucesso')
    end

    it "Should not create a session with wrong arguments(password) " do
      post :create ,params: {session: {email: 'test@test.com',password: '1234'}}
      expect(flash.now[:error]).to eq('Email ou senha incorretos')
    end

    it "Should not create a session with wrong arguments(email) " do
      post :create ,params: {session: {email: 'test123@test.com',password: '123'}}
      expect(flash.now[:error]).to eq('Email ou senha incorretos')
    end

    it "Should not create a session if user isn't active" do
      post :create ,params: {session: {email: 'test1@test.com',password: '123'}}
      expect(flash.now[:error]).to eq('Sua conta não está ativa')
    end

    it "Should destroy a session and redirect to root_url" do
      post :create ,params: {session: {email: 'test@test.com',password: '123'}}
      delete :destroy
      expect(session[:user_id]).to eq(nil)
      expect(@current_user).to eq(nil)
      expect(response).to redirect_to(root_url)
    end

  end
end
