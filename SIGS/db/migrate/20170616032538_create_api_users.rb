class CreateApiUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :api_users do |t|
      t.string :name
      t.string :email
      t.string :secret
      t.string :token
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
