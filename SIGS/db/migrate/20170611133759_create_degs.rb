class CreateDegs < ActiveRecord::Migration[5.0]
  def change
    create_table :degs do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
