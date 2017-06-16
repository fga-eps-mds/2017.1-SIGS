# frozen_string_literal: true

# class that create school rooms
class SchoolRoomsController < ApplicationController
  before_action :logged_in?
  before_action :authenticate_coordinator?, except: [:index]

  def new
    @school_room = SchoolRoom.new
    @all_courses = Course.all
  end

  def create
    @school_room = SchoolRoom.new(school_rooms_params)
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

  def index
    if permission[:level] == 1
      @my_school_rooms = SchoolRoom.joins(:discipline).merge(
        Discipline.order(:name).where(department_id: department_by_coordinator)
      ).order(:name)
      @disciplines = discipline_of_department(department_by_coordinator)
                     .order(:name)
                     .map(&:name)
    else
      @my_school_rooms = SchoolRoom.all
    end
  end

  def search_disciplines
    @search_attribute = params[:current_search][:search]
    @disciplines = discipline_of_department(department_by_coordinator).where(
      'name LIKE :search', search: "%#{@search_attribute}%"
    ).order(:name)
    if @disciplines.present?
      @school_rooms = school_rooms_of_disciplines(@disciplines)
    else
      flash[:notice] = 'Nenhuma turma encontrada'
      redirect_to school_rooms_index_path
    end
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
      :vacancies,
      course_ids: [],
      category_ids: []
    )
  end

  def school_rooms_params_update
    params[:school_room].permit(
      :discipline_id,
      :vacancies,
      course_ids: [],
      category_ids: []
    )
  end

  def school_rooms_of_disciplines(disciplines)
    SchoolRoom.where(discipline: disciplines).order(:name)
  end

  def department_by_coordinator
    coordinator = Coordinator.find_by(user: current_user.id)
    course = Course.find(coordinator.course_id)
    Department.find(course.department_id)
  end
end
