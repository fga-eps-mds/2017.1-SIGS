# frozen_string_literal: true

# Class t save responder solicitation
class RoomSolicitation < ApplicationRecord
  belongs_to :solicitation
  has_many :room_solicitation
  belongs_to :responder, class_name: 'User'
  belongs_to :room

  # Not null values
  validates_presence_of :start, message: 'Indique o horário de início'
  validates_presence_of :final, message: 'Indique o horário de término'
  validates_presence_of :solicitation, message: 'Solicitação Inválida'

  validate :validate_hours

  def validate_hours
    errors.add(:start, 'Horários Inválidos') if time_invalid
    error_mensager = 'Alocação com horário não vago ou capacidade da sala cheia'
    errors.add(:start, error_mensager) if verify_time_shock_room_day
  end

  def invalid_shift
    shift = solicitation.school_room.courses[0].shift
    (shift == 1 && final.strftime('%H').to_i > 18) ||
      (shift == 2 && start.strftime('%H').to_i < 18)
  end

  def time_invalid
    range = final.to_i - start.to_i
    (range < 1) || invalid_shift
  end

  def verify_time_shock_room_day
    return false unless room.nil?
    allocations_room = Allocation.where(day: day, room_id: room)
    allocations_room.each do |allocation_room|
      return true if verify_time_shock(allocation_room)
    end
    false
  end

  def verify_time_shock(allocation_room)
    time_in_range?(start, allocation_room) || time_in_range?(final, allocation_room)
  end

  def time_in_range?(hour, allocation)
    start_interval = start_time_to_int(allocation)
    final_interval = final_time_to_int(allocation)
    hour >= start_interval && hour <= final_interval
  end
end
