class AdministrativeAssistantsController < ApplicationController
  before_action :logged_in?
  before_action :authenticate_administrative_assistant?

  def registration_request
    @users = User.where(active: false)
    @users
  end

  def enable_registration
    @user = User.find(params[:id])
    if @user.update_attributes(active: true)
      flash[:success] = 'Usuário aprovado com sucesso'
    end
    else
    end
    redirect_to registration_request_path
  end

  def decline_registration
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = 'Usuário recusado com sucesso'
    end
    redirect_to registration_request_path
  end
  
  def destroy_users
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to user_index_path, flash: { sucess: 'Usuário excluído com sucesso' }
    end
  end
end
