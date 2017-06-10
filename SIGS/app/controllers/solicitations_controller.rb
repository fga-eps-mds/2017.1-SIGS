# frozen_string_literal: true

# Class to manager allocation solicitation
class SolicitationsController < ApplicationController
  include Schedule
  include PrepareSolicitationsToSave
  before_action :logged_in?

  def allocation_period
    school_room_id = params[:school_room_id]
    redirect_to adjustment_period_path(school_room_id) unless allocation_period?

    @school_room = SchoolRoom.find(params[:school_room_id])
    @departments = Department.all
    @shift = @school_room.courses[0].shift
  end

  def adjustment_period
    redirect_to allocation_period_path(params[:school_room_id]) if allocation_period?

    school_room_id = params[:school_room_id]
    redirect_to allocation_period_path(school_room_id) if allocation_period?

    @school_room = SchoolRoom.find(params[:school_room_id])
    @departments = Department.all
    @shift = @school_room.courses[0].shift
  end

  def save_allocation_period
    solicitation = create_solicitation

    save_in_period(solicitation, [], group_solicitation(params))
  end

  def save_adjustment_period
    solicitation = create_solicitation

    rooms = Room.where(id: params[:rooms])
    if rooms.size.zero?
      flash[:error] = 'Selecione ao menos uma sala'
      redirect_to allocation_period_path(solicitation.school_room.id)
      return
    end
    save_in_period(solicitation, rooms, group_solicitation(params))
  end

  def avaliable_rooms_by_department
    require 'json'
    rooms = []
    rooms = avaliable_rooms if params.key? 'allocations'
    render inline: rooms.to_json
  end

  private

  def avaliable_rooms
    avaliable_rooms = []
    reservations = convert_params_to_hash(params[:allocations])
    reservations = group_solicitation(reservations)

    rooms = filter_rooms_for_school_room(params[:school_room], params[:department])

    rooms.each do |room|
      next unless avaliable_room_day(reservations, room)
      avaliable_rooms.push [room, room.building, room.department]
    end
    avaliable_rooms
  end

  def allocation_period?
    now = Date.current
    now < Period.find_by(period_type: 'Alocação').final_date
  end

  def solicitation_params
    params[:solicitation].permit(:departments, :justify, :school_room_id)
  end

  def save(group_solicitation, solicitation)
    size = group_solicitation.size
    if size.zero?
      flash[:error] = 'Selecione o horário que deseja'
      redirect_to allocation_period_path(solicitation.school_room.id)
    elsif solicitation.save
      success_message = 'Solicitação Enviada'
      redirect_to school_rooms_index_path, flash: { success: success_message }
    else
      ocurred_errors(solicitation)
      redirect_to allocation_period_path(solicitation.school_room.id)
    end
  end

  def save_in_period(solicitation, rooms, group)
    group.each do |row|
      row.each do |room_solicitation|
        start = "#{room_solicitation[:start_time]}:00"
        final = "#{room_solicitation[:final_time]}:00"
        i = 0
        loop do
          solicitation.room_solicitation
                      .build(start: start,
                             final: final,
                             day: room_solicitation[:day],
                             room: rooms[i])
          i += 1
          break unless i < rooms.size
        end
      end
    end
    save(group, solicitation)
  end

  def create_solicitation
    solicitation_params
    Solicitation.new(justify: params[:solicitation][:justify],
                     request_date: Date.current,
                     requester: current_user,
                     school_room_id: params[:solicitation][:school_room_id])
  end
end
