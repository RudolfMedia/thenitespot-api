class ChangeDateToDateTimeInSpecials < ActiveRecord::Migration

  def change
  	change_column :specials, :start_date, :datetime
  	change_column :specials, :end_date, :datetime
  	change_column :specials, :expiration_date, :datetime
  end
end
