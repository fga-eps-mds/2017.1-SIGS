class SessionsController < ApplicationController
  def new
    render "new"
  end

  def create
    user = User.find_by(email: params[:session][:email])
      if user && user.authenticate(params[:session][:password])
        sign_in(user)
  end

  def destroy
  end
end
