# frozen_string_literal: true

# Class category
class Category < ApplicationRecord
  has_and_belongs_to_many :room
  has_and_belongs_to_many :school_room

  CATEGORY_EXISTS = 'Categoria já cadastrada no sistema'.freeze
  NULL_NAME = 'Nome não pode ser vazio'.freeze

  validates :name, presence: { message: NULL_NAME },
                   uniqueness: { message: CATEGORY_EXISTS }
end
