class SessionsController < ApplicationController
  before_action :block_access, except: [:destroy]
  def new
    render 'new'
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
      if @user && @user.authenticate(params[:session][:password]) && @user.active == true
        sign_in(@user)
        flash[:success] = 'Login efetuado com sucesso!'
        redirect_to current_user
      else
        render 'new'
      end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
