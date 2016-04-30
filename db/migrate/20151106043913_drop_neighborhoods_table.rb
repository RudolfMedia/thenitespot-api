class DropNeighborhoodsTable < ActiveRecord::Migration
  def change
  	remove_column :spots, :neighborhood_id 
  	drop_table :neighborhoods
  end
end
