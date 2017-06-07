# frozen_string_literal: true

# Classe responsavel por gerar relatorio
class ReportsController < ApplicationController
  before_action :logged_in?
  Prawn::Font::AFM.hide_m17n_warning = true

  def by_room
    @departments = Department.all
    @rooms = Room.where(department: @departments[0])
  end

  def generate_by_room
    require 'prawn/table'
    require 'prawn'
    report = Prawn::Document.new(page_size: 'A4', page_layout: :landscape) do |pdf|
      if params[:reports_by_room][:all_rooms] == '0'
        room_selected = Room.find(params[:reports_by_room][:room_code])
        TableRoom.generate_room_page_report(pdf, room_selected)
      else
        new_page = false
        rooms = Room.where(department: params[:reports_by_room][:departments])
        rooms.each do |room|
          pdf.start_new_page if new_page
          TableRoom.generate_room_page_report(pdf, room)
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

  def obtain_room_list_with_name_id(rooms)
    rooms.map do |u|
      {
        id: u.id, name: u.name
      }
    end
  end
end
