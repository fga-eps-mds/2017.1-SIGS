class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :code
      t.string :name
      t.integer :shift
      t.references :department, foreign_key: true


      t.timestamps
    end
  end
end
