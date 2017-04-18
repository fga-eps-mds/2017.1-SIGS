class AdministrativeAssistant < ApplicationRecord
  belongs_to :user, optional: true
end
