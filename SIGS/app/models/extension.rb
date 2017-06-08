# frozen_string_literal: true

# Classe modelo da extensao
class Extension < ApplicationRecord
  has_many :AllocationExtensions
end
