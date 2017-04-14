class AdministrativeAssistantController < ApplicationController
  def registration_request
  end

  def edit
  end

  def update

  end

  def show
    @administrative_assistant = AdministrativeAssistant.find(params[:id])
    @user = User.find(@administrative_assistant.user_id)
  end

  def destroy
    @administrative_assistant = AdministrativeAssistant.find(params[:id])
    @user = User.find(@administrative_assistant.user_id)
    @user.destroy
  end

  def enable
  end

  def approve_registration
  end

  def approve_allocation
  end

  def index_users
    @users = User.all
  end

  def view_users
  end

  def edit_users
    @user = User.find(params[:id])
  end

  def update_users
    @user = User.find(params[:id])
    @user.update(
                name:users_update_params[:name],
                email:users_update_params[:email],
                cpf:users_update_params[:cpf],
                registration:users_update_params[:registration]
                )
    redirect_to index_users_path
  end

  def destroy_users
    @user = User.find(params[:id])
    @user.destroy
    redirect_to index_users_path
  end





  def users_update_params
    permitted = params.require(:user).permit(:name, :email, :cpf, :registration)
  end
end
