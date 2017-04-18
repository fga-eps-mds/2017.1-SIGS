class Building < ApplicationRecord
  has_many :rooms
  before_save :params_upcase

# Validates start here

  # code
  validates :code,
    presence: { message: 'Informe o código do prédio'},
    uniqueness: { message: 'Um prédio com esse código já foi cadastro'}

# Validates end Here

  private
    def params_upcase
      self.code.upcase!
      self.wing.upcase!
    end

end
