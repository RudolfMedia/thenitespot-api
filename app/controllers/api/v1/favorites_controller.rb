module API
  module V1
    class FavoritesController < ApplicationController
      before_action :authenticate_user!

      def create
       favorite = current_user.favorites.new(favorite_params)
       if favorite.save
        render json: { success: 'Favorite added!' }, status: 201
       else
        render json: { errors: favorite.errors }, status: 422 
       end
      end

      def destroy
       favorite = current_user.favorites.find(params[:id])
       favorite.destroy
       render json: { success: 'Favorite removed' }, status: 200 
      end

    private

      def favorite_params
      	params.require(:favorite).permit(:spot_id)
      end

    end
  end
end