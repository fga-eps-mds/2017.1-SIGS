class User < ApplicationRecord
  accepts_nested_attributes_for :administrative_assistant, :department_assistant, :coordinator
  has_one :coordinator, dependent: :destroy
  has_one :administrative_assistant, dependent: :destroy
  has_one :department_assistant, dependent: :destroy
end
