class Room < ApplicationRecord
  belongs_to :building

  # code
  validates :code,
    presence: { message: 'Informe o código da sala'},
    uniqueness: { message: 'Uma sala com esse código já foi cadastra'}

  # name
  CHARACTERS_MINIMUM_FOR_THE_NAME_EXCEPTION = 'O Nome deve ter no mínimo 2 caracteres'
  CHARACTERS_MAXIMUM_FOR_THE_NAME_EXCEPTION = 'Nome deve ter no máximo 50 caracters'

  validates_length_of :name,
    :within => 2..50,
    :too_short => CHARACTERS_MINIMUM_FOR_THE_NAME_EXCEPTION,
    :too_long => CHARACTERS_MAXIMUM_FOR_THE_NAME_EXCEPTION

  # capacity
  MINIMUM_FOR_THE_CAPACITY_EXCEPTION = 'A capacidade mínima é 5 vagas'
  MAXIMUM_FOR_THE_CAPACITY_EXCEPTION = 'A capacidade máxima é 500 vagas'

  validates_numericality_of :capacity,
    :greater_than_or_equal_to => 5,
    :less_than_or_equal_to => 500

end
