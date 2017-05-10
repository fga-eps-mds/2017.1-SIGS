# frozen_string_literal: true

require 'csv'

# Classe responsavel por ler csv e salvar na database
class Parser < ApplicationRecord
  def self.save_data_rooms(file)
    CSV.foreach(file, col_sep: ',', headers: true, encoding: 'Windows-1252') do |row|
      room_record = Room.find_or_create_by(code: row[0], name: row[1],
                                           capacity: row[2], building_id: row[3],
                                           active: row[4], time_grid_id: row[5])
      room_record.save
    end
  end

  def self.save_data_buildings(file)
    CSV.foreach(file, col_sep: ',', headers: true, encoding: 'Windows-1252') do |row|
      build_record = Building.find_or_create_by(code: row[0], name: row[1],
                                                wing: row[2])
      build_record.save
    end
  end

  def self.save_data_departments(file)
    CSV.foreach(file, col_sep: ',', headers: true, encoding: 'Windows-1252') do |row|
      row2_data = row[2]
      departament_record = Department.find_or_create_by(code: row[0],
                                                        acronym: row2_data,
                                                        name: row2_data)
      departament_record.save
    end
  end

  def self.save_data_courses(file)
    CSV.foreach(file, col_sep: ',', headers: true, encoding: 'Windows-1252') do |row|
      department_record = Department.find_or_create_by(name: row[3])
      courses_record = Course.find_or_create_by(code: row[0], name: row[1],
                                                shift: row[2],
                                                department_id: department_record.id)
      courses_record.save
    end
  end

  def self.save_data_disciplines(file)
    CSV.foreach(file, col_sep: ',', headers: true, encoding: 'Windows-1252') do |row|
      departament_record = Department.find_or_create_by(name: row[3])
      discipline_record = Discipline.find_or_create_by(code: row[0],
                                                       name: row[1],
                                                       department_id:
                                                       departament_record.id)
      discipline_record.save
    end
  end
end
