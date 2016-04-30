class AddFavoritesCounterCache < ActiveRecord::Migration
  def change
  	add_column :spots, :favorites_count, :integer, default: 0
  end
end
