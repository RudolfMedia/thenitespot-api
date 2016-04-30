module Daily
  extend ActiveSupport::Concern

  included do 
    validates_presence_of :days
    validate :valid_days_of_week?
    scope :current, ->{ where("#{table_name}.days @> ? ", "{#{today}}") }
  end

  module ClassMethods
    
    def today
      Date.today.wday 
    end

  end
 

  def valid_days_of_week?
    if !days.is_a?(Array) || days.find { |d| !('1'..'7').include? d }
      self.errors.add(:days, 'Invalid day selection')
    end
  end

end