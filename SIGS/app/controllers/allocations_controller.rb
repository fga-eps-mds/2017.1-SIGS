# frozen_string_literal: true

# Controller Allocations class
class AllocationsController < ApplicationController
  def index
    @allocations = Allocation.all
  end

  def new
    @allocation = Allocation.new
  end

  def create
    @allocation = Allocation.new(allocation_params)
    if @allocation.save
      flash[:sucess] = 'Alocação feita com sucesso'
    else
      flash[:error] = 'Alocação não realizada'
    end
  end

  def edit
    @allocation = Allocation.find(params[:id])
  end

  def update
    @allocation = Allocation.find(params[:id])
  end

  def show
    @allocation = Allocation.find(params[:id])
  end

  def destroy
    @allocation = Allocation.find(params[:id])
    @allocation.destroy
  end

  private

  def allocation_params
    params[:allocation].permit(:active, :start_time)
  end
end
