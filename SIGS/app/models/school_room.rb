# frozen_string_literal: true

# Classe modelo da Turma
class SchoolRoom < ApplicationRecord
  belongs_to :discipline
  has_and_belongs_to_many :course
  has_and_belongs_to_many :allocations
  has_and_belongs_to_many :category

  validates_presence_of :name, message: 'Turma não pode ser nula'
  validates_presence_of :capacity, message: 'Capacidade não pode ser nula'
  validates_presence_of :discipline_id, message: 'Disciplina não pode ser nula'
end
