class CreateBuildings < ActiveRecord::Migration[5.0]
  def change
    create_table :buildings do |t|
      t.string :code
      t.string :name
      t.string :wing

      t.timestamps
    end
  end
end
