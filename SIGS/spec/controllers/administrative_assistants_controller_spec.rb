require 'rails_helper'

RSpec.describe AdministrativeAssistantsController, type: :controller do

  describe "Test methods of Controller AdministrativeAssistants" do

    before(:each) do
	    @user0 = User.create(name: 'teste12', email: 'test@unb.br', cpf:'00000000000', registration:'0000009', password: '123456', active: true)
	    @user1 = User.create(name: 'teste12', email: 'test1@unb.br', cpf:'00000000001', registration:'0000000', password: '123333', active: false)
    	@administrative_assistant = AdministrativeAssistant.create(user_id:@user1.id)
    end

    # it "Should find non active users" do
    #   expect(get :registration_request).to include(@user1)
    # end

    it "Should active user" do
    	get :enable_registration, params: {id: @user1.id}
      expect(flash[:success]).to eq("Usuário aprovado com sucesso") 
    end

    it "Should destroy user" do
      get :decline_registration, params:{id: @user1.id}
      @administrative_assistant2 = AdministrativeAssistant.create(user_id:@user0.id)
      expect(flash[:success]).to eq("Usuário recusado com sucesso")
    end

    #  it "Shouldn't destroy user" do
    #   get :decline_registration, params:{id: @user1.id}
    #   expect(flash[:error]).to eq("Não foi possivel recusar o usuário")
    # end

  end
end
