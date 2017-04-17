class AdministrativeAssistantController < ApplicationController

  # Funções de edição do próprio usuário

  def show
    @administrative_assistant = AdministrativeAssistant.find(params[:id])
    @user = User.find(@administrative_assistant.user_id)
  end

  def registration_request
    @users = User.where(active: false)
  end

  def enable_registration
    @user = User.find(params[:id])
    @user.update_attributes(active: true)
    redirect_to registration_request_path
  end

  def decline_registration
    @user = User.find(params[:id])
    @user.destroy
  end

  #Funções de edição de outros usuários
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

    @users = User.all
    if @users.count > 1
      @user.destroy
      redirect_to index_users_path
    else
      redirect_to current_user
    end
  end

  private
  def users_update_params
    params.require(:user).permit(:name, :email, :cpf, :registration)
  end

  def administrative_assistant_params
    params[:administrative_assistant].permit(:user_id)
  end
end
