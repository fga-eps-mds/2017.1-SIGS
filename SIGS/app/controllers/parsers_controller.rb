class ParsersController < ApplicationController

  def upload_rooms
    document = params[:document]
    if document
      File.open(Rails.root.join('public', 'csv', 'file_rooms.csv'), 'wb') do |file|
        file.write(document.read)
      end
      Parser.save_data_rooms('public/csv/file_rooms.csv')
      redirect_to 'http://0.0.0.0:3000/'
    else
      redirect_to 'http://0.0.0.0:3000/parsers'
    end
  end
  
  def upload_buildings
    document = params[:document]
    if document
      File.open(Rails.root.join('public', 'csv', 'file_buildings.csv'), 'wb') do |file|
        file.write(document.read)
      end
      Parser.save_data_buildings('public/csv/file_buildings.csv')
      redirect_to 'http://0.0.0.0:3000/'
    else
      redirect_to 'http://0.0.0.0:3000/parsers'
    end
  end

end
