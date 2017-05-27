class CreateExtensions < ActiveRecord::Migration[5.0]
  def change
    create_table :extensions do |t|
      t.string :name
      t.string :responsible
      t.integer :capacity
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
