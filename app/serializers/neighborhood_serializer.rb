class NeighborhoodSerializer < ActiveModel::Serializer
  attributes :id, :name, :label, 
             :address, :longitude, :latitude,
             :spots_count
end
