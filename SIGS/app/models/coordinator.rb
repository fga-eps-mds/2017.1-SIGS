class Coordinator < ApplicationRecord
  belongs_to :department
  belongs_to :course
  belongs_to :user
end
