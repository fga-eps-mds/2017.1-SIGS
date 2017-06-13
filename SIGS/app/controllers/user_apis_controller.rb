# frozen_string_literal: true

# Controller do Usuario de API
class UserApisController < ApplicationController
  def new
    @user_api = UserApi.new
  end

  def create
    @user_api_mount = UserApi.new(user_api_params)
    @user_api = create_token(@user_api_mount)
    if @user_api.save
      redirect_to user_apis_new_path, flash: { success: 'Token salvo' }
    else
      redirect_to user_apis_new_path, flash: { error: 'Token não foi salvo' }
    end
  end

  private

  def user_api_params
    params[:user_api].permit(:name, :email)
  end

  def create_token(user_api)
    user_api.secret = BCrypt::Password.create(user_api.email)
    payload = { name: user_api.name, email: user_api.email }
    user_api.token = JWT.encode payload, user_api.secret, 'HS256'
    user_api
  end
end
