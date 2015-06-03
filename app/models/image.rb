class Image < ActiveRecord::Base
  require 'carrierwave/orm/activeRecord'
  mount_uploader :file, ImageUploader
  belongs_to :imageable, polymorphic: true
  
  validates_presence_of :imageable_id, :imageable_type, :file 

  before_save :update_imageable_primary, if: ->(img){ img.primary? && img.primary_changed? }

  scope :primary, ->{ where primary: true }

private 

  def update_imageable_primary
    imageable_siblings.update_all(primary: false)
  end

  def imageable_siblings
    Image.where(imageable_id: imageable_id, imageable_type: imageable_type).where.not(id: id)
  end

end
