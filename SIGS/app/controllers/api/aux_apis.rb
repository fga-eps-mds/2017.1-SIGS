# frozen_string_literal: true

# Module de AuxApis
module AuxApis
  def self.generate_school_room(allocations)
    hash = {}
    allocations.each do |allocation|
      hash[allocation.id] = {
        discipline_name: allocation.school_room.discipline.name,
        discipline_code: allocation.school_room.discipline.code,
        school_room_name: allocation.school_room.name,
        school_room_vacancies: allocation.school_room.vacancies,
        room_name: allocation.room.name,
        room_capacity: allocation.room.capacity
      }
    end
    hash
  end

  def self.discipline_allocations_to_json(allocations, code)
    hash = {}
    allocations.each do |allocation|
      hash[code] = {
        building_name: allocation.room.building.name,
        department_name: allocation.room.department.name,
        department_code: allocation.room.department.code,
        room_name: allocation.room.name,
        room_code: allocation.room.code,
        room_capacity: allocation.room.capacity,
        school_room_name: allocation.school_room.name,
        school_room_vacancies: allocation.school_room.vacancies,
        allocation_day: allocation.day,
        allocation_start_time: allocation.start_time.strftime('%H:%M'),
        allocation_final_time: allocation.final_time.strftime('%H:%M')
      }
    end
    hash
  end

  def self.department_allocations_to_json(allocations)
    hash = {}
    allocations.each do |allocation|
      hash[allocation.room.code] = {
        room_name: allocation.room.name,
        room_capacity: allocation.room.capacity,
        discipline_name: allocation.school_room.discipline.name,
        discipline_code: allocation.school_room.discipline.code,
        school_room_name: allocation.school_room.name,
        school_room_vacancies: allocation.school_room.vacancies,
        allocation_day: allocation.day,
        allocation_start_time: allocation.start_time.strftime('%H:%M'),
        allocation_final_time: allocation.final_time.strftime('%H:%M')
      }
    end
    hash
  end

  def self.rooms_allocations_to_json(allocations)
    count = 0
    hash = []
    allocations.each do |allocation|
      hash[count] = {
        discipline_name: allocation.school_room.discipline.name,
        discipline_code: allocation.school_room.discipline.code,
        school_room_name: allocation.school_room.name,
        school_room_vacancies: allocation.school_room.vacancies,
        allocation_day: allocation.day,
        allocation_start_time: allocation.start_time.strftime('%H:%M'),
        allocation_final_time: allocation.final_time.strftime('%H:%M')
      }
      count += 1
    end
    hash
  end
end
