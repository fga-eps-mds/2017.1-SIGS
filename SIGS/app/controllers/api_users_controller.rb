# frozen_string_literal: true

# Controller do Usuario de API
class ApiUsersController < ApplicationController
  before_action :logged_in?

  def index
    @api_users = ApiUser.where(user_id: current_user.id)
  end

  def new
    @api_user = ApiUser.new
  end

  def create
    @api_user = ApiUser.new(api_user_params)
    @api_user.user_id = current_user.id
    @api_user = create_token(@api_user)
    if @api_user.save
      redirect_to api_users_new_path, flash: { success: 'Usuário de API salvo' }
    else
      redirect_to api_users_new_path, flash: { error: 'Usuário de API não foi salvo' }
    end
  end

  def destroy
    @api_user = ApiUser.find(params[:id])
    @api_user.destroy
  end

  private

  def api_user_params
    params[:api_user].permit(:name, :email)
  end

  def create_token(api_user)
    random_string = (0..7).map { ('a'..'z').to_a[rand(26)] }.join
    api_user.secret = BCrypt::Password.create(random_string)
    payload = { name: api_user.name, email: api_user.email }
    api_user.token = JWT.encode payload, api_user.secret, 'HS256'
    api_user
  end
end
