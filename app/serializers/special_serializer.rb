class SpecialSerializer < ActiveModel::Serializer
  attributes :id, :name, :sort, :description, 
             :days, :start_time, :end_time, :start_date, :end_date,
             :expiration_date, :type, :current

   def current
   	  object.is_current? if object.respond_to? :is_current?
   end

end
