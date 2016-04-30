class AddMenusCounterCacheToSpots < ActiveRecord::Migration

  def change
  	add_column :spots, :menus_count, :integer, default: 0
  end
  
end
