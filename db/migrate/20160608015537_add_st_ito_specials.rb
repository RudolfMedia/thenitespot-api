class AddStItoSpecials < ActiveRecord::Migration

  def change
  	change_table :specials do |t|
  		t.string :type
  		t.date :start_date
  		t.date :end_date
  		t.date :expiration_date
  	end
  end
end
