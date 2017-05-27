class CreateAllocationTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :allocation_types do |table|
      table.integer :type
      table.integer :id_son
      table.timestamps
    end
  end
end
