class ChangeSpotPriceToInteger < ActiveRecord::Migration
  def change
  	remove_column :spots, :price
    add_column :spots, :price, :integer, default: 0
  end
end
