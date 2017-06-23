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

    def all_school_rooms
      @school_rooms = SchoolRoom.all
      render json: @school_rooms
    end

    def school_rooms_of_room
      @room = Room.find_by(code: params[:code])
      @allocations = Allocation.where(room: @room, active: true)
      rooms_allocations_to_json(@allocations)
    end

    private

    def rooms_allocations_to_json(allocations)
      count = 0
      hash = []
      allocations.each do |allocation|
        hash[count] = {
          discipline_name: allocation.school_room.discipline.name,
          discipline_code: allocation.school_room.discipline.code,
          school_room_name: allocation.school_room.name,
          school_room_vacancies: allocation.school_room.vacancies,
          allocation_day: allocation.day,
          allocation_start_time: allocation.start_time.strftime('%H:%M'),
          allocation_final_time: allocation.final_time.strftime('%H:%M')
        }
        count += 1
      end
      render json: hash
    end

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
