class Department < ApplicationRecord
	has_many :courses
	has_many :disciplines
end
