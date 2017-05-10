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
    flash[:success] = "Turma criada"
  end

  def edit
    @school_room = SchoolRoom.find_by(params[:id])
  end

  def show
    @school_room = SchoolRoom.find(params[:id])
  end

  def index
    @school_rooms = SchoolRoom.all
  end

  def update
    @school_room = SchoolRoom.find_by(params[:id])
    respond_to do |format|
      if @school_room.update(school_rooms_params)
        format.html { render :show, notice: 'A turma foi alterada com sucesso' }
      else
        format.html { render :edit, error: 'A turma não pode ser alterada' }
      end
    end
  end

  private

    def school_rooms_params
      params[:school_room].permit(:name ,:discipline_id, :course_ids => [])
    end
end
