require 'rails_helper'

RSpec.describe ApiUsersController, type: :controller do

	describe 'User new and create methods for user API' do
		before(:each) do
			@user = User.create(name: 'joao silva', email: 'joaosilva@unb.br', password: '123456', registration:'1100061', cpf:'05601407380', active: true)
			administrative_assistant = AdministrativeAssistant.create(user: @user)
		 	sign_in(@user)
		 	#@user_api = ApiUser.create(name: "gesie", email: 'gesiel.freitas@unb.br', secret: "akjsdbnhfidsaknfjksdaj", token: "aksdhjfnajsdnfkjnd")
		end

    it 'should return new view' do
      get :new
      expect(response).to have_http_status(200)
    end

    it 'should create a new user for API' do
      post :create, params:{api_user: {name: 'Gesiel Freitas', email: 'gesiel@unb.br'}}
      expect(flash[:success]).to eq('Usuário de API salvo')
      expect(ApiUser.count).to be(1)
    end

    it 'should not create a new user for api (wrong name)' do
      post :create, params:{api_user: {name: '', email: 'gesiel@unb.br'}}
      expect(ApiUser.count).to be(0)
    end

    it 'should not create a new user (invalid unb email)' do
      post :create, params:{api_user: {name: 'Gesiel Freitas', email: 'gesiel@gmail'}}
      expect(flash[:error]).to eq('Usuário de API não foi salvo')
      expect(ApiUser.count).to be(0)
    end
  end

	describe 'Show methods' do
    before(:each) do
    	@user = User.create(name: 'joao silva', email: 'joaosilva@unb.br', password: '123456', registration:'1100061', cpf:'05601407380', active: true)
			administrative_assistant = AdministrativeAssistant.create(user: @user)
			sign_in(@user)
     	@user_api = ApiUser.create(name: "Gesiel Freitas", email: 'gesiel.freitas@unb.br', secret: "asdjbfjand", user_id: @user.id, token: "asdnfjasndf")
    end

    it 'should return new view' do
      get :index
      expect(response).to have_http_status(200)
    end

    it 'should return api user show' do
      get :show, params:{id: @user_api.id}
      expect(response).to have_http_status(200)
    end
	end

  describe 'Update method for api user' do
    before(:each) do
   		@user = User.create(name: 'joao silva', email: 'joaosilva@unb.br',
     	password: '123456', registration:'1100061', cpf:'05601407380', active: true)
			administrative_assistant = AdministrativeAssistant.create(user: @user)
     	sign_in(@user)
   		@user_api = ApiUser.create(name: 'Gesiel Freitas', email: 'gesiel.freitas@unb.br', secret: "asdjbfjand", user_id: @user.id, token: "asdnfjasndf")
  	end

   	it 'should return edit user' do
    	get :edit, params:{id: @user_api.id}
    	expect(response).to have_http_status(200)
  	end


    it "should update a user api" do
      put :update, params:{id: @user_api.id,api_user: {name: 'Wallacy Braz', email: @user_api.email}}
      expect(response).to redirect_to(api_users_show_path(@user_api.id))
      expect(flash[:success]).to eq('Usuário de API atualizado com sucesso')
    end

    it "should update a user api not success" do
      put :update, params:{id: @user_api.id,api_user: {name: 'Wallacy Braz', email: ''}}
      #expect(response).to redirect_to(api_users_show_path(@user_api.id))
      expect(flash[:error]).to eq('Usuário de API não pode ser atualizado')
    end
	end

  describe 'Destroy method for user api' do
	  before(:each) do
    	@user = User.create(name: 'joao silva', email: 'joaosilva@unb.br',
       	                	password: '123456', registration:'1100061',
       	                	cpf:'05601407380', active: true)
      administrative_assistant = AdministrativeAssistant.create(user: @user)
    	@user_1 = User.create(name: 'pedro panda', email: 'panda@unb.br',
       	                		password: '123456', registration:'1101361',
       	                		cpf:'73827077680', active: true)
	    AdministrativeAssistant.create(user: @user_1)
      @user_api = ApiUser.create(name: 'Gesiel Freitas', email: 'gesiel.freitas@unb.br',
																 secret: "asdjbfjand", user_id: @user.id,
																 token: "asdnfjasndf")
    end

    it 'should destroy user api' do
    	sign_in(@user)
    	get :destroy, params:{id: @user_api.id}
    	expect(flash[:success]).to eq('Usuário de API excluido com sucesso')
    	expect(response).to redirect_to(api_users_index_path)
    end

    it 'should destroy user not possible' do
      sign_in(@user_1)
      get :destroy, params:{id: @user_api.id}
      expect(flash[:error]).to eq('Usuário de API não pode ser excluido')
      expect(response).to redirect_to(api_users_index_path)
    end
	end
end
