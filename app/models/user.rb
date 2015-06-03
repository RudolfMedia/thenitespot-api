class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [ :facebook ]
  include DeviseTokenAuth::Concerns::User
  
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

private 

  def is_atleast_18
    unless !dob.is_a?(Date) || dob.to_date < 18.years.ago.to_date  
      errors.add(:base, 'Must be 18 years of age to sign up.')
    end
  end

end
