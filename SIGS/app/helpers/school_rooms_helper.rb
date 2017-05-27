# frozen_string_literal: true

# school room module
module SchoolRoomsHelper
  def get_discipline_name(id)
    Discipline.find(id)
  end

  def discipline_of_department(id)
    Discipline.where(department_id: id).load
  end

  def school_rooms_of_disciplines(disciplines)
    school_rooms = []
    disciplines.each do |discipline|
      school_rooms_sort = SchoolRoom.where(discipline_id: discipline.id)
      school_rooms_sort.each do |school_room|
        school_rooms << school_room
      end
    end
    school_rooms
  end
end
