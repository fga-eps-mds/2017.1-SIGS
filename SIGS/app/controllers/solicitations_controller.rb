# frozen_string_literal: true

# Class to manager allocation solicitation
class SolicitationsController < ApplicationController
  before_action :logged_in?

  def index
    if allocation_period?
      redirect_to allocation_period_path(params[:school_room_id])
    else
      redirect_to adjustment_period_path(params[:school_room_id])
    end
  end

  def allocation_period
    school_room_id = params[:school_room_id]
    redirect_to adjustment_period_path(school_room_id) unless allocation_period?

    @school_room = SchoolRoom.find(params[:school_room_id])
    @departments = Department.all
    @shift = @school_room.courses[0].shift
  end

  def save_allocation_period
    solicitation_params
    school_room = SchoolRoom.find(params[:solicitation][:school_room_id])
    solicitation = Solicitation.new(justify: params[:solicitation][:justify],
                                    request_date: Date.current,
                                    requester: current_user,
                                    school_room: school_room)

    group_solicitation.each do |room_solicitation|
      start = "#{room_solicitation[0][:start_time]}:00"
      final = "#{room_solicitation[0][:final_time]}:00"
      solicitation.room_solicitation.build(start: start,
                                           final: final,
                                           day: room_solicitation[0][:day])
    end
    save(group_solicitation, solicitation, school_room)
  end

  def adjustment_period
    redirect_to allocation_period_path(params[:school_room_id]) if allocation_period?
  end

  private

  def allocation_period?
    now = Date.current
    now < Period.find_by(period_type: 'Alocação').final_date
  end

  def solicitation_params
    params[:solicitation].permit(
      :departments,
      :justify,
      :school_room_id
    )
  end

  def group_solicitation
    group_room_solicitation = []
    weeks = %w[segunda terca quarta quinta sexta sabado]
    weeks.each do |day_of_week|
      rows = row_mount(day_of_week)
      group_room_solicitation.push rows unless rows.size.zero?
    end
    group_room_solicitation
  end

  def row_mount(day_of_week)
    exist = false
    rows = []
    (6..24).each do |index|
      next if params[day_of_week].nil?

      if !params[day_of_week][index.to_s].nil? && !exist
        room_solicitation = { start_time: index,
                              final_time: index + 1,
                              day: day_of_week }
        rows.push room_solicitation
        exist = true
      elsif !params[day_of_week][index].nil?
        rows.last[:final_time] = index + 1
      else
        exist = false
      end
      # puts rows.inspect
    end
    rows
  end

  def save(group_solicitation, solicitation, school_room)
    size = group_solicitation.size
    if size.zero?
      flash[:error] = 'Selecione o horário que deseja'
      redirect_to allocation_period_path(school_room.id)
    elsif solicitation.save
      success_message = 'Solicitação Enviada'
      redirect_to school_rooms_index_path, flash: { success: success_message }
    else
      ocurred_errors(solicitation)
      redirect_to allocation_period_path(school_room.id)
    end
  end
end
