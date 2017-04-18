class CreateDisciplines < ActiveRecord::Migration[5.0]
  def change
    create_table :disciplines do |t|
      t.string :code
      t.string :name
      t.references :departament, foreign_key: true

      t.timestamps
    end
  end
end
