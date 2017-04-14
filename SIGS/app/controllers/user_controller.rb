class UserController < ApplicationController
  def new
    @user = User.new
  end

  #Creating a new user
  def create
  	@user = User.new(user_params)
    if @user.save
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

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :registration, :cpf, :active)
  end
end
