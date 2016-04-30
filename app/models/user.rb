class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [ :facebook ]
  include DeviseTokenAuth::Concerns::User
  mount_uploader :avatar, AvatarUploader

  has_many :user_roles, dependent: :restrict_with_error
  has_many :spots, through: :user_roles
  has_many :events, through: :spots 

  has_many :favorites, dependent: :destroy
  has_many :favorite_spots, through: :favorites, source: :spot

  has_many :checkins, dependent: :destroy
  has_many :reports, dependent: :destroy   

  validates_presence_of :name, :location
  validates :gender, inclusion: { in: %w( male female ) }, allow_blank: true

  before_save :skip_confirmation!, if: :new_record? 

  def avatar_data_filename
    random_filename
  end

  def random_filename
    @string ||= "#{SecureRandom.urlsafe_base64}.jpg"
  end

  def favorite_spot_ids
    favorite_spots.ids 
  end

  def is_admin_of?(spot)
    user_roles.admins.exists? spot: spot 
  end 

  def can_update?(spot)
    user_roles.exists? spot: spot 
  end

  def as_json(options = {})
    super({ include: :user_roles, methods: [:favorite_spot_ids]})
  end

end