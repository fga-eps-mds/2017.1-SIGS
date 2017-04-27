class Coordinator < ApplicationRecord
  belongs_to :course
  belongs_to :user, optional: true
  has_one :Department, :through => :course
end
