class Report < ActiveRecord::Base
  belongs_to :user
  belongs_to :spot

  ISSUES = {  0 => "It should not be on The Nitespot", 
  	          1 => "It is innaccurate or outdated" }

  validates_presence_of :spot_id
  validates :issue, inclusion: { in: Report::ISSUES.keys } 

  def report_type
    Report::ISSUES[issue] if issue 
  end
  
end
