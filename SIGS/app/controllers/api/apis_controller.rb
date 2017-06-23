# frozen_string_literal: true

# Module de API
module Api
  # Controller de API
  class ApisController < ApplicationController
    include ActionController::HttpAuthentication::Token::ControllerMethods

    before_action :authenticate?

    def all_rooms
      @rooms = Room.all
      render json: @rooms
    end

    def all_school_room
      allocations = Allocation.all
      @school_room = generate_school_room(allocations)
      render json: @school_room
    end

    def generate_school_room(allocations)
      hash = {}
      allocations.each do |allocation|
        hash[allocation.id] = {
          discipline_name: allocation.school_room.discipline.name,
          discipline_code: allocation.school_room.discipline.code,
          school_room_name: allocation.school_room.name,
          school_room_vacancies: allocation.school_room.vacancies,
          room_name: allocation.room.name,
          room_capacity: allocation.room.capacity
        }
      end
      hash
    end

    private

    def authenticate?
      authenticate_or_request_with_http_token do |token, _options|
        decoded_token = JWT.decode token, nil, false
        email = decoded_token[0]['email']
        user = ApiUser.find_by(email: email)
        unless user.nil?
          ActiveSupport::SecurityUtils.secure_compare(
            ::Digest::SHA256.hexdigest(token),
            ::Digest::SHA256.hexdigest(user.token)
          )
        end
      end
    end
  end
end
