class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.string :code
      t.string :name
      t.integer :capacity
      t.boolean :active
      t.integer :time_grid_id

      t.belongs_to :building, index: true

      t.timestamps
    end
  end
end
