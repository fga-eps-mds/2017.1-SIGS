class CreateCoordinators < ActiveRecord::Migration[5.0]
  def change
    create_table :coordinators do |t|
      t.string :name
      t.string :email
      t.string :cpf
      t.string :registration
      t.boolean :active
      t.references :department, foreign_key: true
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
