# frozen_string_literal: true

# Controller de API
class Api::ApisController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate

  def all_rooms
    @rooms = Room.all
    render json: @rooms
  end

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      decoded_token = JWT.decode token, nil, false
      email = decoded_token[0]['email']
      user = UserApi.find_by(email: email)
      ActiveSupport::SecurityUtils.secure_compare(
        ::Digest::SHA256.hexdigest(token),
        ::Digest::SHA256.hexdigest(user.token)
      )
    end
  end
end
