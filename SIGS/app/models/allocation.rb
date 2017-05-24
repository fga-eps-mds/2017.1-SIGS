# frozen_string_literal: true

# class of Allocation
class Allocation < ApplicationRecord
  belongs_to :user
  belongs_to :room
  belongs_to :school_room
end
