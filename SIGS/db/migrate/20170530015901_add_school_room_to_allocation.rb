class AddSchoolRoomToAllocation < ActiveRecord::Migration[5.0]
  def change
    add_reference :allocations, :school_room, foreign_key: true
  end
end
