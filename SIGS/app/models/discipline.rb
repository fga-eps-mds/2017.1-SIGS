# frozen_string_literal: true

# Classe Disciplina
class Discipline < ApplicationRecord
  belongs_to :department
  has_many :school_rooms
end
