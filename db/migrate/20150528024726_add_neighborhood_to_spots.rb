class AddNeighborhoodToSpots < ActiveRecord::Migration
  def change
    add_reference :spots, :neighborhood, index: true
    add_foreign_key :spots, :neighborhoods
  end
end
