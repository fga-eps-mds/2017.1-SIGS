class CreateUserApis < ActiveRecord::Migration[5.0]
  def change
    create_table :user_apis do |t|
      t.string :name
      t.string :email
      t.string :secret
      t.string :token

      t.timestamps
    end
  end
end
