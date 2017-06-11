# frozen_string_literal: true

# Module to Prepare Solicitations to persist in database
module PrepareSolicitationsToSave
  def group_solicitation(solicitations)
    group_room_solicitation = []
    weeks = %w[segunda terca quarta quinta sexta sabado]
    weeks.each do |day_of_week|
      rows = row_mount(day_of_week, solicitations)
      group_room_solicitation.push rows unless rows.size.zero?
    end
    group_room_solicitation
  end

  def row_mount(day_of_week, solicitations)
    exist = false
    rows = []
    (6..24).each do |index|
      next if solicitations[day_of_week].nil?
      if !solicitations[day_of_week][index.to_s].nil? && !exist
        room_solicitation = { start_time: index,
                              final_time: index + 1,
                              day: day_of_week }
        rows.push room_solicitation
        exist = true
      elsif !solicitations[day_of_week][index.to_s].nil?
        rows.last[:final_time] += 1
      else
        exist = false
      end
    end
    rows
  end
end
