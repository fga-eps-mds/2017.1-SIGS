module CoursesHelper
  include SessionsHelper

  def courses_by_user
    case permission[:level]
    when 1
      @coordinator = Coordinator.find_by(user_id: session[:user_id])
      @courses = Course.where(id: @coordinator.course_id)
    when 2
      @department_assistant = DepartmentAssistant.find_by(user_id: session[:user_id])
      @courses = Course.where(department_id: @department_assistant.department_id)
    end
  end

end
