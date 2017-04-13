class AdministrativeAssistantController < ApplicationController
  def new
    @administrative_assistant = AdministrativeAssistant.new
  end

  def create
    @administrative_assistant = AdministrativeAssistant.create(administrative_assistant_params)
    if @administrative_assistant.save    
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

  private
  def administrative_assistant_params
    params[:administrative_assistant].permit(:user_id)
end
