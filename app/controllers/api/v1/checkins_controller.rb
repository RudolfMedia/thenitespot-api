module API
  module V1
    class CheckinsController < ApplicationController
      before_action :authenticate_user!

      def create
        checkin = current_user.checkins.first_or_initialize(checkin_params).tap do |c|
        	c.ll = ll_params
        end
        if checkin.save
          render json: { success: 'Checked in!' }, status: 201
        else
          render json: { errors: checkin.errors }, status: 422
        end
      end

    private

      def checkin_params
        params.require(:checkin).permit(:spot_id)
      end

    end
  end
end