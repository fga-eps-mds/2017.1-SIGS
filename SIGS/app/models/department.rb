class Department < ApplicationRecord
	has_many :courses
	has_one :department_assistant
end
