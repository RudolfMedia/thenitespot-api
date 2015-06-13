module API
  module V1
    class ReportsController < ApplicationController
      before_action :authenticate_user!

      def create
        report = current_user.reports.new(report_params)
        if report.save
          render json: { success: 'Thank you for your feedback.'}, status: 201
        else
          render json: { errors: report.errors }, status: 422 
        end
      end

    private

      def report_params
        params.require(:report).permit(:reportable_type, :reportable_id, :issue)
      end

    end
  end
end