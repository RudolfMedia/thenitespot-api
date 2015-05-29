class SpecialSerializer < ActiveModel::Serializer
  attributes :id, :name, :sort, :description, 
             :days, :start_time, :end_time 
end
