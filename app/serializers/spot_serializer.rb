class SpotSerializer < ActiveModel::Serializer
  attributes :id, :name, :slug, :address, :eat, :drink, :attend, 
             :longitude, :latitude, # :distance,
             :phone, :email, :about, :price_range, 
             :website_url, :reservation_url,:menu_url,
             :facebook_url, :twitter_url

  has_one :neighborhood
  has_many :hours 
  has_many :features
  has_many :categories 
  has_many :specials
  has_many :menus 
end
