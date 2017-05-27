# frozen_string_literal: true

# module to define course by user
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

  def department_name_by_user
    case permission[:level]
    when 1
      Department.find(course_by_user.department_id).name
    when 3
      Department.find_by(name: 'PRC').name
    end
  end

  def course_by_user
    course = nil
    if permission[:level] == 1
      coordinator = Coordinator.find_by(user_id: session[:user_id])
      course = Course.find(coordinator.course_id)
    end
    course
  end
end
