module API
  module V1
    class SpecialsController < ApplicationController
      before_action :authenticate_user!

      def create
        spot = Spot.find(params[:spot_id])
        special = spot.specials.new(special_params)
        #authorize special
        if special.save
          render json: { success: 'Special added!'}, status: 201
        else
          render json: { errors: special.errors }, status: 422 
        end
      end

      def update
        spot = Spot.find(params[:spot_id])
        special = spot.specials.find(params[:id])
        #authorize special
        if special.update(special_params)
          render json: { success: 'Special updated.'}, status: 201
        else
          render json: { errors: special.errors }, status: 422 
        end
      end

      def destroy
      	spot = Spot.find(params[:spot_id])
        special = spot.specials.find(params[:id])
        #authorize special
        special.destroy
        render json: { success: 'Special removed.' }, status: 200
      end
    
    private
      
      def special_params
        params.require(:special).permit(:name, :sort, :description, :start_time, :end_time, :days => [])
      end

    end
  end
end