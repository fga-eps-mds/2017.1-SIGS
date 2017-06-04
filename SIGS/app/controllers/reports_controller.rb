# frozen_string_literal: true

# Classe responsavel por gerar relatorio
class ReportsController < ApplicationController
  before_action :logged_in?

  def by_room
    @departments = Department.all
    @rooms = Room.where(department: @departments[0])
    @weeks = obtain_weeks_of_period
  end

  def generate_by_room
    require 'prawn/table'
    require 'prawn'

    report = Prawn::Document.new(page_size: 'A4', page_layout: :landscape) do |pdf|
      if params[:reports_by_room][:all_rooms] == '0'
        room_selected = Room.find(params[:reports_by_room][:room_code])
        generate_room_page_report(pdf, room_selected)
      else
        new_page = false
        rooms = Room.where(department: params[:reports_by_room][:departments])
        rooms.each do |room|
          pdf.start_new_page if new_page
          generate_room_page_report(pdf, room)
          new_page = true
        end

      end
    end
    send_data report.render, type: 'application/pdf', disposition: 'inline'
  end

  def json_of_rooms_by_department
    department_code = params[:department_code]
    rooms = Room.where(department_id: department_code).select('id, name')
    render inline: obtain_room_list_with_name_id(rooms).to_json
  end

  def json_of_rooms_with_parts_of_name
    department_code = params[:department_code]
    part_name = params[:part_name]
    rooms = Room.where(department_id: department_code)
                .where('name LIKE ?', "%#{part_name}%").select('id, name')
    render inline: obtain_room_list_with_name_id(rooms).to_json
  end

  private

  def report_by_room_params
    params[:reports_by_room].permit(:departments, :all_rooms, :room_code,
                                    :initial_week, :last_week)
  end

  def obtain_room_list_with_name_id(rooms)
    rooms.map do |u|
      {
        id: u.id, name: u.name
      }
    end
  end

  def obtain_weeks_of_period
    weeks = []
    date = Period.find(1).initial_date.at_beginning_of_week
    last = Period.find(3).final_date.at_end_of_week
    while date <= last
      weeks.push date.strftime('%d/%m/%Y') + ' à ' + (date + 5.days)
                                                     .strftime('%d/%m/%Y')
      date += 7.days
      puts date.to_s
    end
    weeks
  end

  def generate_room_page_report(pdf, room)
    pdf.text "Sala: #{room.code}", size: 18, style: :bold, align: :center
    data = [[' ', 'Segunda-feira', 'Terça-feira',
             'Quarta-feira', 'Quinta-feira', 'Sexta-feira', 'Sábado']]
    (0..17).each do |j|
      data << make_rows(room, j)
    end
    pdf.table(data, width: 750) do |t|
      t.before_rendering_page do |page|
        page.row(0).font_style = :bold
      end
    end
  end

  def make_rows(room, j)
    @row = [(6 + j).to_s + ':00']
    %w[Segunda Terça Quarta Quinta Sexta Sabado].each do |week|
      allocations = Allocation.where(room_id: room.id).where(day: week)
      allocations_start = allocations.where('DATE_FORMAT(start_time, "%H") = ?', 6 + j)
      make_cell(allocations_start, j, allocations)
    end
    @row
  end

  def make_cell(allocations_start, j, allocations)
    if allocations_start.size.zero?
      @row << ' ' if allocations.where('DATE_FORMAT(start_time, "%H") < ?', 6 + j)
                                .where('DATE_FORMAT(final_time, "%H") > ?', 6 + j)
                                .size.zero?
    else
      cell = ''
      allocations_start.each do |allocation|
        cell += allocation.school_room.discipline.name + '    Turma:' +
                allocation.school_room.name
      end
      @row << { content: cell, rowspan: (allocations_start[0].final_time.hour -
                        allocations_start[0].start_time.hour) }
    end
  end
end
