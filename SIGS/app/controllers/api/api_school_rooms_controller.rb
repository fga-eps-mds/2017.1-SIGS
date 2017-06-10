class Api::ApiSchoolRoomsController < ApplicationController

  def index
    @school_rooms = SchoolRoom.all
  end

end