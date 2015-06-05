module API
  module V1
    class FeaturesController < ApplicationController
      
      def index
        @features = Feature.all 
        render json: @features, status: 200 	
      end

    end
  end
end