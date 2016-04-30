class ReportMailer < ApplicationMailer

	default from: 'notifications@example.com'
 
	def send_report(current_user,report)
	  @user = current_user
	  @report = report
	  @spot = report.spot 
	  mail(to:'rowlandrudolf@comcast.net', subject: '** Report **')
	end

end