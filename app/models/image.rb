class Image < ActiveRecord::Base
 
  mount_uploader :file, ImageUploader
  belongs_to :imageable, polymorphic: true
  
  validates_presence_of :imageable_id, :imageable_type

  after_save :update_imageable_primary, if: ->(img){ img.primary? && img.primary_changed? }

  scope :primary, ->{ where primary: true }

  def self.policy_class
    ImagePolicy
  end
  # carriewave-data-uri for naming...
  def file_data_filename
    random_filename
  end

  def random_filename
    @string ||= "#{SecureRandom.urlsafe_base64}.jpg"
  end

private 

  def update_imageable_primary
    imageable_siblings.update_all(primary: false)
  end

  def imageable_siblings
    Image.where(imageable_id: imageable_id, imageable_type: imageable_type).where.not(id: id)
  end

end
