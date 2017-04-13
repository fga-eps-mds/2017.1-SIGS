class Coordinator < ApplicationRecord
  belongs_to :course
  belongs_to :user
  has_one :Department, :through => :course
end
