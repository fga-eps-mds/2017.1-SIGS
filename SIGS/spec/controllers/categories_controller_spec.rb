require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  describe "Test methods of Controller Categories" do

    before(:each) do
      @user = User.create(name: 'joao silva', email: 'joaferrera@unb.br',
        password: '123456', registration:'1100069', cpf:'04601407380', active: true)
      @user_adm = User.create(name: 'Luiz Guilherme', email: 'luiz@unb.br',
        password: '123456', registration:'1103061', cpf:'05601407350', active: true)
      @administrative_assistant = AdministrativeAssistant.create(user: @user_adm)
      @deg = Deg.create(user: @user)
    end

    # Method new
    it 'should return a success response in view of new' do
      sign_in(@user_adm)
      get :new
      expect(response).to have_http_status(200)
    end

    it 'should return a new catogory' do
      sign_in(@user_adm)
      get :new
      expect(@category).to be_nil
    end

    it 'should return to sign_in if current_user is nil' do
      get :new
      expect(flash[:notice]).to eq('Você precisa estar logado')
    end

    it 'should denied the acess' do
      sign_in(@user)
      get :new
      expect(flash[:error]).to eq('Acesso Negado')
    end

    # Method create
    it 'should create a new category' do
      sign_in(@user_adm)
      post :create, params:{category: {name: 'Auditorio'}}
      expect(response).to redirect_to(categories_index_path)
      expect(flash[:success]).to eq('Categoria criada')
      expect(Category.count).to be(1)
    end

    it 'should not create a new category' do
      sign_in(@user_adm)
      post :create, params:{category: {name: ''}}
      expect(flash[:error]).to eq('Não foi possivel criar categoria. Categoria já registrada
                       ou campo de preechimento estava vazio.')
    end

    # Method edit
    it 'should return a success response in view of edit' do
      sign_in(@user_adm)
      @category = Category.create(name: 'Auditório')
      get :edit, params:{id: @category.id}
      expect(response).to have_http_status(200)
    end

    it 'should edit a category and check the change' do
      sign_in(@user_adm)
      @category = Category.create(name: 'Auditório')
      post :update, params:{id: @category.id,category: {name: 'Aditório2'}}
      @category_change = Category.find_by(id: @category.id)
      expect(@category_change.name).to eq('Aditório2')
      expect(response).to redirect_to(categories_index_path)
      expect(flash[:success]).to eq('Categoria atualizada com sucesso')
    end

    # Method index
    it 'should return all categories' do
      sign_in(@user_adm)
      get :index
      expect(@categories).to be_nil
      expect(response).to have_http_status(200)
      @category1 = Category.create(name: 'Auditório')
      @category2 = Category.create(name: 'Laboratorio')
      @categories = Category.all
      expect(@categories.count).to eq(2)
    end

    # Method destroy
    it 'should destroy a category and redirect to index path' do
      sign_in(@user_adm)
      @category = Category.create(name: 'Auditório')
      get :destroy, params:{id: @category.id}
      expect(response).to redirect_to(categories_index_path)
      expect(flash[:success]).to eq('Categoria excluída com sucesso')
    end

  end
end
