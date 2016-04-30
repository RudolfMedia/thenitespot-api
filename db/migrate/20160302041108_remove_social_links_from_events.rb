class RemoveSocialLinksFromEvents < ActiveRecord::Migration

  def change
  	remove_column :events, :facebook_url
  	remove_column :events, :twitter_url
  end
end
