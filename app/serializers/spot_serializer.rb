class SpotSerializer < ActiveModel::Serializer
  attributes :id, :name, :slug, :address, :eat, :drink, :attend, 
             :longitude, :latitude, # :distance,
             :phone, :email, :about, :payment_opts, :price_range, 
             :website_url, :reservation_url,:menu_url,
             :facebook_url, :twitter_url

  has_one :primary_image 
  has_one :neighborhood
  has_many :hours 
  has_many :features
  has_many :categories 
  has_many :specials
  has_many :menus
  has_many :events

  #has_many :admin_users
  #has_many :editor_users
  #has_many :reports   
  #has_many :favorite_users
  #has_many :checkins
  #has_many :reports*

end
