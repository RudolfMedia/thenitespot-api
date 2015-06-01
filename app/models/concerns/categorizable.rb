module Categorizable
  extend ActiveSupport::Concern

  included do 
    has_many :categorizations, as: :categorizable, dependent: :destroy
    has_many :categories, through: :categorizations
    has_many :subcategories, through: :categories 
    validates_length_of :categorizations, maximum: 4, message: '4 category maximum.'
  end

end