# frozen_string_literal: true

# Classe modelo do Usuario de API
class ApiUser < ApplicationRecord
  belongs_to :user

  # Nome
  CHARACTERS_MINIMUM_FOR_THE_NAME_EXCEPTION = 'O Nome deve ter
                                               no mínimo 5 caracteres'.freeze
  CHARACTERS_MAXIMUM_FOR_THE_NAME_EXCEPTION = 'Nome deve ter
                                               no máximo 100 caracters'.freeze

  validates_length_of :name,
                      within: 5..100,
                      too_short: CHARACTERS_MINIMUM_FOR_THE_NAME_EXCEPTION,
                      too_long: CHARACTERS_MAXIMUM_FOR_THE_NAME_EXCEPTION

  # Email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@unb.br\z/i
  EMAIL_EXISTS = 'E-mail já cadastrado no sistema'.freeze
  NULL_EMAIL = 'E-mail não pode ser vazio'.freeze
  INVALID_EMAIL = 'Insira um E-mail válido'.freeze

  validates :email, presence: { message: NULL_EMAIL },
                    length: { maximum: 50 }, uniqueness: { message: EMAIL_EXISTS },
                    format: { with: VALID_EMAIL_REGEX, message: INVALID_EMAIL }
end
