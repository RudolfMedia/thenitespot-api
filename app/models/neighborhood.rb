class Neighborhood < ActiveRecord::Base
  geocoded_by :address

  has_many :spots
    
  before_validation :geocode, if: ->(n){ n.address.present? && address_changed? }
 
  validates :name, presence: true, length: { in: 2..50 }
  validates :state, presence: true
  validates_numericality_of :longitude, :latitude, message: 'Unable to find given address' 

  before_save :default_label, if: ->(n){ n.label.blank? }

  def address
   return unless name && state 
   [ name, state ].join(', ').titleize
  end

  def address=(value)
    self.name, self.state = value.split(',').map(&:strip)
  end

  def address_changed?
    name_changed? || state_changed?
  end

private

  def default_label
	self.label = name.titleize  
  end

end
