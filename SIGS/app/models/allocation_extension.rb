# frozen_string_literal: true

# class with model to allocationExtension
class AllocationExtension < ApplicationRecord
  belongs_to :extension
  belongs_to :room
  belongs_to :user
  has_many :all_allocation_date
end
