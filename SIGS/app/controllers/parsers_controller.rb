class ParsersController < ApplicationController

  def upload
    document = params[:document]
    if document
      File.open(Rails.root.join('public', 'csv', 'file.csv'), 'wb') do |file|
        file.write(document.read)
      end
      Parser.save_data('public/csv/file.csv')
      redirect_to 'http://0.0.0.0:3000/'
    else
      redirect_to 'http://0.0.0.0:3000/parsers'
    end
  end
  
end
