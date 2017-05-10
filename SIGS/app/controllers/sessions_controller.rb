class SessionsController < ApplicationController
  def new
    if current_user.present?
      redirect_to current_user , notice: 'Você já está logado'
    else
      render 'new'
    end
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
      if @user && @user.authenticate(params[:session][:password])
        active(@user)
      else
        flash[:error] =  'Email ou senha incorretos'
        render 'new'
      end
  end

  def destroy
    sign_out
    redirect_to root_url , notice: 'Usuário deslogado com sucesso'
  end

  def active(user)
    if user.active == true
      sign_in(user)
      redirect_to current_user , notice: 'Login realizado com sucesso'
    else
      flash[:error] =  'Sua conta não está ativa'
      render 'new'
    end
  end
end
