class CreateSchoolRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :school_rooms do |t|
      t.string :name
      t.boolean :active
      t.integer :students_amount
      t.references :discipline, foreign_key: true
      t.timestamps
    end
  end
end
