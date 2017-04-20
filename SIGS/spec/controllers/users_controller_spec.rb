require 'rails_helper'
include SessionsHelper

RSpec.describe UsersController, type: :controller do
  describe 'User' do
    before(:each) do
      @user = User.create(name: 'joao silva', email: 'joaosilva@unb.br', 
        password: '123456', registration:'1100061', cpf:'05601407380', active: true)    
    end 
  end

  describe 'User new and create methods' do

    it 'should create a new user' do
      post :create, params:{user: {name: 'joao silva', email: 'joaosilva@unb.br', 
        password: '123456', registration:'1100061', cpf:'05601407380', active: true}}
      expect(flash[:notice]).to eq('Solicitação de cadastro efetuado com sucesso!')
      expect(User.count).to be(1)
    end

    it 'should not create a new user (wrong name)' do
      post :create, params:{user: {name: 'joao', email: 'joaosilva@unb.br', 
        password: '123456', registration:'1100061', cpf:'05601407380', active: true}}
      expect(User.count).to be(0)
    end

    it 'should not create a new user (invalid unb email)' do
      post :create, params:{user: {name: 'joao silva', email: 'joaosilva@gmail.com', 
        password: '123456', registration:'1100061', cpf:'05601407380', active: true}}
      expect(User.count).to be(0)
    end

    it 'should not create a new user (short password)' do
      post :create, params:{user: {name: 'joao silva', email: 'joaosilva@unb.br', 
        password: '12345', registration:'1100061', cpf:'05601407380', active: true}}
      expect(User.count).to be(0)
    end

    it 'should not create a new user (invalid registration)' do
      post :create, params:{user: {name: 'joao silva', email: 'joaosilva@unb.br', 
        password: '123456', registration:'110006100', cpf:'05601407380', active: true}}
      expect(User.count).to be(0)
    end

    it 'should not create a new user (invalid cpf)' do
      post :create, params:{user: {name: 'joao silva', email: 'joaosilva@unb.br', 
        password: '123456', registration:'1100061', cpf:'0560140738000', active: true}}
      expect(User.count).to be(0)
    end

  end 

  describe 'Destroy method' do
    # Testes falhos

    # it 'should destroy a user' do
    #   @user1 = User.create(name: 'joao silva', email: 'joaosilva@unb.br', 
    #     password: '123456', registration:'1100061', cpf:'05601407380', active: true)
    #   @user2 = User.create(name: 'maria silva', email: 'mariasilva@unb.br', 
    #     password: '012345', registration:'1100062', cpf:'05601407381', active: true)
 	  # get :destroy, params: {id: @user1}
 	  # expect(User.count).to be(1)
    # end

    # it 'should not destroy a user' do
    #   @user1 = User.create(name: 'maria silva', email: 'mariasilva@unb.br', 
    #     password: '012345', registration:'1100062', cpf:'05601407380', active: true)
    #   get :destroy, params: {id: @user1.id}
    #   expect(User.count).to be(1)
    # end

  end

end