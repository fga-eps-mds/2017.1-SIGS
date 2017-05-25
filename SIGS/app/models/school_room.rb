# frozen_string_literal: true

# Classe modelo da Turma
class SchoolRoom < ApplicationRecord
  belongs_to :discipline
  has_and_belongs_to_many :course
  has_and_belongs_to_many :allocations
  has_and_belongs_to_many :category

  validates :name, uniqueness: {
    scope: :discipline,
    message: 'Turma com nome já cadastrado'
  }

  validates_presence_of :name, message: 'Turma não pode ser vazia'
  validates_presence_of :capacity, message: 'Capacidade não pode ser vazia'
  validates_presence_of :discipline, message: 'Disciplina não pode ser vazia'

  validates_numericality_of :capacity,
                            greater_than_or_equal_to: 5,
                            message: 'A capacidade mínima é 5 vagas'
  validates_numericality_of :capacity,
                            less_than_or_equal_to: 500,
                            message: 'A capacidade máxima é 500 vagas'
end
