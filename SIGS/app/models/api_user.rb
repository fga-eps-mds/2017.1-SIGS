# frozen_string_literal: true

# Classe modelo do Usuario de API
class ApiUser < ApplicationRecord
  belongs_to :user

  # Nome
  CHARACTERS_MINIMUM_FOR_THE_NAME_EXCEPTION = 'O Nome deve ter
                                               no mínimo 7 caracteres'.freeze
  CHARACTERS_MAXIMUM_FOR_THE_NAME_EXCEPTION = 'O Nome deve ter
                                               no máximo 100 caracters'.freeze

  validates :name, format: { with: /\A[^0-9`!@#\$%\^&*+_=]+\z/,
                             message: 'O campo Nome só pode conter letras' },
                   length: { within: 7..100,
                             too_short: CHARACTERS_MINIMUM_FOR_THE_NAME_EXCEPTION,
                             too_long: CHARACTERS_MAXIMUM_FOR_THE_NAME_EXCEPTION }

  # Email
  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  EMAIL_EXISTS = 'E-mail já cadastrado no sistema'.freeze
  INVALID_EMAIL = 'Insira um E-mail válido'.freeze
  CHARACTERS_MINIMUM_FOR_THE_EMAIL_EXCEPTION = 'O E-mail deve ter
                                               no mínimo 7 caracteres'.freeze
  CHARACTERS_MAXIMUM_FOR_THE_EMAIL_EXCEPTION = 'O E-mail deve ter
                                               no máximo 60 caracteres'.freeze

  validates :email, uniqueness: { message: EMAIL_EXISTS },
                    format: { with: VALID_EMAIL_REGEX, message: INVALID_EMAIL },
                    length: { within: 7...60,
                              too_short: CHARACTERS_MINIMUM_FOR_THE_EMAIL_EXCEPTION,
                              too_long: CHARACTERS_MAXIMUM_FOR_THE_EMAIL_EXCEPTION }
end
