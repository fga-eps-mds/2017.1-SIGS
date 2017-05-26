# frozen_string_literal: true

# coordinator module
module CoordinatorHelper
  def get_disciplines(user)
    coordinator = Coordinator.find_by(user_id: user.id)
    course = Course.find(coordinator.course_id)
    departments = Department.where(id: course.department_id).select('id')
    disciplines = Discipline.where(department_id: departments)
    disciplines
  end
end
