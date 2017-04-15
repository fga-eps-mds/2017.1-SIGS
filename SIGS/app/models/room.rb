class Room < ApplicationRecord
  belongs_to :building


# Validates start here

  # code
  validates :code,
    presence: { message: 'Informe o código da sala'},
    uniqueness: { message: 'Uma sala com esse código já foi cadastra'}


# Validates end Here

  private
    def params_upcase
      self.code.upcase!
    end

end
