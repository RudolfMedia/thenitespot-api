class OccurrenceSerializer < ActiveModel::Serializer
  attributes :id,
             :start_date, :start_time,
             :end_date, :end_time,
             :expiration_date 
end
