class CreateCategoriesRoomsJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :categories, :rooms do |t|
      t.index [:category_id, :room_id]
      t.index [:room_id, :category_id]
    end
  end
end
