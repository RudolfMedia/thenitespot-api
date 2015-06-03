class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.references :user, index: true, foreign_key: true
      t.references :spot, index: true, foreign_key: true
      t.integer :count, default: 0 

      t.timestamps null: false
    end
  end
end
