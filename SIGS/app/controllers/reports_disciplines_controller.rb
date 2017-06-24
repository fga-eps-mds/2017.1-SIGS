# frozen_string_literal: true

# Classe responsavel por gerar relatorio por disciplina
class ReportsDisciplinesController < ApplicationController
  before_action :logged_in?

  def by_discipline
    @disciplines = Discipline.all

    if params[:name].present?
      @disciplines = @disciplines.where('disciplines.name LIKE ?', "%#{params[:name]}%")
    else
      @disciplines = Discipline.all
    end
  end

  def generate_by_discipline
    require 'prawn/table'
    require 'prawn'

    discipline = Discipline.find(params[:id])

    report = Prawn::Document.new(page_size: 'A4', page_layout: :portrait) do |pdf|
      pdf.image 'app/assets/images/logo_pdf.jpg', width: 520, height: 44
      pdf.move_down 20
      pdf.text 'Relatório de Alocação por Disciplina', size: 18, align: :center
      pdf.move_down 10
      pdf.text discipline.name.to_s, size: 14, style: :bold, align: :center
      pdf.text "Departamento de #{discipline.department.name}", align: :center
      pdf.move_down 20
      generate_discipline_page_report(pdf, discipline)
    end
    send_data report.render, type: 'application/pdf', disposition: 'inline'
  end

  private

  def generate_discipline_page_report(pdf, discipline)
    @school_rooms = SchoolRoom.where('discipline' => discipline.id)
    if @school_rooms.empty?
      pdf.table([
                  ['Disciplina sem turmas']
                ], row_colors: ['F0F0F0'], column_widths: [520]) do
        row(0).font_style = :bold
      end
    else
      @school_rooms.each do |school_room|
        @allocations = Allocation.where('school_room_id' => school_room.id)
        make_discipline_tables(pdf, school_room, @allocations)
      end
    end
  end

  def make_discipline_tables(pdf, school_room, allocations)
    if allocations.empty?
      make_row_school_room_not_alocate(pdf, school_room)
    else
      pdf.table([
                  ["Turma: #{school_room.name}", "Vagas: #{school_room.vacancies}"]
                ], row_colors: ['F0F0F0'], column_widths: [260, 260]) do
        row(0).font_style = :bold
      end
      pdf.table([
                  %w[Dia Sala Início Término]
                ], column_widths: [130, 130, 130, 130], row_colors: ['F0F0F0'])
      make_rows_discipline_table(pdf, allocations)
    end
  end

  def make_rows_discipline_table(pdf, allocations)
    allocations.each do |allocation|
      pdf.table([
                  [allocation.day, Room.find_by_id(allocation.room_id).name,
                   allocation.start_time.strftime('%H:%M'),
                   allocation.final_time.strftime('%H:%M')]
                ], column_widths: [130, 130, 130, 130]) do
        column(0..3).style align: :center
      end
    end
    pdf.move_down 20
  end

  def make_row_school_room_not_alocate(pdf, school_room)
    pdf.table([
                ["Turma: #{school_room.name}"],
                ['Não alocada']
              ], row_colors: ['F0F0F0'], column_widths: [520]) do
      row(0).font_style = :bold
    end
    pdf.move_down 20
  end
end
