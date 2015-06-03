class Hour < ActiveRecord::Base
  include Daily
  belongs_to :spot
  validates_associated :spot 
  
  validates_presence_of :open, :close, :spot_id
  validates :note, length: { maximum: 75, too_long: "%{count} characters is the maximum allowed."}, allow_blank: true 
  
end
