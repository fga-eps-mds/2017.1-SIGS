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

    def buildings
      building = Building.find_by_code(params[:code])
      rooms = Room.where('building' => building.id)
      allocation = Allocation.where('room' => rooms.ids)
      @building_allocation = generate_return_building(building, allocation)
      render json: @building_allocation
    end

    def all_school_rooms
      @school_rooms = SchoolRoom.all
      render json: @school_rooms
    end

    def department_allocations
      @department = Department.find_by(code: params[:code])
      if !@department.nil?
        @allocations = Allocation.where(room: @department.rooms, active: true)
        department_allocations_to_json(@allocations)
      else
        render json: 'Nenhum departamento encontrado com esse código.'
      end
    end

    def discipline_allocations
      @discipline = Discipline.find_by(code: params[:code])
      if !@discipline.nil?
        @allocations = Allocation.where(school_room: @discipline.school_rooms,
                                        active: true)
        discipline_allocations_to_json(@allocations, params[:code])
      else
        render json: 'Nenhuma disciplina encontrada com esse código.'
      end
    end

    def school_rooms_of_room
      @room = Room.find_by(code: params[:code])
      @allocations = Allocation.where(room: @room, active: true)
      rooms_allocations_to_json(@allocations)
    end

    private

    def generate_return_building(building, allocations)
      hash = {}
      allocations.each do |allocation|
        hash[allocation.id] = {
          building_name: building.name,
          building_code: building.code,
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
      hash
    end

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
