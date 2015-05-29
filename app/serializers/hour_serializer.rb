class HourSerializer < ActiveModel::Serializer
  attributes :id, :open, :close, :days,
             :note 
end
