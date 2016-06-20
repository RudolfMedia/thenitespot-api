class WeeklySpecial < Special 
  include Daily 

  def self.policy_class
    SpecialPolicy
  end
  
end