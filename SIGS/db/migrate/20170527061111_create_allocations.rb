class CreateAllocations < ActiveRecord::Migration[5.0]
  def change
    create_table :allocations do |t|
      t.boolean :active
      t.time :start_time
      t.time :final_time
      t.string :day
      # t.integer :periodicity, default: 0 # 0 => semanal 1 => mensal
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      # t.references :allocable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
