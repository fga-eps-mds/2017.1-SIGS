class CreateAllAllocationDates < ActiveRecord::Migration[5.0]
  def change
    create_table :all_allocation_dates do |t|
      t.date :day
      t.references :allocation, foreign_key: true
      t.references :allocation_extension, foreign_key: true

      t.timestamps
    end
  end
end
