class ReportMailer < ApplicationMailer

	def send_report(current_user,report)
	  @user = current_user
	  @report = report
	  @spot = report.spot 
	  mail(to:'info@thenitespot.com', subject: '** Report **')
	end

	def inform_admins(admin,report)
	  @admin = admin
	  @spot = report.spot 
	  mail(to: admin.email, subject: "#{@spot.name} has been reported as outdated or incorrect")
	end

end