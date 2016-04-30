class UserRoleSerializer < ActiveModel::Serializer
  attributes :id, :role, :created_at 
  has_one :user 
  
end
