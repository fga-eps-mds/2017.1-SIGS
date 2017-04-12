class DepartmentAssistantController < ApplicationController
  def registration_request
  end

  def index
    @department_assistant = DepartmentAssistant.find(params[:id])
    @user = User.find(@department_assistant.user_id)
  end

  def edit
  end

  def update
  end

  def show
    @department_assistant = DepartmentAssistant.find(params[:id])
    @department = Department.find(@department_assistant.department_id)
    @user = User.find(@department_assistant.user_id)
  end

  def destroy
  end

  def enable
  end
end
