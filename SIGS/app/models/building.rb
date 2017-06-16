# frozen_string_literal: true

# Building class
class Building < ApplicationRecord
  has_many :rooms
  before_save :params_upcase

  # Validates start here

  # code
  validates :code, presence: { message: 'Informe o código do prédio' },
                   uniqueness: { message: 'Um prédio com esse código já
                   foi cadastro' }

  # Validates end here
  def self.search(search)
    where('name LIKE :search OR code LIKE :search', search: "%#{search}%")
  end

  private

  def params_upcase
    wing.upcase!
  end
end
