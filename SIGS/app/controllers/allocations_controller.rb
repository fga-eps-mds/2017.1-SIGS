# frozen_string_literal: true

# Controller Allocations class
class AllocationsController < ApplicationController
  before_action :logged_in?
  before_action :validade_permission_1

  def index
    @allocations = Allocation.all
  end

  def new
    @coordinator_rooms = current_user.coordinator.course.department.rooms
    @school_rooms_coordinator = current_user.coordinator.course.school_room
    @allocation = Allocation.new
  end

  def create
    @allocation = Allocation.new(allocation_params)
    @allocation.user_id = current_user.id
    if @allocation.save
      flash[:sucess] = 'Alocação feita com sucesso'
    else
      flash[:error] = 'Alocação não realizada'
    end
  end

  private

  def allocation_params
    params[:allocation].permit(:room_id, :school_room_id)
  end
end
