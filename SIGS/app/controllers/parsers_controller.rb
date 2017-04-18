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

  def upload_departments
    document = params[:document]
    if document
      File.open(Rails.root.join('public', 'csv', 'file_departments.csv'), 'wb') do |file|
        file.write(document.read)
      end

      Parser.save_data_departments('public/csv/file_departments.csv')
      redirect_to 'http://192.168.2.15:3000/'

    else
      redirect_to 'http://192.168.2.15:3000/parsers'
    end
  end

  def upload_courses
    document = params[:document]
    if document
      File.open(Rails.root.join('public', 'csv', 'file_courses.csv'), 'wb') do |file|
        file.write(document.read)
      end
        
      Parser.save_data_courses('public/csv/file_courses.csv')
      redirect_to 'http://192.168.2.15:3000/'

    else
      redirect_to 'http://192.168.2.15:3000/parsers'
    end
  end

  def upload_disciplines
    document = params[:document]
    if document
      File.open(Rails.root.join('public', 'csv', 'file_disciplines.csv'), 'wb') do |file|
        file.write(document.read)
      end
      Parser.save_data_disciplines('public/csv/file_disciplines.csv')
      redirect_to 'http://0.0.0.0:3000/'
    else
      redirect_to 'http://0.0.0.0:3000/parsers'
    end
  end

end
