# frozen_string_literal: true

# module to show messages
module ApplicationHelper
  def flash_message
    messages = ''
    [:notice, :info, :warning, :error].each do |type|
      messages += flash[type].to_s
    end
    messages
  end
end
