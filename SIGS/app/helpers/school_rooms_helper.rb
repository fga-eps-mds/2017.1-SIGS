# frozen_string_literal: true

# school room module
module SchoolRoomsHelper
  def discipline_of_department(id)
    Discipline.where(department_id: id).load
  end
end
