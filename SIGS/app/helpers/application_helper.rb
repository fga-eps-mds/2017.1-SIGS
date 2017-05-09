# frozen_string_literal: true

# module to show messages
class ParsersController < ApplicationController
module ApplicationHelper
  def flash_message
	  messages = ''
	  [:notice, :info, :warning, :error].each { |type|
		  if flash[type]
		  	messages += "#{flash[type]}"
		  end
			else
			end
	  }
  	messages
	end
end