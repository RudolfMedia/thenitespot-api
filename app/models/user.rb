class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [ :facebook ]
  include DeviseTokenAuth::Concerns::User
  mount_uploader :avatar, AvatarUploader

  has_many :user_roles, dependent: :restrict_with_error
  has_many :spots, through: :user_roles, source: :resource, source_type: 'Spot' 
  has_many :events, through: :spots 

  has_many :favorites, dependent: :destroy
  has_many :favorite_spots, through: :favorites, source: :spot

  has_many :checkins, dependent: :destroy
  has_many :reports, dependent: :destroy   

  validates_presence_of :name, :gender, :location, :dob 
  validates :gender, inclusion: { in: %w( male female ) }
  validate  :is_atleast_18

  def age
    now = Date.today
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  def is_admin_of?(resource)
    user_roles.admins.exists? resource: resource 
  end 

  def can_update?(resource)
    user_roles.exists? resource: resource 
  end

 private 

  def is_atleast_18
    unless !dob.is_a?(Date) || dob.to_date < 18.years.ago.to_date  
      errors.add(:base, 'Must be 18 years of age to sign up.')
    end
  end

end