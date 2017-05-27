# frozen_string_literal: true

# class that create school rooms
class SchoolRoomsController < ApplicationController
  before_action :logged_in?
  before_action :validade_permission_for_school_room

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

  def search_disciplines
    search_attribute = params[:current_search][:search]
    @disciplines = discipline_of_department(user_department_id).where(
      'name LIKE :search', search: "%#{search_attribute}%"
    )

    @school_rooms = school_rooms_of_disciplines(@disciplines)
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

  def school_rooms_of_disciplines(disciplines)
    school_rooms = []
    disciplines.each do |discipline|
      school_rooms_sort = SchoolRoom.where(discipline_id: discipline.id)
      school_rooms_sort.each do |school_room|
        school_rooms << school_room
      end
    end
    school_rooms
  end
end
