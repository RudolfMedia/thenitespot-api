class Menu < ActiveRecord::Base
  include Sortable 
  belongs_to :spot, counter_cache: true
  validates_associated :spot 
  
  has_many :items, class_name: 'MenuItem', dependent: :destroy 
  accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true 
  validates_length_of :items, maximum: 50, message: '50 items maximum' 

  validates_presence_of :spot_id 
  validates :name, length: { maximum: 50 }
  validates :description, length: { maximum: 250 }, allow_blank: true 

end
