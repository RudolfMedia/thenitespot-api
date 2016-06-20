class FeaturedSpecial < Special 

  before_save :set_expiration_date 
  validates :start_date, presence: true 

  validate :dates_are_not_in_the_past, 
           :dates_are_within_one_year, 
           :dates_are_in_order, unless: ->(e){ e.start_date.blank? }

  # scope :current, ->{ where("start_date >= '#{today}' AND expiration_date <= '#{today}'") }
  scope :expired, ->{ where("expiration_date < ?", today) }

  def is_current?
    start_date.to_date == Time.zone.now.to_date
  end

  def self.today
    @today ||= Time.zone.now.to_date
  end

  def self.policy_class
    SpecialPolicy
  end

  private

    def set_expiration_date
     self.expiration_date = end_date || start_date
    end
  
    def dates_are_not_in_the_past
     if start_date < Time.zone.now.to_date || (end_date && end_date < Time.zone.now.to_date)
      errors.add(:base, 'Provided dates cannot be in the past.')
     end 
    end
  
    def dates_are_within_one_year
     if start_date > 1.year.from_now || (end_date && end_date > 1.year.from_now)
      errors.add(:base, 'Event must fall within 1 year from today')
     end
    end
  
    def dates_are_in_order
     if end_date && end_date < start_date 
      errors.add(:base, 'Please recheck dates')
     end 
    end

end

