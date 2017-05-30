# frozen_string_literal: true

# class that create allocations of educations
class AllocationEducation < ApplicationRecord
  has_and_belongs_to_many :school_rooms
end
