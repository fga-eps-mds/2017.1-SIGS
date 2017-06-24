# frozen_string_literal: true

# class that manages registration process
class AdministrativeAssistantsController < ApplicationController
  before_action :logged_in?
  before_action :authenticate_administrative_assistant?

  def registration_request
    @users = User.where(active: 0)
  end

  def enable_registration
    @user = User.find(params[:id])
    if @user.update_attribute(:active, 1)
      flash[:success] = 'Usuário aprovado com sucesso'
    end
    redirect_to registration_request_path
  end

  def decline_registration
    @user = User.find(params[:id])
    if @user
      @user.destroy
      flash[:success] = 'Usuário recusado com sucesso'
    end
    redirect_to registration_request_path
  end

  def destroy_users
    @user = User.find(params[:id])
    return unless @user
    @user.update_attribute('active', 2)
    redirect_to user_index_path, flash: { success: 'Usuário excluído com sucesso' }
  end
end
