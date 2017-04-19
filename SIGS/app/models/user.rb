class User < ApplicationRecord
  has_one :coordinator, dependent: :destroy
  has_one :administrative_assistant, dependent: :destroy
  has_one :department_assistant, dependent: :destroy
  has_secure_password
  accepts_nested_attributes_for :department_assistant, :reject_if => :all_blank
  accepts_nested_attributes_for :coordinator, :reject_if => :all_blank
  accepts_nested_attributes_for :administrative_assistant


#name
validates_length_of :name,
		:within => 7..100,
		:too_short => 'O Nome tem deve ter no minimo 7 caracters',
		:too_long => 'Nome deve ter no maximo 100 caracters'

# email
VALID_EMAIL_REGEX = /\A[\w+\-.]+@unb.br\z/i

validates :email, :presence => { :message => 'Email não pode ser vazio' },
	length: { maximum: 50}, :uniqueness => { :message => 'Email já cadastrado no sistema' } ,
	format: { with: VALID_EMAIL_REGEX, :message => 'Insira um e-mail válido'}

# password
validates :password, length: { minimum: 6, maximum: 20, :message => 'Senha deve possuir no mínimo 6 e no máximo de 20 caracteres' }, confirmation: true, on: :create

# cpf
VALID_CPF_REGEX = /\A[0-9]{3}?[0-9]{3}?[0-9]{3}?[0-9]{2}\z/i

validates :cpf, :presence => { :message => 'Cpf nao pode ser vazio' },
	format: { with: VALID_CPF_REGEX, :message => 'Insira um Cpf válido'},
	:uniqueness => {:message => "Cpf já cadastrado no sistema"}

# registration
VALID_REGISTRATION_REGEX = /\A[0-9]{7}\z/i

validates :registration, :presence => { :message => 'Matricula nao pode ser vazio' },
	format: { with: VALID_REGISTRATION_REGEX, :message => 'Insira uma matricula válida'},
	:uniqueness => {:message => "Matricula já cadastrado no sistema"}

end