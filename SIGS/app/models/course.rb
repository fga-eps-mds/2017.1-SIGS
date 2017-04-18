class Course < ApplicationRecord
	belongs_to :department
	has_one :coordinator , dependent: :destroy
  belongs_to :department
end
