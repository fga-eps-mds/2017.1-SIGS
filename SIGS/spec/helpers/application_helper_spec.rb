require 'rails_helper'
require 'sessions_controller'

RSpec.describe ApplicationHelper, type: :helper do

  describe 'Testing ApplicationHelper methods' do
    it 'Show return require message' do
      flash[:notice] = 'Message Test'
      expect(flash_message).to eq('Message Test')
    end
  end
end