class UserRoleSerializer < ActiveModel::Serializer
  attributes :id, :role 
  has_one :user 
end
