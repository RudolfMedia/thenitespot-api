class AddDefaultPrimaryToImages < ActiveRecord::Migration
  
  def change
  	change_column :images, :primary, :boolean, default: false
  end
end
