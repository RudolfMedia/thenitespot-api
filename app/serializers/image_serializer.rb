class ImageSerializer < ActiveModel::Serializer
  attributes :id, :primary, :url, :medium_url, :small_url 

  def url
   object.file.url 
  end

  def medium_url
    object.file.url(:medium)
  end

  def small_url
    object.file.url(:small)
  end
end
