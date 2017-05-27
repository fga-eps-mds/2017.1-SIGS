# frozen_string_literal: true

# school room module
module SchoolRoomsHelper

  def get_discipline_name(id)
    discipline = Discipline.find(id)
    return discipline
  end

  def discipline_of_department(id)
    my_disciplines = Discipline.where(department_id: id).load
    return my_disciplines
  end

  def school_rooms_of_disciplines(disciplines)
    school_rooms = []
    disciplines.each do |discipline|
      school_rooms_sort = SchoolRoom.where(discipline_id: discipline.id)
      school_rooms_sort.each do |school_room|
        school_rooms << school_room
       end
     end
    return school_rooms
  end


  def filter_coordinator_school_rooms(user_id)
    @school_rooms = SchoolRoom.all
    @filter_school_rooms = []
    coordinator = Coordinator.find(user_id)
    course = Course.find(coordinator.course_id)
    department = Department.find(course.department_id)
    @school_rooms.each do |school_room|
      discipline = Discipline.find(school_room.discipline_id)
      if discipline.department_id == department.id
        @filter_school_rooms << school_room
      end
    end
    @filter_school_rooms
  end
  
end
