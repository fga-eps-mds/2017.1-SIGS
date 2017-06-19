# this method retrieves the number of school rooms per user
def school_rooms_by_user
  if permission[:level] == 1
    department_disciplines = current_user.coordinator.course.department.disciplines
    department_school_rooms = []
    department_disciplines.each do |discipline|
      department_school_rooms += discipline.school_rooms
    end
    return department_school_rooms
  else
    return SchoolRoom.all
  end
end

def school_rooms_allocated_count
  count = 0
  ids_school_room = []
  Allocation.all.each do |allocation|
    ids_school_room << allocation.school_room_id
  end
  school_rooms_by_user.each do |school_room|
    if ids_school_room.include?(school_room.id)
      count = count + 1
    end
  end
  return count
end
