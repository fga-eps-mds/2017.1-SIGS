# frozen_string_literal: true

# Classe responsavel por gerar relatorio
class ReportsController < ApplicationController
  before_action :logged_in?
  def by_room
    @departments = Department.all
    @rooms = Room.where(department: @departments[0])
    @weeks = obtain_weeks_of_period
  end

  # def by_discipline
  #   if params[:discipline].present?
  #     @disciplines = @disciplines.where("name like ?", "%#{params[:discipline]}%")
  #   else
  #     @disciplines = Discipline.all
  #   end
  # end

  def by_discipline
    @disciplines = Discipline.all

    if params[:name].present?
      @disciplines.columns.each do |attr|
        if params[:"#{attr.name}"].present?
          @disciplines = @disciplines.where("#{attr.name} like ?",
                                            "%#{params[attr.name]}%")
        end
      end
    else
      @disciplines = Discipline.all
    end
  end

  def generate_by_discipline
    require 'prawn/table'
    require 'prawn'

    discipline_id = Discipline.find(params[:id])

    Prawn::Document.generate("public/reports/#{discipline_id.name}.pdf",
                             page_size: 'A4',
                             page_layout: :landscape) do |pdf|
      generate_discipline_page_report(pdf, discipline_id)
    end
    redirect_to "/reports/#{discipline_id.name}.pdf"
  end

  def generate_by_room
    require 'prawn/table'
    require 'prawn'

    time = Time.now.getutc
    room_name = Room.find(params[:reports_by_room][:room_code]).code
    initial_day = params[:reports_by_room][:initial_week].split(' à ')[0].to_date
    last_day = params[:reports_by_room][:last_week].split(' à ')[1].to_date

    Prawn::Document.generate("public/reports/#{time}.pdf",
                             page_size: 'A4',
                             page_layout: :landscape) do |pdf|
      generate_room_page_report(pdf, room_name, initial_day, last_day)
      # table_data = Array.new
      # table_data << ["Product name", "Product category"]
      # table_data << ['teste', 'teste2']
      # pdf.table(table_data, :width => 500, :cell_style => { :inline_format => true })
    end
    redirect_to "/reports/#{time}.pdf"
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

  def generate_discipline_page_report(pdf, discipline_id)
    pdf.image "app/assets/images/logo_pdf.jpg", :width => 770, :height => 66
    pdf.move_down 20
    pdf.text 'Relatório de Alocação por Disciplina', size: 18, align: :center
    pdf.move_down 10
    pdf.text discipline_id.name.to_s, size: 14, style: :bold, align: :center
    pdf.text "Departamento de #{discipline_id.department.name}", align: :center
    pdf.move_down 20

    @school_rooms = SchoolRoom.where('discipline_id' => discipline_id.id)
    # abort @school_rooms.inspect
    if @school_rooms.empty?
      pdf.text 'Disciplina sem turmas.'
    else
      @school_rooms.each do |school_room|

        @allocations = Allocation.where('school_room_id' => school_room.id)
        if @allocations.empty?
          pdf.text 'Disciplina sem turmas alocadas.'
        else
          pdf.table([[ "Turma: #{school_room.name}" , "Vagas: #{school_room.vacancies}" ]], :column_widths =>[360,360])

          pdf.table([[ "Dia", "Sala", "Início", "Término" ]], :column_widths =>[180,180,180,180])

          @allocations.each do |allocation|

            pdf.table([[ allocation.day, Room.find_by_id(allocation.room_id).name, allocation.start_time.strftime("%H:%M"), allocation.final_time.strftime("%H:%M") ]], :column_widths =>[180,180,180,180])do
              column(0).style :align => :right
              column(1).style :align => :right
              column(2).style :align => :right
              column(3).style :align => :right
            end

          end
          pdf.move_down 20
        end
      end
    end
    #
    # pdf.table(items,
    #   :row_colors => ["FFFFFF","DDDDDD"]
    # ) do
    #   row(0).style :align => :center
    #   column(0).style :align => :left
    #   column(1).style :align => :center
    #   column(2).style :align => :center
    # end
  end

  def generate_room_page_report(pdf, room_name, initial_day, last_day)
    new_page = false
    while initial_day < last_day
      pdf.start_new_page if new_page
      pdf.text "Semana: #{initial_day.strftime('%d/%m/%Y')} à ".to_s +
               (initial_day + 5.days).strftime('%d/%m/%Y').to_s,
               size: 18, style: :bold
      pdf.text "Sala: #{room_name}", size: 18, style: :bold, align: :center
      data = [[' ', 'Segunda-feira', 'Terça-feira',
               'Quarta-feira', 'Quinta-feira', 'Sexta-feira', 'Sábado']]
      pdf.table(data, width: 750) do |t|
        t.before_rendering_page do |page|
          page.row(0).font_style = :bold
        end
      end
      new_page = true
      initial_day += 7.days
    end
  end
end
