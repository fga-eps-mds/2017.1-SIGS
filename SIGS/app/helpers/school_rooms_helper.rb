# frozen_string_literal: true

# school room module
module SchoolRoomsHelper
  def discipline_of_department(id)
    Discipline.where(department_id: id).load
  end

  def get_name(id)
    SchoolRoom.find_by(id: id).name
  end

  def get_discipline_name(id)
    SchoolRoom.find_by(id: id).discipline.name
  end

  def get_department_name(id)
    SchoolRoom.find_by(id: id).discipline.department.name
  end

  def get_vacancies(id)
    SchoolRoom.find_by(id: id).vacancies
  end

  def get_courses(id)
    SchoolRoom.find_by(id: id).courses
  end

  def get_categories(id)
    SchoolRoom.find_by(id: id).category
  end

  def school_rooms_of_disciplines(disciplines)
    SchoolRoom.where(discipline: disciplines).order(:name)
  end

  def department_by_coordinator
    coordinator = Coordinator.find_by(user: current_user.id)
    course = Course.find(coordinator.course_id)
    Department.find(course.department_id)
  end

  def allocated?(id)
    !Allocation.find_by(school_room_id: id).nil?
  end

  def sort_school_rooms_by_allocation
    @allocated_school_rooms = []
    @unallocated_school_rooms = []
    @my_school_rooms.each do |school_room|
      if allocated? school_room.id
        @allocated_school_rooms << school_room
      else
        @unallocated_school_rooms << school_room
      end
    end
    @my_school_rooms = @allocated_school_rooms + @unallocated_school_rooms
  end
end
