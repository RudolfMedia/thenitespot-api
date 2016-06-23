class ChangeTimeColumnsToDateTime < ActiveRecord::Migration

  def change
  	remove_column :specials, :start_time, :time
  	remove_column :specials, :end_time, :time
  	remove_column :events, :start_time, :time
  	remove_column :events, :end_time, :time
  	remove_column :hours, :open, :time
  	remove_column :hours, :close, :time

  	add_column :specials, :start_time, :datetime
  	add_column :specials, :end_time, :datetime
  	add_column :events, :start_time, :datetime
  	add_column :events, :end_time, :datetime
  	add_column :hours, :open, :datetime
  	add_column :hours, :close, :datetime

  end
end
