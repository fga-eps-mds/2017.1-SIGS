class UserController < ApplicationController
  def new
		@user = User.new

      @user.build_department_assistant
      @user.build_coordinator
      @user.build_administrator_assistant
	end

  #Creating a new user
  def create
  	@user = User.new(user_params)
    if @user.save
      #usuario criado com sucesso
    end
  end

  # Editing the user profile
  def edit
    if @user != current_user
    end
  end

  #Update User
  def update
    if @user.update(user_params)
      flash[:success] = t(:sucessful_profile_update)
      redirect_to @user
    else
      flash[:warning] = t(:error_profile_update)
    end
  end


  private
  def user_params
    params[:user].permit(:name, :email, :password, :registration, :cpf, :active,
                          :coordinator_attributes => [:department_id,:course_id],
                          :administrative_assistant_attributes => [],
                          :department_assistant_attributes => [:department_id])
  end
end
