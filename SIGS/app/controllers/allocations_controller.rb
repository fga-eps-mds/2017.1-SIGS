# frozen_string_literal: true

# class that create allocations
class AllocationsController < ApplicationController
  def new_education
    @coordinator_rooms = current_user.coordinator.course.department.rooms
    @school_rooms_coordinator = current_user.coordinator.course.school_room
  end

  def create_education
    @allocation = Allocation.new(allocation_params)
    @allocation.periodicity = 0
    @allocation.user_id = current_user.id
    @allocation_education = AllocationEducation.new(
      school_room_id: params[:school_room]
    )
    @allocation.allocable = @allocation_education
    if @allocation.save
      render inline: '<div class="alert alert-success">Alocação salva</div>'
    else
      render inline: '<div class="alert alert-success">Alocação não efetivada</div>'
    end
  end

  private

  def allocation_params
    params.require(:allocation).permit(:room_id,
                                       :start_time,
                                       :end_time)
  end
end
