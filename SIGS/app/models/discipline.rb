# frozen_string_literal: true

# Classe Disciplina
class Discipline < ApplicationRecord
  has_and_belongs_to_many :courses
  belongs_to :department
  has_many :school_rooms, dependent: :destroy
end
