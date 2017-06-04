# frozen_string_literal: true

# class that create allocations
class AllocationsController < ApplicationController
  before_action :logged_in?
  before_action :validade_permission_1


  def new
    @allocations = []
    84.times do
      @allocations << Allocation.new
    end
    @school_room = SchoolRoom.find(params[:school_room_id])
    @school_room_allocations = Allocation.where(school_room_id: @school_room.id)
    @coordinator_rooms = current_user.coordinator.course.department.rooms
    @school_rooms_coordinator = current_user.coordinator.course.school_rooms
  end


  def create
    group_allocation = []
    allocation = params[:Segunda][1]

    [:Segunda, :Terça, :Quarta, :Quinta, :Sexta, :Sábado].each do |day_of_week|
      exist = false
      (0..(params[day_of_week].count-1)).each do |index|
        next if params[day_of_week][index].count == 1
        if params[day_of_week][index][:active] == '1' && !exist
          group_allocation.push params[day_of_week][index]
          exist = true
        elsif params[day_of_week][index][:active] == '1'
          group_allocation.last[:final_time] = params[day_of_week][index][:final_time]
        else
          exist = false
        end
      end
    end
    group_allocation.each do |allocation|
      save_allocation(allocation)
    end
    puts "=" * 30
    puts params[:Segunda][0].inspect
    redirect_to allocations_new_path(params[:Segunda][0][:school_room_id])
  end

  def save_allocation(allocation)
    @allocation = Allocation.new(allocations_params(allocation))
    if @allocation.active
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
            flash[:success] = 'Alocação feita com sucesso'
          else
            flash[:error] = 'Falha ao realizar alocação'
          end
        end
      end
    end
  end

  def destroy
    @allocation = Allocation.find(params[:id])
    @allocation.destroy
    flash[:success] = 'Alocação excluída com sucesso'
    redirect_to current_user
  end

  def room_allocations_by_day
    require 'json'

    data = []
    (6..23).each do |hour|
      data << make_rows(hour)
    end
    render inline: data.to_json
  end

  private

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

  def allocation_params
    params[:allocation].permit(:room_id,
                               :school_room_id,
                               :day,
                               :start_time,
                               :final_time,
                               :active)
  end

  def allocations_params(my_params)
    my_params.permit(:room_id,
                     :school_room_id,
                     :day,
                     :start_time,
                     :final_time,
                     :active)
  end

  def make_rows(hour)
    @row = [(hour).to_s + ':00']
    %w[Segunda Terça Quarta Quinta Sexta Sabado].each do |day_of_week|
      allocations = Allocation.where(room_id: params[day_of_week]).where(day: day_of_week)
      allocations_start = allocations.where('DATE_FORMAT(start_time, "%H") <= ?', hour)
                                .where('DATE_FORMAT(final_time, "%H") > ?', hour)
      make_cell(allocations_start, hour, allocations, Room.find(params[day_of_week].to_i))
    end
    @row
  end

  def make_cell(allocations_start, hour, allocations, room)
    cell = ''
    if allocations_start.size.zero?
      cell = ' '
    else
      cell = ''
      exist = false
      allocations_start.each do |allocation|
        cell += allocation.school_room.discipline.name unless exist
        cell += "<br>Turma:" +
                allocation.school_room.name
        exist = true
      end
    end
    data_allocation =  []
    data_allocation.push cell
    data_allocation.push params[:school_room]
    data_allocation.push room.id
    data_allocation.push hour.to_s
    data_allocation.push (hour + 1).to_s
    data_allocation.push SchoolRoom.find(params[:school_room]).courses.first.shift
    @row << data_allocation

  end
end
