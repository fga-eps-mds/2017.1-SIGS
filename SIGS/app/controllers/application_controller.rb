class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ApplicationHelper
  include SessionsHelper
  include UserHelper
  include SchoolRoomsHelper

  def ocurred_errors(object)
    object.errors.messages.each do |_attrib, messages|
      flash[:error] = messages.join(', ')
    end
  end

  def return_department_owner
    coordinator = Coordinator.find_by(user_id: current_user.id)
    if coordinator.nil?
      Department.find_by(name: 'PRC')
    else
      coordinator.course.department
    end
  end
end
