class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :cpf
      t.string :password
      t.string :registration
      t.boolean :active

      t.timestamps
    end
  end
end
