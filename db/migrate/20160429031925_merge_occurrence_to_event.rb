class MergeOccurrenceToEvent < ActiveRecord::Migration

  def change
  	change_table :events do |t|
  		t.date     :start_date,      null: false
    	t.time     :start_time
    	t.date     :end_date
    	t.time     :end_time
    	t.date     :expiration_date, null: false
    	t.index    :start_date
  	end
  	drop_table :occurrences
  end

end
