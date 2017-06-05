# frozen_string_literal: true

# class that create allocations of extension
class AllocationExtensionsController < ApplicationController
  before_action :logged_in?

  def new
    @extension = Extension.new
    @allocation_extension = AllocationExtension.new
    @extensions = Extension.all
    @department = Department.find_by(name: 'PRC')
    @rooms = Room.where(department_id: @department.id)
  end

  def create
    @allocation_extension = AllocationExtension.new(allocation_extensions_params)
    @allocation_extension.user_id = current_user.id
    if @allocation_extension.save
      flash[:success] = 'Extensão alocada com sucesso'
    else
      flash[:error] = 'Falha ao realizar alocação de extensão'
    end
  end

  def allocation_extensions_params
    params[:allocation_extension].permit(:extension_id,
                                         :room_id,
                                         :start_time,
                                         :final_time,
                                         :inicial_date,
                                         :final_date,
                                         :periodicity)
  end
end
