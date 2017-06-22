# frozen_string_literal: true

# rubocop:disable ClassLength
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
  end

  def adjustment_period
    redirect_to allocation_period_path(params[:school_room_id]) if allocation_period?

    @school_room = SchoolRoom.find(params[:school_room_id])
    @departments = Department.all

    return_wing
  end

  def save_allocation_period
    save_in_period(create_solicitation, [], group_solicitation(params))
  end

  def save_adjustment_period
    solicitation = create_solicitation

    rooms = Room.where(id: params[:rooms])
    if rooms.size.zero?
      flash[:error] = 'Selecione ao menos uma sala'
      redirect_to allocation_period_path(solicitation.school_room.id)
    else
      save_in_period(solicitation, rooms, group_solicitation(params))
    end
  end

  def avaliable_rooms_by_department
    render inline: params.key?('allocations') ? avaliable_rooms.to_json : [].to_json
  end

  def index
    coordinator = Coordinator.find_by(user_id: current_user.id)
    department = if coordinator.nil?
                   Department.find_by(name: 'PRC')
                 else
                   coordinator.course.department
                 end

    @room_solicitations = RoomSolicitation.where(department: department)
                                          .group(:solicitation_id)
    @solicitations = []
    @room_solicitations.each do |room_solicitation|
      @solicitations << Solicitation.find_by(id:
                                             room_solicitation.solicitation.id,
                                             status: 0)
    end
  end

  private

  def avaliable_rooms
    avaliable_rooms = []
    reservations = convert_params_to_hash(params[:allocations])
    reservations = group_solicitation(reservations)

    rooms = filter_rooms_for_school_room(params[:school_room], params[:department])

    rooms.each do |room|
      next unless avaliable_room_day(reservations, room)
      avaliable_rooms.push [room, room.building, room.department, room.category]
    end
    avaliable_rooms
  end

  def allocation_period?
    Date.current < Period.find_by(period_type: 'Alocação').final_date
  end

  def solicitation_params
    params[:solicitation].permit(:departments, :justify, :school_room_id)
  end

  def save(group_solicitation, solicitation)
    if group_solicitation.size.zero?
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
          department = params[:solicitation][:departments]
          department = rooms[i].department_id if department.nil?
          solicitation.room_solicitation
                      .build(start: start, final: final, day: room_solicitation[:day],
                             room: rooms[i], department_id: department)
          i += 1
          break unless i < rooms.size
        end
      end
    end
    save(group, solicitation)
  end

  def create_solicitation
    solicitation_params
    Solicitation.new(justify: params[:solicitation][:justify], requester: current_user,
                     request_date: Date.current,
                     school_room_id: params[:solicitation][:school_room_id])
  end

  def return_wing
    north = south = 0

    @school_room.courses.each do |course|
      north += 1 if course.department.wing == 'NORTE'
      south += 1 if course.department.wing == 'SUL'
    end
    @wing = if north < south
              'SUL'
            elsif north > south
              'NORTE'
            else
              @school_room.courses[0].department.wing
            end
  end
end
# rubocop:enable ClassLength
