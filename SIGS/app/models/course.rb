# frozen_string_literal: true

# Classe Curso
class Course < ApplicationRecord
  has_and_belongs_to_many :disciplines
  has_one :coordinator, dependent: :destroy
  has_and_belongs_to_many :school_rooms
  belongs_to :department
end
