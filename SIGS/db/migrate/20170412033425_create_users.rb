class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :cpf
      t.string :registration
      t.integer :active #0 => pendente, 1 => aceito, 2 => desativado

      t.timestamps
    end
  end
end
