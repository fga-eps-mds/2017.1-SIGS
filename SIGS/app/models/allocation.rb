# frozen_string_literal: true

# Allocation class
class Allocation < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_and_belongs_to_many :school_rooms
end
