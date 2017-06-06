# frozen_string_literal: true

# C
class SolicitationsController < ApplicationController
  before_action :logged_in?

  def index
    if allocation_period?
      redirect_to allocation_period_path(params[:school_room_id])
    else
      redirect_to adjustment_period_path(params[:school_room_id])
    end
  end

  def allocation_period
    school_room_id = params[:school_room_id]
    redirect_to solicitation_index_path(school_room_id) unless allocation_period?

    @school_room = SchoolRoom.find(params[:school_room_id])
    @departments = Department.all
  end

  def save_allocation_period
    puts 'route to save'
  end

  def adjustment_period
    redirect_to solicitation_index_path(params[:school_room_id]) if allocation_period?
  end

  private

  def allocation_period?
    now = Date.current
    now < Period.find_by(period_type: 'Alocação').final_date
  end
end
