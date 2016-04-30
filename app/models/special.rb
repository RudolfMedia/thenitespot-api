class Special < ActiveRecord::Base
  include Sortable
  include Daily 

  belongs_to :spot, touch: true 
  validates_associated :spot 
  
  validates :name, length: { in: 3..45, wrong_length: 'Must be between 3 and 45 characters' }
  validates :description, length: { maximum: 250, too_long: "%{count} characters is the maximum allowed."}, allow_blank: true 
  validates_presence_of :spot_id 

  scope :current, ->{ where("days @> ?", "{#{today}}") }

  def self.today
    dow = Date.today.wday
    dow == 0 ? 7 : dow
  end

end
