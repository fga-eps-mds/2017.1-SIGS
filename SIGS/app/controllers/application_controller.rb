class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ApplicationHelper
  include SessionsHelper
  include UserHelper
  include SchoolRoomsHelper
  include RoomsHelper

  def ocurred_errors(object)
    object.errors.messages.each do |_attrib, messages|
      flash[:error] = messages.join(', ')
    end
  end
end
