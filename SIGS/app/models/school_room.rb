# frozen_string_literal: true

# Classe modelo da Turma
class SchoolRoom < ApplicationRecord
  belongs_to :discipline
  has_and_belongs_to_many :course
  has_and_belongs_to_many :category
end
