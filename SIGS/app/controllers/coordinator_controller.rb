class CoordinatorController < ApplicationController
  def registration_request
  end

  def edit
  end

  def update
  end

  def show
    @coordinator = Coordinator.find(params[:id])
    @course = Course.find(@coordinator.course)
    @department = Department.find(@coordinator.department)
    @user = User.find(@coordinator.user)
  end

  def destroy
  end

  def enable
  end

  def index
    @coordinators = Coordinator.all
  end
end
