class SchoolRoom < ApplicationRecord
  belongs_to :discipline
  has_and_belongs_to_many :course, uniq: true
end
