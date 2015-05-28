class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :sort, :parent_id
  has_many :subcategories 
end
