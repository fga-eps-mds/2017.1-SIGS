class CoordinatorController < ApplicationController
  def new
    @coordinator = Coordinator.new
  end

  def create
    @coordinator = Coordinator.create(coordinator_params)
    if @coordinator.save
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
  private
  def coordinator_params
    params[:coordinator].permit(:user_id, :course_id)
end
