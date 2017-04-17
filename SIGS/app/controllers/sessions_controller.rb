class SessionsController < ApplicationController
  before_action :block_access, except: [:destroy]
  def new
    render 'new'
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
      if @user && @user.authenticate(params[:session][:password])
        if @user.active == true
          sign_in(@user)
          redirect_to current_user , notice: 'Login realizado com sucesso'
        else
          flash.now[:error] =  'Sua conta não está ativa'
          render 'new'
        end
      else
        flash.now[:error] =  'Email ou senha incorretos'
        render 'new'
      end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
