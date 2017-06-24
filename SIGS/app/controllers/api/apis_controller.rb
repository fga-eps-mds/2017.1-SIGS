# frozen_string_literal: true

# Module de API
require 'api/aux_apis'
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
      @school_room = AuxApis.generate_school_room(allocations)
      render json: @school_room
    end

    def department_allocations
      @department = Department.find_by(code: params[:code])
      if !@department.nil?
        @allocations = Allocation.where(room: @department.rooms, active: true)
        render json: AuxApis.department_allocations_to_json(@allocations)
      else
        render json: 'Nenhuma departamento encontrado com esse código.'
      end
    end

    def discipline_allocations
      @discipline = Discipline.find_by(code: params[:code])
      if !@discipline.nil?
        @allocations = Allocation.where(school_room: @discipline.school_rooms,
                                        active: true)
        render json: AuxApis.discipline_allocations_to_json(@allocations, params[:code])
      else
        render json: 'Nenhuma disciplina encontrada com esse código.'
      end
    end

    def school_rooms_of_room
      @room = Room.find_by(code: params[:code])
      @allocations = Allocation.where(room: @room, active: true)
      render json: AuxApis.rooms_allocations_to_json(@allocations)
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
