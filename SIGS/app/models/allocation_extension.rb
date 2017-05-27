# frozen_string_literal: true

# class with model to allocationExtension
class AllocationExtension < ApplicationRecord
  belongs_to :extension
  has_one :allocation, as: :allocable
end
