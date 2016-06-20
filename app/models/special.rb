class Special < ActiveRecord::Base
  include Sortable

  belongs_to :spot, touch: true 
  validates_associated :spot 

  TYPES = %w(WeeklySpecial FeaturedSpecial)
  
  validates :name, length: { in: 3..45, wrong_length: 'Must be between 3 and 45 characters' }
  validates :description, length: { maximum: 250, too_long: "%{count} characters is the maximum allowed."}, allow_blank: true 
  validates :type, inclusion: { in: Special::TYPES }
  validates_presence_of :spot_id 



end
