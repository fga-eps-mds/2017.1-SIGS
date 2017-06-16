# frozen_string_literal: true

# aplication mailer
class ApplicationMailer < ActionMailer::Base
  default from: 'example@default.com'
  layout 'mailer'
end
