# frozen_string_literal: true

# validate schedules to allocation
module Schedule
  def start_time_to_int(allocation)
    allocation.start_time.strftime('%H').to_i
  end

  def final_time_to_int(allocation)
    allocation.final_time.strftime('%H').to_i
  end

  def time_in_range?(hour, allocation)
    start_interval = start_time_to_int(allocation)
    final_interval = final_time_to_int(allocation)
    hour >= start_interval && hour <= final_interval
  end

  def verify_time_shock(solicitation, allocation_room)
    start = solicitation[:start_time]
    final = solicitation[:final_time]
    time_in_range?(start, allocation_room) || time_in_range?(final, allocation_room)
  end

  def verify_time_shock_room_day(solicitation, room)
    shocked = false
    allocations_room = Allocation.where(day: solicitation[:day], room: room)
    allocations_room.each do |allocation_room|
      if verify_time_shock(solicitation, allocation_room)
        shocked = true
        break
      end
    end
    shocked
  end

  def filter_rooms_for_school_room(school_room_id, department_id)
    department = Department.find(department_id)
    school_room = SchoolRoom.find(school_room_id)
    rooms = Room.where(department: department, active: true).where(
      'capacity >= ?', school_room.vacancies
    )
    rooms
  end

  def avaliable_room_day(reservations, room)
    reservations.each do |reserve|
      return false if verify_time_shock_room_day(reserve.first, room)
    end
    true
  end

  def convert_params_to_hash(array)
    week = { 'segunda' => {}, 'terca' => {}, 'quarta' => {}, 'quinta' => {},
             'sexta' => {}, 'sabado' => {} }
    array.each do |r|
      day = r.split('[')[0]
      hour = r.split('[')[1].split(']')[0]
      week[day][hour] = '1'
    end
    week
  end
end
