require 'rails_helper'

RSpec.describe PeriodsController, type: :controller do
  describe 'Rooms controller methods' do
    before(:each) do
      @user = User.create(name: 'joao silva', email: 'joaosilva@unb.br',
        password: '123456', registration:'1100061', cpf:'05601407380', active: true)
      @administrative_assistant = AdministrativeAssistant.create(user: @user)
      sign_in(@user)
      @period = Period.create(period_type: 'Alocação', initial_date:'05/01/2018', final_date: '01/02/2018')
    end

    it 'should return all periods' do
      get :index
      expect(response).to have_http_status(200)
    end

    it 'should return edit periods' do
      get :edit, params:{id: @period.id}
      expect(response).to have_http_status(200)
    end

    it 'should update room with valid attributes' do
      get :update, params: {period: {id: @period.id, period_type:'Alocação', initial_date:'07/01/2018',end_date: '05/02/2018'} }
      expect(flash.now[:success]).to eq('Dados do período atualizados com sucesso')
    end

    it 'should not update room with invalid attributes' do
      get :update, params: {period: {id: @period.id, period_type:'Alocação', initial_date:'05/10/2018',end_date: '05/02/2018'} }
      expect(flash.now[:error]).to eq('Dados do período não foram atualizados')
    end
  end
end
