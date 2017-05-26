# frozen_string_literal: true

# Classe Departamento
class Department < ApplicationRecord
  has_one :department_assistant, dependent: :destroy
  has_many :disciplines, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :courses
  has_many :coordinators
end
