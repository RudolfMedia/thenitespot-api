module API
  module V1
    class ReportsController < ApplicationController

      def create
        report = user_signed_in? ? current_user.reports.new(report_params) : Report.new(report_params)
        
        if report.save
          ReportMailer.send_report(current_user, report).deliver_later

          if report.issue == 1 
            report.spot.admin_users.each do |admin|
              ReportMailer.inform_admins(admin, report).deliver_later
            end
          end

          render json: report, status: 201
        else
          render json: report.errors, status: 422 
        end
      end

    private

      def report_params
        params.permit(:spot_id, :issue)
      end

    end
  end
end