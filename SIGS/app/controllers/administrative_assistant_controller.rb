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
  end

  def remove_users
  end
end
