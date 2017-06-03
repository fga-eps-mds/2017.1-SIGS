# frozen_string_literal: true

# class that create allocations
class AllocationsController < ApplicationController
  before_action :logged_in?

  def index
    @allocations = Allocation.all
  end

  def new
    @allocation = Allocation.new
    @coordinator_rooms = current_user.coordinator.course.department.rooms
    @school_rooms_coordinator = current_user.coordinator.course.school_rooms
  end

  def same_schedule_and_diferent_school_room(allocation)
    allocatios_vacancies = 0
    allocations_same = Allocation.where(room_id: allocation.room_id,
                                             day: allocation.day,
                                             start_time: allocation.start_time,
                                             final_time: allocation.final_time)
    allocations_same.each do |allocation_aux|
      if  allocation.school_room == allocation_aux.school_room ||
          allocation.school_room.discipline != allocation_aux.school_room.discipline
          return false
      end
      allocatios_vacancies = allocatios_vacancies + allocation_aux.school_room.vacancies
    end
      if allocatios_vacancies + allocation.school_room.vacancies <= allocation.room.capacity
        return true
      else
        return false
      end
  end

  def time_invalid allocation
    start = allocation.start_time.strftime('%H').to_i
    final = allocation.final_time.strftime('%H').to_i

    if ((start - final)* -1 < 1) ||
       ((start - final)* -1 > 3) ||
       (allocation.school_room.courses.first.shift == 1 && final > 18) ||
       (allocation.school_room.courses.first.shift == 2 && start < 18)
         return true
    end
  end

  def create
    @allocation = Allocation.new(allocation_params)
    @allocation.user_id = current_user.id
    @allocations_of_day_and_room = Allocation.where(day: @allocation.day ,room_id: @allocation.room_id)
    @no_save = 0
    if time_invalid @allocation
      flash[:error] = 'Horário inválido'
    else
      @allocations_of_day_and_room.each do |allocation_day_room|
        if ((@allocation.start_time.strftime('%H').to_i >= allocation_day_room.start_time.strftime('%H').to_i &&
            @allocation.start_time.strftime('%H').to_i <= allocation_day_room.final_time.strftime('%H').to_i) ||
            (@allocation.final_time.strftime('%H').to_i >= allocation_day_room.start_time.strftime('%H').to_i &&
            @allocation.final_time.strftime('%H').to_i <= allocation_day_room.final_time.strftime('%H').to_i))
            @no_save = 1
        end
      end
      if @no_save == 1 && same_schedule_and_diferent_school_room(@allocation) == false
        flash[:error] = 'Alocação com horário não vago ou capacidade da sala cheia'
      else
        if @allocation.save
          pass_to_all_allocation_dates @allocation
          flash[:success] = 'Alocação feita com sucesso'
        else
          flash[:error] = 'Falha ao realizar alocação'
        end
      end
    end
    redirect_to allocations_new_path
  end

  def destroy
    @allocation = Allocation.find(params[:id])
    @allocation.destroy
    flash[:success] = 'Alocação excluída com sucesso'
    redirect_to current_user
  end

  def pass_to_all_allocation_dates allocation

    period = Period.find_by(period_type: 'Letivo')
    date = period.initial_date
      while date != period.final_date do
        all_allocation_date = AllAllocationDate.new
        all_allocation_date.allocation_id = allocation.id

        if allocation.day == "Segunda" && date.wday == 1
          all_allocation_date.day = date
          all_allocation_date.save
          all_allocation_date = nil
        elsif allocation.day == "Terça" && date.wday == 2
          all_allocation_date.day = date
          all_allocation_date.save
          all_allocation_date = nil
        elsif allocation.day == "Quarta" && date.wday == 3
          all_allocation_date.day = date
          all_allocation_date.save
          all_allocation_date = nil
        elsif allocation.day == "Quinta" && date.wday == 4
          all_allocation_date.day = date
          all_allocation_date.save
          all_allocation_date = nil
        elsif allocation.day == "Sexta" && date.wday == 5
          all_allocation_date.day = date
          all_allocation_date.save
          all_allocation_date = nil
        elsif allocation.day == "Sabado" && date.wday == 6
          all_allocation_date.day = date
          all_allocation_date.save
          all_allocation_date = nil
        end
        date = date + 1
    end
  end

  private

  def allocation_params
    params[:allocation].permit(:room_id,
                               :school_room_id,
                               :day,
                               :start_time,
                               :final_time)
  end
end
