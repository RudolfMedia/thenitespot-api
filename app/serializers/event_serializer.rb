class EventSerializer < ActiveModel::Serializer
  attributes :id, :spot_id, :name, :slug,
             :start_date, :start_time, :end_date, :end_time,
             :about, :age, :entry, :entry_fee,
             :phone, :email, :website_url,
             :primary_image,
             :ticket_url,
             :category_ids
  #has_one :spot
  has_one :primary_image
  # has_many :images   
  def primary_image
    object.primary_image
  end

end
