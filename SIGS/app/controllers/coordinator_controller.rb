class CoordinatorController < ApplicationController

  def show
    @coordinator = Coordinator.find(params[:id])
    @course = Course.find(@coordinator.course)
    @department = Department.find(@coordinator.department)
    @user = User.find(@coordinator.user)
  end

  def index
    @coordinators = Coordinator.all
  end

  private
  def coordinator_params
    params[:coordinator].permit(:user_id, :course_id)
end
