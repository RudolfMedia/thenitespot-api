module API
  module V1
    class NeighborhoodsController < ApplicationController
      
      def index
        @neighborhoods = Neighborhood.all 
        render json: @neighborhoods, status: 200 	
      end

      def near
        @neighborhoods = Neighborhood.near(ll_params, 8)
        render json: @neighborhoods, status: 200 
      end

    end
  end
end