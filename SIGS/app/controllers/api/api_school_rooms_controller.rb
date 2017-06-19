# frozen_string_literal: true

module Api
  # class that find school rooms from api
  class ApiSchoolRoomsController < ApplicationController
    def index
      @school_rooms = SchoolRoom.all
    end
  end
end
