class CreateSchoolRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :school_rooms do |table|
      table.string :name
      table.boolean :active
      table.integer :capacity
      table.references :discipline, foreign_key: true
      table.timestamps
    end
  end
end
