class CreateOccurrences < ActiveRecord::Migration
  def change
    create_table :occurrences do |t|
      t.references :event, index: true, foreign_key: true
      t.date :start_date, null: false, index: true 
      t.time :start_time
      t.date :end_date
      t.time :end_time
      t.date :expiration_date, null: false, index: true 

      t.timestamps null: false
    end
  end
end
