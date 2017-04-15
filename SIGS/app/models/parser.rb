require 'csv'

class Parser < ApplicationRecord

  def self.save_data_rooms(file)
    CSV.foreach(file, col_sep: ',', headers: true, encoding: 'Windows-1252') do |row|
      room_record = Room.find_or_create_by(code: row[0].upcase, name: row[1], 
        capacity: row[2], building_id: row[3], active: row[4], time_grid_id: row[5])
    
      room_record.save
    end
  end

  def self.save_data_buildings(file)
    CSV.foreach(file, col_sep: ',', headers: true, encoding: 'Windows-1252') do |row|
      room_record = Building.find_or_create_by(code: row[0].upcase, name: row[1], 
        wing: row[2])
    
      room_record.save
    end
  end

end
