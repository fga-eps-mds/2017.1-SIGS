# frozen_string_literal: true

# module to allocations
module AllocationHelper
  def get_school_room_allocation(school_room_allocations, hour, day)
    school_room_allocations.each do |allocation|
        start = allocation.start_time.strftime('%H').to_i
        if start == hour && allocation.day == day
          return allocation
        end
    end
    nil
  end

  def get_room_name_by_allocation(allocation)
    allocation.room.name
  end

  def get_room_allocation(room, day, hour)

  end
end
