class CreateAllocationExtensions < ActiveRecord::Migration[5.0]
  def change
    create_table :allocation_extensions do |t|
      t.references :extension, foreign_key: true
      t.references :user, foreign_key: true
      
      t.timestamps
    end
  end
end
