class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def edit
    find_rooms()
  end

  def update
    @room = Room.find(params[:id])
    if @room.update_attributes(room_params)
      redirect_to room_index_path(@room.id), :flash => {:success => "Dados da sala atualizados com sucesso"}
    else
      redirect_to room_edit_path(@room.id), :flash => {:warning => "Dados não foram atualizados"}
    end
  end

  def show
    find_rooms()
  end

  private
  def find_rooms
    @room = Room.find(params[:id])
  end

  def room_params
    params[:room].permit(:id, :code, :name, :capacity, :active, :time_grid_id, :build_id)
  end
end
