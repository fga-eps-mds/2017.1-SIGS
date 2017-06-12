class CreateSolicitations < ActiveRecord::Migration[5.0]
  def change
    create_table :solicitations do |t|
      t.string :justify, null: false
      t.integer :status, null: false, default: 0 # 0 => pendente, 1 => Aceito, 2 => Recusado
      t.date :request_date, null: false
      t.references :requester, index: true, foreign_key: { to_table: :users }, null: false
      t.references :school_room, foreign_key: true
      t.timestamps
    end
  end
end
