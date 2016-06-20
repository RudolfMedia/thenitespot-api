class RemoveSocialLinksFromSpot < ActiveRecord::Migration
  def change
  	change_table :spots do |t|
  		t.remove :facebook_url
  		t.remove :twitter_url
  	end

  end
end
