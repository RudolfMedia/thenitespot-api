module API
  module V1
    class HoursController < ApplicationController
      before_action :authenticate_user!

      def create
        spot = Spot.find(params[:spot_id])
        hour = spot.hours.new(hour_params)
        #authorize hour
        if hour.save
          render json: { success: 'Hours added!'}, status: 201
        else
          render json: { errors: hours.errors }, status: 422 
        end
      end

      def update
        spot = Spot.find(params[:spot_id])
        hour = spot.hours.find(params[:id])
        #authorize hour
        if hour.update(hour_params)
          render json: { success: 'Hours updated.'}, status: 201
        else
          render json: { errors: hour.errors }, status: 422 
        end
      end

      def destroy
      	spot = Spot.find(params[:spot_id])
        hour = spot.hours.find(params[:id])
        #authorize hour
        hour.destroy
        render json: { success: 'Hours removed.' }, status: 200
      end
    
    private
      
      def hour_params
        params.require(:hour).permit(:open, :close, :note, :days => [])
      end

    end
  end
end