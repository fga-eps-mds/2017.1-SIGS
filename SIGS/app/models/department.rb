class Department < ApplicationRecord
	has_many :courses
	has_one :department_assistant, dependent: :destroy
	has_many :disciplines, dependent: :destroy
end
