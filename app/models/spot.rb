class Spot < ActiveRecord::Base
  include Categorizable 
  # include UserRoleable
  include Imageable
  extend FriendlyId

  friendly_id :slug_candidates, use: :slugged


  has_many :user_roles, dependent: :delete_all

  with_options class_name: 'UserRole', dependent: :delete_all do 
    has_many :admin_roles,  ->{ admins }
    has_many :editor_roles, ->{ editors }
  end

  with_options source: :user do 
    has_many :admin_users, through: :admin_roles
    has_many :editor_users, through: :editor_roles
  end

  validates_presence_of :admin_roles


  has_many :spot_features, dependent: :destroy 
  has_many :features, through: :spot_features

  has_many :specials, dependent: :destroy
  has_many :current_specials, ->{ current }, class_name: 'Special' 
  validates_length_of :specials, maximum: 42, message: 'A Nitespot may have up to 42 specials'

  has_many :hours, dependent: :destroy
  validates_length_of :hours, maximum: 14, message: 'A Nitespot may have up to 14 sets of hours'

  has_many :menus, dependent: :destroy
  validates_length_of :menus, maximum: 6, message: 'A Nitespot may have up to 6 menus'
     
  has_many :events, dependent: :destroy
  has_many :upcoming_events, ->{ upcoming }, class_name: 'Event'

  validates_length_of :events, maximum: 20, message: 'A Nitespot may have up to 20 events at a time' 

  has_many :favorites, dependent: :destroy 
  has_many :favorite_users, through: :favorites, source: :user

  has_many :checkins, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy 
  #default_scope ->{ includes(:hours,:specials,:categories,:features) }

  #PRICE_RANGES 	  =  ['$','$$','$$$','$$$$'] #{ '$' => 'low pricing', '$$' => 'moderate pricing', '$$$' => 'high pricing', '$$$$' => 'fine dining' }
  PAYMENT_OPTIONS = ['visa', 'mastercard', 'amex', 'discover']
  
  geocoded_by :address 
  before_validation :geocode, if: ->(s){ s.address_changed? && !s.new_record? } # AND LAT LNG NOT PRESENT!...

  validates_presence_of :name, :street, :city, :state #,:phone
  validates :name, length: { in: (3..30) }, unreserved_name: true 
  validate :eat_drink_or_attend?
  validates_numericality_of :longitude, :latitude, message: 'Unable to locate address' 

  with_options allow_blank: true do 
  	# validates :price, inclusion: { in: [ 0, 1, 2, 3, 4 ] }
    validates :about, length: { maximum: 500 }
    validates :email, email: true

	  with_options url: true do 
	    validates :website_url
	    validates :reservation_url
	    validates :facebook_url
	    validates :twitter_url
	  end
  end 
  
  validate :valid_payment_options?, if: ->(s){ s.payment_opts.present? }

  scope :assocs, ->{ includes(:categories, :features, :current_specials, :hours, :primary_image, :events) }

  scope :eat,   ->{ where eat: true }
  scope :drink, ->{ where drink: true }
  scope :attend,->{ where attend: true }

  #Searchby filters...
  scope :q,     ->(q){ where('spots.name iLIKE ?', "#{q}%") }
  scope :ctg,   ->(ids){ where(categories: { id: ids })  }
  scope :ftr,   ->(ids){ where(features: { id: ids })  }

  
  def address
  	return unless street && city && state 
  	[ street, city, state ].join(', ').titleize
  end

  def address=(value)
    self.street, self.city, self.state = value.split(',').map(&:strip)
  end

  def distance=(value)
    value
  end

  # def price_range
  #   Spot::PRICE_RANGES[price] if price 
  # end

  def address_changed?
  	street_changed? || city_changed? || state_changed?
  end

  def normalize_friendly_id(string)
    super(string.gsub("'", ""))
  end

  def self.geolocate(position, radius)
    where(id: self.near(position,radius, select: "#{table_name}.id").map(&:id))
  end

private

  def eat_drink_or_attend?
  	unless eat || drink || attend 
  	  errors.add(:base, 'Must select atleast one primary service.')
  	end
  end

  def valid_payment_options?
    if !payment_opts.is_a?(Array) || payment_opts.find{ |opts| !PAYMENT_OPTIONS.include? opts } 
      errors.add(:payment_opts, 'Invalid payment option selected')
    end
  end


  def slug_candidates
  	[ :name, [ :name, :city ] ]
  end
end
