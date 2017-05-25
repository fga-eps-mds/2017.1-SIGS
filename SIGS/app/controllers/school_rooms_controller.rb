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

    if validate_duplicate_name_param
      flash_error_new_auxiliar('Turma com nome já cadastrado')
    elsif validate_blank_name_param
      flash_error_new_auxiliar('Indique o nome da turma')
    elsif validate_capacity_param
      flash_error_new_auxiliar('Capacidade Inválida')
    elsif @school_room.save
      redirect_to school_rooms_index_path, flash: { success: 'Turma criada' }
    else
      flash_error_new_auxiliar('Falha ao criar')
    end
  end

  def validate_capacity_param
    if @school_room.capacity.nil?
      true
    else
      @school_room.capacity < 5 || @school_room.capacity > 200
    end
  end

  def validate_duplicate_name_param
    !SchoolRoom.find_by(name: @school_room.name).nil?
  end

  def validate_blank_name_param
    @school_room.name.blank?
  end

  def edit
    @school_room = SchoolRoom.find(params[:id])
  end

  def show
    @school_room = SchoolRoom.find(params[:id])
  end

  def index
    @school_rooms = SchoolRoom.all
  end

  def update
    @school_room = SchoolRoom.find(params[:id])
    respond_to do |format|
      if @school_room.update(school_rooms_params)
        redirect_to school_rooms_index_path
        flash[:success] = 'A turma foi alterada com sucesso'
      else
        format.html { render :edit, error: 'A turma não pode ser alterada' }
      end
    end
  end

  def destroy
    @school_room = SchoolRoom.find(params[:id])
    if !logged_in?
      @school_room.destroy
      redirect_to school_rooms_index_path
      flash[:success] = 'A turma foi excluída com sucesso'
    else
      redirect_to sign_in_path
      flash[:error] = 'Você não permissão para excluir essa turma'
    end
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

  def flash_error_new_auxiliar(mensage)
    flash[:error] = mensage
    render :new
  end
end
