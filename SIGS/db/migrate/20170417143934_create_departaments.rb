class CreateDepartaments < ActiveRecord::Migration[5.0]
  def change
    create_table :departaments do |t|
      t.string :code
      t.string :name
      t.string :acronym

      t.timestamps
    end
  end
end
