class SpotSerializer < ActiveModel::Serializer
  attributes :id, :name, :slug, :eat, :drink, :attend, 
             :address, :street, :city, :state,
             :longitude, :latitude, :distance,
             :phone, :email, :about, 
             :payment_opts, :price, 
             :website_url, :reservation_url, :menu_url,
             :category_ids, :feature_ids,
             :favorites_count, :menus_count,
             :updated_at         
  
  def distance
    object.distance.round(2) if object.respond_to? :distance 
  end

  has_one :primary_image 
  has_many :hours 
  has_many :current_specials
  has_many :events
  
end

