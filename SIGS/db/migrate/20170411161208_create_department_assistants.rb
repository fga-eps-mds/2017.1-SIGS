class CreateDepartmentAssistants < ActiveRecord::Migration[5.0]
  def change
    create_table :department_assistants do |t|
      t.references :Department

      t.timestamps
    end
  end
end
