class CreateJoinTableAllocationEducationsSchoolRooms < ActiveRecord::Migration[5.0]
  def change
    create_join_table :AllocationEducations, :SchoolRooms do |t|
      t.index [:allocation_education_id, :school_room_id] , name: 'education_school_room'
      t.index [:school_room_id, :allocation_education_id] , name: 'school_room_education'
    end

    rename_table :AllocationEducations_SchoolRooms, :allocation_educations_school_rooms
  end
end
