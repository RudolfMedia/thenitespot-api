class Occurrence < ActiveRecord::Base
  belongs_to :event, inverse_of: :occurrences 
  before_save :set_expiration_date 

  validates :start_date, presence: true 
  validate :dates_are_not_in_the_past, 
           :dates_are_within_one_year, 
           :dates_are_in_order, unless: ->(o){ o.start_date.blank? }


  after_destroy :destroy_event, if: :event_is_orphan?

  scope :upcoming, ->{ where("expiration_date >= ?", DateTime.now.beginning_of_day).order(:start_date) }


  def as_json(options = {})
    super({except: [:created_at, :updated_at]})
  end

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

  def event_is_orphan?
   event.occurrences.count.zero?
  end

  def destroy_event
   event.destroy 
  end

  

end

## EVENT ASSOCS

  # has_many :occurrences, dependent: :delete_all
  # has_many :upcoming_occurrences, ->{ upcoming }, class_name: 'Occurrence'
  # accepts_nested_attributes_for :occurrences, reject_if: :all_blank, allow_destroy: true
  # validates_length_of :occurrences, maximum: 5, message: 'An event may have up to 5 seperate occurrences.'
  # default_scope { includes(:occurrences) }
  # scope :upcoming, ->{ joins(:occurrences).merge(Occurrence.upcoming) }
