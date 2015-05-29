class CreateSpecials < ActiveRecord::Migration
  def change
    create_table :specials do |t|
      t.references :spot, index: true, foreign_key: true
      t.string :name
      t.integer :sort, index: true 
      t.string :description
      t.string :days, array: true, default: []
      t.time :start_time
      t.time :end_time

      t.timestamps null: false
    end
  end
end
