class CreateAllocationExtensions < ActiveRecord::Migration[5.0]
  def change
    create_table :allocation_extensions do |t|
      t.references :extension, foreign_key: true
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      t.date :inicial_date
      t.date :final_date
      t.string :periodicity
      t.time :start_time
      t.time :final_time

      t.timestamps
    end
  end
end
