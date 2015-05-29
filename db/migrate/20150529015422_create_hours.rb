class CreateHours < ActiveRecord::Migration
  def change
    create_table :hours do |t|
      t.references :spot, index: true, foreign_key: true
      t.time :open,  null: false
      t.time :close, null: false
      t.string :days, array: true, default: []
      t.string :note

      t.timestamps null: false
    end
  end
end
