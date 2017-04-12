class User < ApplicationRecord
  has_one :coordinator
  has_one :administrative_assistant
end
