class CreateCoordinators < ActiveRecord::Migration[5.0]
  def change
    create_table :coordinators do |t|
      t.references :course, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
