class CreatePeriods < ActiveRecord::Migration[5.0]
  def change
    create_table :periods do |t|
      t.datetime :initial_date
      t.datetime :final_date
      t.string :period_type

      t.timestamps
    end
  end
end
