class UserRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :spot
  enum role: [ :admin, :editor ]

  validates_presence_of :user_id 
  validates_inclusion_of :role, in: roles, allow_blank: true 
  validates_uniqueness_of :user, scope: :spot, message: 'User already assigned.'
 
  scope :admins,  ->{ where role: 0 }
  scope :editors, ->{ where role: 1 }

  after_update :ensure_admin
  after_destroy :ensure_admin 
  
  before_save :set_role 
  
private 

  def ensure_admin
    raise EnsureAdminError if !spot.valid? #{}"#{resource_type} requires aleast 1 administraive user."
  end

  def set_role
    self.role ||= 'editor'
  end
  
end