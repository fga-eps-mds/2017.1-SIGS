# frozen_string_literal: true

# Module to attributes from coordinator
module UserHelper
  def user_department_id
    coordinator = Coordinator.find(current_user.id)
    course = Course.find(coordinator.course_id)
    department = Department.find(course.department_id)
    department.id
  end
end
