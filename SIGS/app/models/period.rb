# frozen_string_literal: true

# Classe modelo da Sala
class Period < ApplicationRecord
  validate :date_difference_must_be_positive

  private

  def date_difference_must_be_positive
    return unless final_date < initial_date
    errors.add(:final_date, 'A Data Final deve ser depois da Data de Início')
  end
end
