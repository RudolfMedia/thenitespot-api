module API
  module V1
    class SpecialsController < ApplicationController
      before_action :authenticate_user!, except: [ :index, :weekly, :featured ]
      before_action :set_spot, only: [ :index, :create, :weekly, :featured ]

      def index
        specials = @spot.specials
        render json: specials, status: 200
      end

      def weekly 
        specials = @spot.weekly_specials
        render json: specials, status: 200
      end

      def featured
        specials = @spot.featured_specials
        render json: specials, status: 200
      end

      def create
        special = params[:start_date].present? ? @spot.featured_specials.new(special_params) : @spot.weekly_specials.new(special_params)
        authorize special
        if special.save
          render json: special, status: 201
        else
          render json: special.errors, status: 422 
        end
      end

      def update
        special = Special.find(params[:id])
        authorize special
        if special.update(special_params)
          render json: special, status: 201
        else
          render json: special.errors, status: 422 
        end
      end

      def destroy
        special = Special.find(params[:id])
        authorize special
        special.destroy
        render json: :no_content, status: 200
      end

    private
      
      def set_spot
        @spot = Spot.find(params[:spot_id])
      end

      def special_params
        params.permit(:name, :sort, :description, :start_time, :end_time, :start_date, :end_date, :days => [])
      end

    end
  end
end