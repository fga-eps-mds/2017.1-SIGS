# frozen_string_literal: true

# school room module
module SchoolRoomsHelper
  def get_discipline_name(id)
    Discipline.find(id)
  end

  def discipline_of_department(id)
    Discipline.where(department_id: id).load
  end
end
