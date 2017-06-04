# frozen_string_literal: true

# module to allocations
module AllocationHelper
  def get_school_room_allocation(school_room_allocations, hour, day)
    school_room_allocations.each do |allocation|
        start = allocation.start_time.strftime('%H').to_i
        final = allocation.final_time.strftime('%H').to_i
        if (hour >= start && hour < final) && allocation.day == day
          return allocation
        end
    end
    nil
  end

  def get_room_name_by_allocation(allocation)
    allocation.room.name
  end

  def get_discipline_by_allocation(allocation)
    allocation.school_room.discipline.name
  end

  def room_allocations_by_day
    # Allocation.find_by(id: room_id, day: day).find_by('? >= DATE_FORMAT(start_time, "%H") && ? < DATE_FORMAT(start_final, "%H")', hour, hour)
    render inline: "ttt"
    # allocation[0]
  end
end
