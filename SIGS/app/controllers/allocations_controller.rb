# frozen_string_literal: true

# Controller Allocations class
class AllocationsController < ApplicationController
  before_action :logged_in?
  before_action :validade_permission_1

  def index
    @allocations = Allocation.all
  end

  def new
    @coordinator_rooms = current_user.coordinator.course.department.rooms
    @school_rooms_coordinator = current_user.coordinator.course.school_room
    @allocation = Allocation.new
  end

  def same_schedule_and_diferent_school_room(allocation, allocation_day_of_room)
    allocation_day_of_room.each do |allocation_day_room|
      discipline = allocation.school_room.discipline
      vacancies = allocation.school_room.vacancies
      if allocation_same_schedule(allocation, allocation_day_room) &&
         discipline == allocation_day_room.school_room.discipline &&
         vacancies > allocation_day_room.room.actual_capacity
        return true
      end
    end
  end

  def time_invalid(allocation)
    start = convert_start_time_to_i allocation
    final = convert_final_time_to_i allocation
    shift = allocation.school_room.courses.first.shift

    (((start - final) * -1 < 1) ||
      ((start - final) * -1 > 3)) ||
      ((shift == 1 && final > 18) ||
      (shift == 2 && start < 18))
  end

  def allocation_same_schedule(allocation, allocation_day_room)
    start_time = convert_start_time_to_i allocation
    final_time = convert_final_time_to_i allocation
    start_day_room = convert_start_time_to_i allocation_day_room
    final_day_room = convert_start_time_to_i allocation_day_room

    (start_time >= start_day_room &&
      start_time <= final_day_room) ||
      (final_time >= start_day_room &&
      final_time <= final_day_room)
  end

  def create
    @allocation = Allocation.new(allocation_params)
    @allocation.user_id = current_user.id
    @allocations_of_day_and_room = Allocation.where(
      day: @allocation.day,
      room_id: @allocation.room_id
    )
    return unless validate_alocation
    @allocation.room.actual_capacity -= @allocation.school_room.vacancies

    if @allocation.save
      flash[:sucess] = 'Alocação feita com sucesso'
    else
      flash[:error] = 'Alocação não realizada'
    end
  end

  private

  def validate_alocation
    if time_invalid(@allocation)
      flash[:error] = 'Horário inválido'
      return false
    else
      @allocations_of_day_and_room.each do |allocation_day_room|
        @no_save = allocation_same_schedule(@allocation, allocation_day_room)
      end
      if @no_save &&
         same_schedule_and_diferent_school_room(@allocation,
                                                @allocations_of_day_and_room)
        flash[:error] = 'Alocação com horário não vago'
        return false
      end
    end
    true
  end

  def allocation_params
    params[:allocation].permit(:room_id,
                               :school_room_id,
                               :day,
                               :start_time,
                               :final_time)
  end

  def convert_start_time_to_i(allocation)
    allocation.start_time.strftime('%H').to_i
  end

  def convert_final_time_to_i(allocation)
    allocation.final_time.strftime('%H').to_i
  end
end
