class Event < ActiveRecord::Base
  include Categorizable
  include Imageable
  
  belongs_to :spot
  before_save :set_expiration_date 

  delegate :address, to: :spot 

  validates_presence_of :spot_id, :name, :age, :entry
  validates :name, length: { in:  (3..45) }, unreserved_name: true 

  validates :start_date, presence: true 

  AGES = [ 'all ages', '18+', '21+' ]
  ENTRY_TYPES = [ 'free', 'cover', 'ticket' ]

  validates :age, inclusion: { in: AGES }
  validates :entry, inclusion: { in: ENTRY_TYPES }
  validates :entry_fee, presence: true, if: ->(e){ ENTRY_TYPES.last(2).include? e.entry }


  with_options allow_blank: true do 
    validates :about, length: { maximum: 500 }
    validates :email, email: true
    validates :phone, length: { maximum: 25 } 

    with_options url: true do
     validates :ticket_url 
     validates :website_url
    end
  end

  validate :dates_are_not_in_the_past, 
           :dates_are_within_one_year, 
           :dates_are_in_order, unless: ->(e){ e.start_date.blank? }
  
  private

    def set_expiration_date
     self.expiration_date = end_date || start_date
    end
  
    def dates_are_not_in_the_past
     if start_date < Date.today || (end_date && end_date < Date.today)
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
