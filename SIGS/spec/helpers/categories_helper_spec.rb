RSpec.describe CategoriesHelper, type: :helper do

  describe "Testing CategoriesHelper methods" do
    before(:each) do
      @user_adm = User.create(name: 'Luiz Guilherme', email: 'luiz@unb.br',
        password: '123456', registration:'1103061', cpf:'05601407350', active: true)
      @administrative_assistant = AdministrativeAssistant.create(user: @user_adm)
    end
    it 'should return all categories' do
      sign_in(@user_adm)
      all_categories
      expect(@categories).to eq(Category.all)
    end
  end
end
