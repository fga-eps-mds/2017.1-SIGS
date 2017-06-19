class ApiUserMailerPreview < ActionMailer::Preview
  def create_email(api_user)
    ApiUserMailer.create_email(api_user)
  end
end
