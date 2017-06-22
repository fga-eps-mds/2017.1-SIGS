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

    def department_allocations
      @rooms = Department.find_by(code: params[:code]).rooms
      @allocations = Allocation.where(room: @rooms)
      department_allocations_to_json(@allocations)
    end

    def discipline_allocations
      @school_rooms = Discipline.find_by(code: params[:code]).school_rooms
      @allocations = Allocation.where(school_room: @school_rooms)
      discipline_allocations_to_json(@allocations, params[:code])
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

    def department_allocations_to_json(allocations)
      hash = {}
      allocations.each do |allocation|
        hash[allocation.room.code] = {
          room_name: allocation.room.name,
          room_capacity: allocation.room.capacity,
          discipline_name: allocation.school_room.discipline.name,
          discipline_code: allocation.school_room.discipline.code,
          school_room_name: allocation.school_room.name,
          school_room_vacancies: allocation.school_room.vacancies,
          allocation_day: allocation.day,
          allocation_start_time: allocation.start_time.strftime('%H:%M'),
          allocation_final_time: allocation.final_time.strftime('%H:%M')
        }
      end
      render json: { rooms_code: hash }
    end

    def discipline_allocations_to_json(allocations, code)
      hash = {}
      allocations.each do |allocation|
        hash[code] = {
          building_name: allocation.room.building.name,
          department_name: allocation.room.department.name,
          department_code: allocation.room.department.code,
          room_name: allocation.room.name,
          room_code: allocation.room.code,
          room_capacity: allocation.room.capacity,
          school_room_name: allocation.school_room.name,
          school_room_vacancies: allocation.school_room.vacancies,
          allocation_day: allocation.day,
          allocation_start_time: allocation.start_time.strftime('%H:%M'),
          allocation_final_time: allocation.final_time.strftime('%H:%M')
        }
      end
      render json: { discipline_code: hash }
    end
  end
end
