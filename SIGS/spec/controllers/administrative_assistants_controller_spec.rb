require 'rails_helper'
require 'sessions_helper'

RSpec.describe AdministrativeAssistantsController, type: :controller do

  describe "Test methods of Controller AdministrativeAssistants" do

    before(:each) do
	    @user_adm = User.create(name: 'teste12', email: 'test@unb.br', cpf:'00000000000', registration:'0000009', password: '123456', active: true)
	    @inactive_user = User.create(name: 'teste12', email: 'test1@unb.br', cpf:'00000000001', registration:'0000000', password: '123333', active: false)
    	@administrative_assistant = AdministrativeAssistant.create(user_id:@user_adm.id)
      sign_in(@user_adm)
    end

    it "Should find non active users" do
      # expect(get :registration_request).to eq(@inactive_user)
      get :registration_request
      expect(response).to have_http_status(200)
    end

    it "Should active user" do
    	get :enable_registration, params: {id: @inactive_user.id}
      expect(flash[:success]).to eq("Usuário aprovado com sucesso")
    end

    it "Should destroy user" do
      get :decline_registration, params:{id: @inactive_user.id}
      expect(flash[:success]).to eq("Usuário recusado com sucesso")
    end
  end
end
