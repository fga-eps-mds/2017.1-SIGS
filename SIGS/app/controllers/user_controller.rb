class UserController < ApplicationController
  before_action :logged_in?, except: [:new,:create,:user_params]
  def new
		@user = User.new
    @user.build_department_assistant
    @user.build_coordinator
    @user.build_administrative_assistant
	end

  def show
      @user = User.find(params[:id])
  end

  #Creating a new user
  def create
  	@user = User.new(user_params)
    if @user.save
      if params[:tipo] == "adm"
        @administrative_assistant = AdministrativeAssistant.create(user_id: @user.id)
      end
      flash[:notice] = 'Cadastro efetuado com sucesso!'
    else
      render :new
    end
  end

  # Editing the user profile
  def edit
    @user = User.find(params[:id])
    #if @user != current_user
    #end
  end

  #Update User
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = t(:sucessful_profile_update)
      # Mandar para Show do tipo de usuário
    else
      redirect_to user_edit_path
      flash[:warning] = t(:error_profile_update)
    end
  end

  def destroy
    @user = User.find(params[:id])

    @users = User.all
    if @users.count > 1
      @user.destroy
      redirect_to root_path
    else
      redirect_to current_user
    end
  end

  private
  def user_params
    params[:user].permit(:name, :email, :password, :registration, :cpf, :active,
                          :coordinator_attributes => [:department_id,:course_id,:user_id],
                          :administrative_assistant_attributes => [:user_id,:user_id],
                          :department_assistant_attributes => [:department_id])

  end
end
