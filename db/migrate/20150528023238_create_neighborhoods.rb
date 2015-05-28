class CreateNeighborhoods < ActiveRecord::Migration
  def change
    create_table :neighborhoods do |t|
      t.string :name
      t.string :label
      t.string :state
      t.float :longitude
      t.float :latitude
      t.integer :spots_count, default: 0

      t.timestamps null: false
    end
  end
end
