class User < ApplicationRecord
  has_one :coordinator, dependent: :destroy
  has_one :administrative_assistant, dependent: :destroy
  has_one :department_assistant, dependent: :destroy
  has_secure_password
  accepts_nested_attributes_for :department_assistant, :coordinator, :administrative_assistant
end
