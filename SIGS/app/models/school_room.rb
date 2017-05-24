# frozen_string_literal: true

# Classe modelo da Turma
class SchoolRoom < ApplicationRecord
  belongs_to :discipline
  has_and_belongs_to_many :courses
  has_and_belongs_to_many :categorys
  has_many :allocations
  has_one :user
end
