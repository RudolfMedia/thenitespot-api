# encoding: utf-8
class ImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process resize_to_fit: [ 640, 640 ]

  version :medium do 
    process :resize_to_fill => [ 320, 320 ] 
  end
  
  version :small do 
    process :resize_to_fill => [ 160, 160 ] 
  end 

  def extension_white_list
    %w(jpg jpeg png)
  end

end
