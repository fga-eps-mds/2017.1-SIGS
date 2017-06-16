class CreatePeriods < ActiveRecord::Migration[5.0]
  def change
    create_table :periods do |t|
      t.date :initial_date
      t.date :final_date
      t.string :period_type

      t.timestamps
    end
  end
end
