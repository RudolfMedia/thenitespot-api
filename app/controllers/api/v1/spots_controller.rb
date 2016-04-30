module API
  module V1
    class SpotsController < ApplicationController
      before_action :authenticate_user!, except: [:show, :near, :search]
      before_action :location_set?, only: [ :near ]

      def index
        spots = Spot.all.assocs
        spots = spots.send(params[:sort].to_sym) if valid_sort?
        render json: spots, status: 200
      end

      def near
        spots = Spot.near(location, radius).assocs
        spots = spots.send(params[:sort].to_sym) if valid_sort?
        render json: spots, status: 200
      end

      def favorites
        spots = current_user.favorite_spots.near(location, 30).assocs
        render json: spots, status: 200
      end

      def show
      	spot = Spot.assocs.friendly.find(params[:id])
        spot.distance = spot.distance_from(location) if location.present?
      	render json: spot, status: 200
      end

      def create
      	spot = Spot.new(spot_params)
      	spot.admin_users << current_user 
      	if spot.save
      	  render json: spot, status: 201
      	else
      	  render json: spot.errors, status: 422
      	end
      end

      def update
      	spot = Spot.find(params[:id])
      	authorize spot
      	spot_params.merge! image_params 
      	if spot.update(spot_params)
          render json: spot, status: 200
      	else
          render json: spot.errors, status: 422
      	end
      end

      def destroy
      	spot = Spot.find(params[:id])
      	authorize spot
      	spot.destroy
      	render json: { success: 'Spot removed' }, status: 204
      end

      def search
        spots = params[:q].present? ? Spot.q(params[:q]) : []
        render json: spots, status: 200
      end

      def user_index
        spots = current_user.spots 
        render json: spots, status: 200 
      end

      def spot_exists
        resp = params[:name].present? ? Spot.exists?(["lower(name) = ?", params[:name].downcase]) : false
        render json: resp, status: 200 
      end
    
    private

      def location_set?
        location.present? 
      end

      def spot_params
        params.permit(*permitted_spot_params)
      end

      def filter_params
        params.slice(:ftr, :ctg, :q)
      end

      def permitted_spot_params
        [
          :name,
          :eat, :drink, :attend,
          :street, :city, :state,
          :longitude, :latitude,
		      :phone, :email, :about, :price, 
		      :website_url, :reservation_url, :menu_url,
		      :payment_opts =>[], 
		      :feature_ids => [], 
		      :category_ids => []
        ]
      end 

      def image_params
        { :primary_image_attributes => [ :id, :file, :file_data_uri, :remove_image, :_destroy ] }
	    end 

    end
  end
end