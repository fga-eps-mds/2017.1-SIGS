# frozen_string_literal: true

# Modulo responsavel por criar a tabela de salas no pdf
module TableRoom
  def self.generate_room_page_report(pdf, room)
    pdf.text "Sala: #{room.name}", size: 14, style: :bold, align: :center
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

  def self.make_rows(room, j)
    @row = [(6 + j).to_s + ':00']
    %w[Segunda Terça Quarta Quinta Sexta Sabado].each do |week|
      allocations = Allocation.where(room_id: room.id).where(day: week)
      allocations_start = allocations.where('DATE_FORMAT(start_time, "%H") = ?', 6 + j)
      make_cell(allocations_start, j, allocations)
    end
    @row
  end

  def self.make_cell(allocations_start, j, allocations)
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
