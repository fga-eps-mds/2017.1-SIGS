# frozen_string_literal: true

# user module
module UserHelper
  def user_department_id
    coordinator = Coordinator.find(current_user.id)
    course = Course.find(coordinator.course_id)
    Department.find(course.department_id)
  end
end
