class CreateJoinTableAllocationsSchoolRooms < ActiveRecord::Migration[5.0]
  def change
    create_join_table :allocations, :school_rooms do |t|
      t.index [:allocation_id, :school_room_id], :name => 'index_allocations_school_rooms'
      t.index [:school_room_id, :allocation_id], :name => 'index_school_rooms_allocations'
    end
  end
end
