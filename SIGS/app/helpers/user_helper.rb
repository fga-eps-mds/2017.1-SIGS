module UserHelper

  def user_department_id
    coordinator = Coordinator.find(current_user.id)
    course = Course.find(coordinator.course_id)
    department = Department.find(course.department_id)
    return department.id
  end

end
