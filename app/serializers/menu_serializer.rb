class MenuSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :sort 
  has_many :items

end
