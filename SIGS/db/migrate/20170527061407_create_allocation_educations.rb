class CreateAllocationEducations < ActiveRecord::Migration[5.0]
  def change
    create_table :allocation_educations do |t|
      t.references :school_room, foreign_key: true

      t.timestamps
    end
  end
end
