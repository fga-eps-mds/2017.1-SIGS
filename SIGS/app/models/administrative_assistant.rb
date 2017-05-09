# frozen_string_literal: true

# administrative assistant class
class AdministrativeAssistant < ApplicationRecord
  belongs_to :user, optional: true
end
