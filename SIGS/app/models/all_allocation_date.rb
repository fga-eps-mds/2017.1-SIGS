# frozen_string_literal: true

# class all_allocation_date
class AllAllocationDate < ApplicationRecord
  belongs_to :allocation, optional: true
  belongs_to :allocation_extension, optional: true
end
