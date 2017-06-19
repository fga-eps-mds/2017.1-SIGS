# frozen_string_literal: true

# module to define course by user
module CoursesHelper
  include SessionsHelper

  def courses_by_user
    case permission[:level]
    when 1
      @coordinator = Coordinator.find_by(user_id: session[:user_id])
      @courses = Course.find_by(id: @coordinator.course_id)
    end
  end
end
