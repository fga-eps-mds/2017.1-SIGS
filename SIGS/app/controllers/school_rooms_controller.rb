# frozen_string_literal: true

# class that create school rooms
class SchoolRoomsController < ApplicationController
  before_action :logged_in?
  before_action :validade_permission_for_school_room

  def new
    @school_room = SchoolRoom.new
  end

  def create
    @school_room = SchoolRoom.new(school_rooms_params)
    @school_room.active = true
    @school_room.save
    flash[:success] = 'Turma criada'
  end

  def school_rooms_params
    params[:school_room].permit(:name, :discipline_id, course_ids: [])
  end
end
