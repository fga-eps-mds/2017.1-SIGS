# frozen_string_literal: true

# class that create school rooms
class SchoolRoomsController < ApplicationController
  before_action :logged_in?
  before_action :validade_permission_1

  def new
    @school_room = SchoolRoom.new
    @all_courses = Course.all
  end

  def create
    @school_room = SchoolRoom.new(school_rooms_params)
    @school_room.active = true
    @school_room.name.upcase!
    @all_courses = Course.all

    if @school_room.save
      redirect_to school_rooms_index_path, flash: { success: 'Turma criada' }
    else
      ocurred_errors(@school_room)
      render :new
    end
  end

  def edit
    @school_room = SchoolRoom.find(params[:id])
    @all_courses = Course.all
  end

  def show
    @school_room = SchoolRoom.find(params[:id])
  end

  def index
    @my_school_rooms = filter_coordinator_school_rooms(current_user.id)
  end

  def filter_coordinator_school_rooms(user_id)
    @school_rooms = SchoolRoom.all
    @filter_school_rooms = []
    coordinator = Coordinator.find(user_id)
    course = Course.find(coordinator.course_id)
    department = Department.find(course.department_id)
    @school_rooms.each do |school_room|
      discipline = Discipline.find(school_room.discipline_id)
      if discipline.department_id == department.id
        @filter_school_rooms << school_room
      end
    end
    @filter_school_rooms
  end

  def update
    @school_room = SchoolRoom.find(params[:id])
    @all_courses = Course.all

    if @school_room.update_attributes(school_rooms_params_update)
      success_mesage = 'A turma foi alterada com sucesso'
      redirect_to school_rooms_index_path, flash: { success: success_mesage }
    else
      ocurred_errors(@school_room)
      render :edit
    end
  end

  def destroy
    @school_room = SchoolRoom.find(params[:id])
    coordinator = Coordinator.find_by(user_id: current_user.id)

    if permission[:level] == 1 &&
       coordinator.course.department == @school_room.discipline.department
      @school_room.destroy
      flash[:success] = 'A turma foi excluída com sucesso'
    else
      flash[:error] = 'Permissão negada'
    end
    redirect_to school_rooms_index_path
  end

  private

  def school_rooms_params
    params[:school_room].permit(
      :name,
      :discipline_id,
      :capacity,
      course_ids: [],
      category_ids: []
    )
  end

  def school_rooms_params_update
    params[:school_room].permit(
      :discipline_id,
      :capacity,
      course_ids: [],
      category_ids: []
    )
  end
end
