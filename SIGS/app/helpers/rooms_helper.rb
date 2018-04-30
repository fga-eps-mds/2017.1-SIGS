# frozen_string_literal: true

# rooms module
module RoomsHelper
  def filter_by_department
    return unless params[:department_id].present?
    @rooms = @rooms.where(department_id: params[:department_id])
  end

  def filter_by_capacity
    return unless params[:capacity].present?
    @rooms = @rooms.where('capacity >= ?', params[:capacity])
  end

  def filter_by_buildings
    return unless params[:building_id].present?
    @rooms = @rooms.where(building_id: params[:building_id])
  end

  def filter_by_wings
    return unless params[:wing].present?
    @rooms = @rooms.joins(:building).where(buildings: { wing: params[:wing] })
  end

  def filter_by_name
    return unless params[:name].present?
    @rooms = @rooms.where('rooms.name LIKE ?', "%#{params[:name]}%")
  end

  def filter_by_code
    return unless params[:code].present?
    @rooms = @rooms.where('rooms.code' => params[:code])
  end
end
