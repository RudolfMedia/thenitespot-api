class SpotSerializer < ActiveModel::Serializer
  attributes :id, :name, :slug, :address, :eat, :drink, :attend, 
             :longitude, :latitude, :distance,
             :phone, :email, :about, :price_range, 
             :website_url, :reservation_url,:menu_url,
             :facebook_url, :twitter_url
end
