# frozen_string_literal: true

# class that create allocations
class Allocation < ApplicationRecord
  belongs_to :room
  belongs_to :allocable, polymorphic: true
end
