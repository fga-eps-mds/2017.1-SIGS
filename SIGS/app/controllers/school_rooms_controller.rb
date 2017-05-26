# frozen_string_literal: true

# class that create school rooms
class SchoolRoomsController < ApplicationController
  before_action :logged_in?
  before_action :validade_permission_1

  def new
    @school_room = SchoolRoom.new
  end

  def create
    @school_room = SchoolRoom.new(school_rooms_params)
    @school_room.active = true
    @school_room.save
    redirect_to allocations_new_path
    flash[:success] = 'Turma criada'
  end

  def school_rooms_params
    params[:school_room].permit(:name,
                                :discipline_id,
                                :vacancies,
                                course_ids: [],
                                category_ids: [])
  end
end
