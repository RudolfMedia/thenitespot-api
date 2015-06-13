class Report < ActiveRecord::Base
  belongs_to :user
  belongs_to :reportable, polymorphic: true

  ISSUES = { 0 => "It should not be on The Nitespot", 
  	         1 => "It is innaccurate or outdated" }

  validates_presence_of :reportable_type, :reportable_id, :user 
  validate :reportable_exists?
  validates :issue, inclusion: { in: ISSUES.keys }
  
  def report_type
    Report::ISSUES[issue] if issue 
  end
  
end
