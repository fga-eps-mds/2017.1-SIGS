class CreateParsers < ActiveRecord::Migration[5.0]
  def change
    create_table :parsers do |t|

      t.timestamps
    end
  end
end
