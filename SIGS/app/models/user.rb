class User < ApplicationRecord
  has_one :coordinator
  has_one :administrative_assistant
  has_one :department_assistant
  has_secure_password
end
