# frozen_string_literal: true

# class that create allocations
class Allocation < ApplicationRecord
  belongs_to :room
  # belongs_to :allocable, polymorphic: true
  belongs_to :school_room
  belongs_to :user

  validates :school_room_id,
            presence: { message: 'Informe a Turma' }
  validates :room_id,
            presence: { message: 'Informe a Sala' }
  validates :start_time,
            presence: { message: 'Informe a hora de inicio' }
  validates :final_time,
            presence: { message: 'Informe a hora de términio' }
end
