class RemovePolymorphismFromReports < ActiveRecord::Migration
  def change
  	change_table :reports do |t|
  		t.remove :reportable_id
  		t.remove :reportable_type
  		t.integer :spot_id
  		t.index :spot_id
  	end
  end
end
