# frozen_string_literal: true

# class to upload parser informations to the system
class ParsersController < ApplicationController
  def upload_rooms
    if document
      open_file('file_rooms.csv')
      Parser.save_data_rooms('public/csv/file_rooms.csv')
      home
    else
      parsers
    end
  end

  def upload_buildings
    if document
      open_file('file_buildings.csv')
      Parser.save_data_buildings('public/csv/file_buildings.csv')
      home
    else
      parsers
    end
  end

  def upload_departments
    if document
      open_file('file_departments.csv')
      Parser.save_data_departments('public/csv/file_departments.csv')
      home
    else
      parsers
    end
  end

  def upload_courses
    if document
      open_file('file_courses.csv')
      Parser.save_data_courses('public/csv/file_courses.csv')
      home
    else
      parsers
    end
  end

  def upload_disciplines
    if document
      open_file('file_disciplines.csv')
      Parser.save_data_disciplines('public/csv/file_disciplines.csv')
      home
    else
      parsers
    end
  end

  # redireciona para parsers
  def parsers
    redirect_to 'http://192.168.2.15:3000/parsers'
  end

  # redireciona para home
  def home
    redirect_to 'http://192.168.2.15:3000/'
  end

  # recebe paramento do formulario
  def document
    document = params[:document]
  end

  # ler o arquivo csv e salva um novo em public/csv e chama a model
  # Parser para pessistir os dados
  def open_file(arquivo)
    File.open(Rails.root.join('public', 'csv', arquivo), 'wb') do |file|
      file.write(document.read)
    end
  end
end
