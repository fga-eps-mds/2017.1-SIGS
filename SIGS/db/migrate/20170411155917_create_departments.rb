class CreateDepartments < ActiveRecord::Migration[5.0]
  def change
    create_table :departments do |t|
      t.string :code
      t.string :name
      t.string :wing
      t.string :acronym

      t.timestamps
    end
  end
end
