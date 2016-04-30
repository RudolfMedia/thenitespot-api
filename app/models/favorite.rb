class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :spot, counter_cache: true

  validates_presence_of   :spot_id, :user_id
  validates_uniqueness_of :spot_id, scope: :user_id 

end
