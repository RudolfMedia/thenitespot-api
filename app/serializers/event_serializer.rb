class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :slug,
             :about, :age, :entry, :entry_fee,
             :phone, :email, :website_url,
             :ticket_url, :facebook_url, :twitter_url
  
  has_one :spot
  has_one :primary_image
  has_many :images   
  has_many :occurrences 
end
