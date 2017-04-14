class Room < ApplicationRecord
  belongs_to :building


# Validates start here

  # code
  validates :code,
    presence: { message: 'Informe o código da sala'},
    uniqueness: { message: 'Uma sala com esse código já foi cadastra'}

end
