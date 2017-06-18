# frozen_string_literal: true

# Api User Mailer class
class ApiUserMailer < ApplicationMailer
  def create_email(api_user, user)
    @api_user = api_user
    @user = user
    mail(to: 'danielmarques7@hotmail.com', subject: 'SIGS - API')
  end
end
