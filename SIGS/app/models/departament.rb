class Departament < ApplicationRecord
	has_many :courses
	has_many :disciplines
end
