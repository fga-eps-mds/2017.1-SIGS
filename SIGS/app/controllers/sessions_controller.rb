class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
      if user && user.authenticate(params[:session][:password])
        sign_in(user)
        redirect_to current_user
      else
        render 'new'
      end
  end

  def destroy
  end
end
