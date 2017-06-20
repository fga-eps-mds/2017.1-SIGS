# frozen_string_literal: true

# Classe Assistente de Departamento
class DepartmentAssistant < ApplicationRecord
  belongs_to :department
  belongs_to :user, optional: true
end
