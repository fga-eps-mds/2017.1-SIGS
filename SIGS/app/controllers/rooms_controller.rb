# frozen_string_literal: true

# Classe responsavel pelos metodos controladores de sala
class RoomsController < ApplicationController
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

  def show
    find_rooms
  end

  private

  def find_rooms
    @room = Room.find(params[:id])
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
