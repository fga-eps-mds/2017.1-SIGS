class CreateAllocations < ActiveRecord::Migration[5.0]
  def change
    create_table :allocations do |t|
      t.boolean :active
      t.time :start_time
      t.time :final_time
      t.date :day
      t.integer :periodicity, default: 0 # 0 => semanal 1 => mensal
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      t.references :allocation_type, foreign_key: true

      t.timestamps
    end
  end
end
