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
end
