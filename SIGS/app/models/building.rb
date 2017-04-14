class Building < ApplicationRecord
  has_many :rooms

# Validates start here

  # code
  validates :code,
    presence: { message: 'Informe o código do prédio'},
    uniqueness: { message: 'Um prédio com esse código já foi cadastro'}

end
