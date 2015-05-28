class Category < ActiveRecord::Base
  include Sortable

  has_many :subcategories, class_name: 'Category', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent_category, class_name: 'Category', foreign_key: 'parent_id'
  has_many :categorizations, dependent: :destroy
  has_many :spots,  through: :categorizations, source: :categorizable, source_type: 'Spot'   
  #has_many :events, through: :categorizations, source: :categorizable, source_type: 'Event'
  
  validates :name, presence: true, uniqueness: true  

  default_scope ->{ includes(:subcategories) }
  scope :main, ->{ where(parent_id: nil) }
  scope :sub,  ->{ where.not(parent_id: nil) }
 
  def to_s
    name.titleize 
  end

end
