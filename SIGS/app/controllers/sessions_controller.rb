class SessionsController < ApplicationController
  before_action :block_access, except: [:destroy]
  def new
    render 'new'
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
      if @user && @user.authenticate(params[:session][:password])
        sign_in(user)
        redirect_to current_user , notice: 'Login realizado com sucesso'
      else
        flash.now[:notice] = 'Email ou senha inválidos'
        render 'new'
      end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
