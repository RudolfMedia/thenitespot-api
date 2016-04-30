class MenuItem < ActiveRecord::Base
  belongs_to :menu
  # validates_associated :menu
  
  validates_length_of :name, in: 2..50
  validates_length_of :description, maximum: 250, allow_blank: true 
  validates_numericality_of :price

end
