module Imageable 
  extend ActiveSupport::Concern
  
  included do 
    has_many :images, as: :imageable, dependent: :destroy 
    has_one  :primary_image, ->{ primary }, as: :imageable, class_name: 'Image'
    accepts_nested_attributes_for :primary_image, :images, reject_if: :all_blank, allow_destroy: true 
  end

end