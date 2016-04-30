class MenuSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :sort, :items_attributes

  def items_attributes
    object.items 
  end

end
