class DepartmentAssistantController < ApplicationController

  # Método de página de perfil do Assistente de Departmento
  def index
    @department_assistant = DepartmentAssistant.find(params[:id])
    @user = User.find(@department_assistant.user_id)
  end

  # Método de visualizar perfil do Assistente de Departmento
  def show
    @department_assistant = DepartmentAssistant.find(params[:id])
    @user = User.find(@department_assistant.user_id)
    @department = Department.find(@department_assistant.department_id)
  end

  # Método de visualizar conta do Assistente de Departmento
  def destroy
    @department_assistant = DepartmentAssistant.find(params[:id])
    @user = User.find(@department_assistant.user_id)

    @department_assistants = DepartmentAssistant.all
    if @department_assistants.count > 1
      @user.destroy
      redirect_to destroy_path
    else
      redirect_to index_path(@department_assistant.id)
    end
  end

  private
  # Método de parametros do Assistente de Departmento
  def department_assistant_params
    params[:department_assistant].permit(:user_id,:department_id)
  end
end
