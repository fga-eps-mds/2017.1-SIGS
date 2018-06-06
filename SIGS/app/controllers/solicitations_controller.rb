# frozen_string_literal: true

# rubocop:disable ClassLength
# Class to manager allocation solicitation
class SolicitationsController < ApplicationController
  include Schedule
  include PrepareSolicitationsToSave
  before_action :logged_in?
  before_action :authenticate_not_deg?
  before_action :authenticate_coordinator?, except: [:index, :show,
                                                     :avaliable_rooms_by_department,
                                                     :approve_solicitation,
                                                     :recuse_solicitation]

  def allocation_period
    school_room_id = params[:school_room_id]
    redirect_to adjustment_period_path(school_room_id) unless allocation_period?

    @school_room = SchoolRoom.find(params[:school_room_id])
    @departments = Department.where.not(id: current_user_department)
  end

  def adjustment_period
    redirect_to allocation_period_path(params[:school_room_id]) if allocation_period?

    @school_room = SchoolRoom.find(params[:school_room_id])
    @departments = Department.all

    return_wing(@school_room)
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
    department = current_user_department
    @department_rooms = Room.where(department: department)
    room_solicitations = RoomSolicitation.where(department: department)

    @solicitations = []
    room_solicitations.each do |room_solicitation|
      solicitation_validade = Solicitation.find_by(id:
                                                   room_solicitation
                                                   .solicitation.id,
                                                   status:
                                                   0)
      next if solicitation_validade.nil?
      @solicitations << solicitation_validade
    end
    # Solicitation.all apenas para fins de uso local, devido a regra de negocio
    # onde apenas o dono do departamento pode acessar as solicitacoes
    # @solicitations = Solicitation.all
  end

  def show
    render_params
  end

  def recuse_solicitation
    render_params
    if params[:justification].empty?
      flash[:error] = 'Justificativa é obrigatória'
      render :show
    else
      recuse
    end
  end

  def approve_solicitation
    @solicitation = Solicitation.find(params[:id])
    @room = Room.find_by(id: params[:room])
    @room_solicitations = RoomSolicitation.where(solicitation_id: @solicitation.id)
    @room_solicitations.each do |room_solicitation|
      room_solicitation.update(responder_id: current_user,
                               response_date: Date.today)
      @allocation = Allocation.new(user_id: current_user.id,
                                   school_room_id: @solicitation.school_room_id,
                                   day: room_solicitation.day,
                                   start_time: room_solicitation.start,
                                   final_time: room_solicitation.final, active: true)
      room_solicitation.update(status: validate_status_room(room_solicitation))
      @allocation.room_id = validade_room_for_approve(@room, room_solicitation)
      pass_to_all_allocation_dates_aux(@allocation)
    end
    validate_for_save_solicitation(@solicitation)
  end

  private

  def validate_status_room(room_solicitation)
    if !room_solicitation.room_id.nil?
      1
    else
      0
    end
  end

  def validade_room_for_approve(room, room_solicitation)
    if room_solicitation.room_id.nil?
      room.id
    else
      room_solicitation.room_id
    end
  end

  def validate_for_save_solicitation(solicitation)
    solicitation.status = 1
    return unless solicitation.save
    flash[:success] = 'Solicitação aprovada com successo'
    redirect_to solicitations_index_path
  end

  def pass_to_all_allocation_dates_aux(allocation)
    period = Period.find_by(period_type: 'Letivo')
    date = period.initial_date
    while date != period.final_date
      all_allocation_date = AllAllocationDate.new
      all_allocation_date.allocation_id = allocation.id

      %w[segunda terca quarta quinta sexta sabado].each_with_index do |day, index|
        next unless allocation.day == day && date.wday == index + 1
        all_allocation_date.day = date
        all_allocation_date.save
        all_allocation_date = nil
      end
      date += 1
    end
    allocation.save
  end

  def update_room_status(room_solicitation)
    room_solicitation.update(justify: params[:justification],
                             responder_id: current_user,
                             response_date: Date.today,
                             status: 2)
  end

  def avaliable_rooms
    reservations = convert_params_to_hash(params[:allocations])
    reservations = group_solicitation(reservations)

    rooms = filter_rooms_for_school_room(params[:school_room], params[:department])

    department_room(rooms, reservations)
  end

  def department_room(rooms, reservations)
    avaliable_rooms_hash = []
    rooms.each do |room|
      next unless avaliable_room_day(reservations, room)
      avaliable_rooms_hash.push [room, room.building, room.department, room.category]
    end
    avaliable_rooms_hash
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

  def return_wing(school_room)
    north = south = 0

    school_room.courses.each do |course|
      north += 1 if course.department.wing == 'NORTE'
      south += 1 if course.department.wing == 'SUL'
    end
    @wing = if north < south
              'SUL'
            elsif north > south
              'NORTE'
            else
              school_room.courses[0].department.wing
            end
  end

  def render_params
    @allocation = Allocation.new
    @rooms = Room.where(department_id: current_user_department)
    @solicitation = Solicitation.find(params[:id])
    @department = current_user_department
    return_wing(@solicitation.school_room)
    room = params[:room].nil? || params[:room].empty?
    @rooms_solicity = RoomSolicitation.where(solicitation_id:
                                                 @solicitation.id)
    @rooms_solicity = @rooms_solicity.where(room: params[:room]) unless room

    @allocation = ''
    @rooms_solicity.each do |room_solicitation|
      @allocation += "allocations[]=#{room_solicitation.day}"
      @allocation += "[#{room_solicitation.start.strftime('%H')}]"
    end
  end

  def recuse
    solicitation = Solicitation.find(params[:id])
    pending_requests = 0
    solicitation.room_solicitation.each do |room_solicitation|
      pending_requests += 1
      if room_solicitation.room.nil?
        update_room_status(room_solicitation)
        pending_requests -= 1
      elsif room_solicitation.room.id.to_s == params[:room]
        update_room_status(room_solicitation)
        pending_requests -= 1
      end
    end
    solicitation.update_attribute('status', 2) if pending_requests.zero?
    flash[:success] = 'Solicitacao recusada com successo'
    redirect_to current_user
  end
end
# rubocop:enable ClassLength
