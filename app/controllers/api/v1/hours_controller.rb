module API
  module V1
    class HoursController < ApplicationController
      before_action :authenticate_user!

      def create
        spot = Spot.find(params[:spot_id])
        hour = spot.hours.new(hour_params)
        authorize hour
        if hour.save
          render json: hour, status: 201
        else
          render json: { errors: hour.errors }, status: 422 
        end
      end

      def update
        # spot = Spot.find(params[:spot_id])
        hour = Hour.find(params[:id])
        authorize hour.spot
        if hour.update(hour_params)
          render json: hour, status: 201
        else
          render json: { errors: hour.errors }, status: 422 
        end
      end

      def destroy
        hour = Hour.find(params[:id])
        authorize hour.spot 
        hour.destroy
        render json: :no_content, status: 200
      end
    
    private
      
      def hour_params
       # params.require(:hour).permit(:open, :close, :note, :days => [])
        params.permit(:open, :close, :note, :days => [])
      end

    end
  end
end