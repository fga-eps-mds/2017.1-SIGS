require 'rails_helper'
include SessionsHelper

RSpec.describe SchoolRoomsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe 'SchoolRooms methods' do

    before(:each) do
      @user = User.create(name: 'joao silva', email: 'joaosilva@unb.br',
        password: '123456', registration:'1100061', cpf:'05601407380', active: true)
      @department = Department.create(name: 'Departamento de Matemática', code: "007")
      @course = Course.create(name:"Matemática", code: "009", department: @department)
      @discipline = Discipline.create(name: "Anãlise Combinatória", code: "123", department: @department)
      @coordinator = Coordinator.create(user: @user, course: @course)
    end

    it 'should return new view2' do
      post :new
      expect(response).to have_http_status(200)
    end

    it 'should return new view' do
      sign_in(@user)
      get :new
      expect(@school_room).to be_nil
    end

    it 'should create a new school room' do
      sign_in(@user)
      post :create, params:{school_room: {name: 'AA', discipline_id: @discipline.id, course_ids: ["", @course.id]}}
      expect(flash[:success]).to eq("Turma criada")
      expect(SchoolRoom.count).to be(1)
    end

# Esse teste não ta encontrando a rota delete

    # it 'should delete a existing school room' do
    #   sign_in(@user)
    #   @school_room = SchoolRoom.create(name: 'Turma SS', active: true, 
    #     discipline_id: 1)
    #   delete :delete, params:{id: @school_room.id}
    #   expect(flash[:success]).to eq('A turma foi excluída com sucesso')
    # end

  end

end
