# frozen_string_literal: true

# Classe responsavel pelos metodos controladores de sala
class RoomsController < ApplicationController
  before_action :logged_in?

  def index
    @rooms = Room.all

    if params[:name].present? || params[:code].present? || params[:capacity].present?
      filter_by_name_and_code
      filter_by_capacity
    else
      @rooms = Room.all
    end
  end

  def filter_by_capacity
    if params[:capacity].present?
      @rooms = @rooms.where(capacity: params[:capacity].to_s)
    else
      @rooms
    end
  end

 def filter_by_buildings
    if params[:build_id].present?
      @rooms = @rooms.where(build_id: params[:build_id].to_s)
    else
      @rooms
    end
  end

  def filter_by_name_and_code
    if params[:name].present? || params[:code].present?
      @rooms.columns.each do |attr|
        if params[:"#{attr.name}"].present?
          @rooms = @rooms.where("#{attr.name} like ?", "%#{params[attr.name]}%")
        end
      end
    else
      @rooms
    end
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
    @room_categories = @room.category
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
