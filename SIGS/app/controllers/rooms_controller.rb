# frozen_string_literal: true

# Classe responsavel pelos metodos controladores de sala
class RoomsController < ApplicationController
  before_action :logged_in?

  def index
    @rooms = Room.all
  end

  def edit
    find_rooms
  end

  def update
    @room = Room.find(params[:id])
    if @room.update_attributes(room_params)
      success_mesage = 'Dados da sala atualizados com sucesso'
      redirect_to room_index_path(@room.id), flash: { success: success_mesage }
    else
      flash[:error] = 'Dados não foram atualizados'
      render :edit
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @coordinator = Coordinator.find_by(user_id: current_user.id)
    if (permission[:level] == 3 && @room.department.name == 'PRC') ||
       (permission[:level] == 1 && @coordinator.course.department == @room.department)
      @room.destroy
      flash[:success] = 'Sala excluida com sucesso'
    else
      flash[:error] = 'Não possui permissão para excluir sala'
    end
    redirect_to room_index_path
  end

  def show
    find_rooms
  end

  def json_of_categories_by_school_room
    school_room_id = params[:school_room_id]
    result = []
    allocations = Allocation.where(school_room_id: school_room_id)
    allocations.each do |allocation|
      result.push [
        allocation.start_time,
        allocation.final_time,
        allocation.day,
        allocation.room.name
      ]
    end
    render inline: result.to_json
  end

  private

  def find_rooms
    @room = Room.find(params[:id])
    @room_categories = @room.category
    find_allocation(@room)
  end

  def find_allocation(room)
    room_id = room.id
    @allocations = Allocation.where(room_id: room_id)
    @allocations_extensions = AllocationExtension.where(room_id: room_id)
  end

  def room_params
    params[:room].permit(
      :id,
      :code,
      :name,
      :capacity,
      :active,
      :time_grid_id,
      :build_id,
      category_ids: []
    )
  end
end
