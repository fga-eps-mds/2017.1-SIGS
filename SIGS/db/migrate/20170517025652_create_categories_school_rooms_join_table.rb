class CreateCategoriesSchoolRoomsJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :categories, :school_rooms do |t|
      t.index [:category_id, :school_room_id]
      t.index [:school_room_id, :category_id]
    end
  end
end
