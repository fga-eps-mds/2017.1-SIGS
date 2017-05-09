# frozen_string_literal: true

# Classe Curso
class Course < ApplicationRecord
  belongs_to :department
  has_one :coordinator, dependent: :destroy
  has_and_belongs_to_many :school_room
end
