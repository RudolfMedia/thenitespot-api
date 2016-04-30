module API
  module V1
    class FavoritesController < ApplicationController
      before_action :authenticate_user!

      #send only Spot/..

      def create
       favorite = current_user.favorites.new(favorite_params)
       if favorite.save
        render json: favorite, status: 201
       else
        render json: favorite.errors, status: 422 
       end
      end

      def destroy
       favorite = current_user.favorites.find_by(spot_id: params[:id])
       favorite.destroy
       render json: :no_content, status: 200 
      end

    private

      def favorite_params
      	params.permit(:spot_id)
      end

    end
  end
end