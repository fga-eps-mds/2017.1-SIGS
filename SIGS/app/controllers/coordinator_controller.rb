class CoordinatorController < ApplicationController


  def show
    @coordinator = Coordinator.find(params[:id])
    @course = Course.find(@coordinator.course)
    @department = Department.find(@coordinator.department)
    @user = User.find(@coordinator.user)
  end

  def destroy
    @coordinator = Coordinator.find(params[:id])
    @user = User.find(@coordinator.user_id)

    @coordinator = Coordinator.all
    if @coordinator.count > 1
      @coordinator.destroy
      @user.destroy
      redirect_to destroy_path
    else
      redirect_to index_path(@coordinator.id)
    end
  end

  def index
    @coordinators = Coordinator.all
  end
  private
  def coordinator_params
    params[:coordinator].permit(:user_id, :course_id)
end
