class User < ApplicationRecord
  has_one :coordinator, dependent: :destroy
  has_one :administrative_assistant, dependent: :destroy
  has_one :department_assistant, dependent: :destroy
  has_secure_password
  accepts_nested_attributes_for :department_assistant, :reject_if => :all_blank
  accepts_nested_attributes_for :coordinator, :reject_if => :all_blank
  accepts_nested_attributes_for :administrative_assistant


#name
CHARACTERS_MINIMUM_FOR_THE_NAME_EXCEPTION = 'O Nome deve ter no mínimo 7 caracteres'
CHARACTERS_MAXIMUM_FOR_THE_NAME_EXCEPTION = 'Nome deve ter no máximo 100 caracters'

validates_length_of :name,
		:within => 7..100,
		:too_short => CHARACTERS_MINIMUM_FOR_THE_NAME_EXCEPTION,
		:too_long => CHARACTERS_MAXIMUM_FOR_THE_NAME_EXCEPTION

# email
VALID_EMAIL_REGEX = /\A[\w+\-.]+@unb.br\z/i
EMAIL_EXISTS = 'E-mail já cadastrado no sistema'
NULL_EMAIL = 'E-mail não pode ser vazio'
INVALID_EMAIL = 'Insira um E-mail válido'

validates :email, :presence => { :message => NULL_EMAIL },
	length: { maximum: 50}, :uniqueness => { :message => EMAIL_EXISTS } ,
	format: { with: VALID_EMAIL_REGEX, :message => INVALID_EMAIL}

# password
INVALID_LENGHT_PASSWORD = 'Senha deve possuir no mínimo 6 e no máximo de 20 caracteres'

validates :password, length: { minimum: 6, maximum: 20, :message => INVALID_LENGHT_PASSWORD }, confirmation: true, on: :create


# cpf
VALID_CPF_REGEX = /\A[0-9]{3}?[0-9]{3}?[0-9]{3}?[0-9]{2}\z/i
CPF_EXISTS = 'Cpf já cadastrado no sistema'
NULL_CPF = 'Cpf nao pode ser vazio'
INVALID_CPF = 'Insira um Cpf válido'

validates :cpf, :presence => { :message => NULL_CPF },
  :uniqueness => {:message => CPF_EXISTS },
	format: { with: VALID_CPF_REGEX, :message => INVALID_CPF }

# registration
VALID_REGISTRATION_REGEX = /\A[0-9]{7}\z/i
REGISTRATION_EXISTS = 'Matricula já cadastrado no sistema'
NULL_REGISTRATION = 'Matricula nao pode ser vazio'
INVALID_REGISTRATION = 'Insira uma matricula válida'

validates :registration, :presence => { :message => NULL_REGISTRATION },
	format: { with: VALID_REGISTRATION_REGEX, :message => INVALID_REGISTRATION},
	:uniqueness => {:message => REGISTRATION_EXISTS }


end
