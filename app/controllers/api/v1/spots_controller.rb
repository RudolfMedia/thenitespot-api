module API
  module V1
    class SpotsController < ApplicationController
      before_action :authenticate_user!, except: [:show, :near]

      def index
      	spots = Spot.all
      	spots = spots.send(params[:sort].to_sym) if valid_sort? 
      	render json: spots, status: 200
      end

      def near
        spots = params[:ngh].present? ? Spot.ngh(params[:ngh]) : Spot.near(ll_params, radius)
        spots = spots.send(params[:sort].to_sym) if valid_sort?
      	render json: spots, status: 200
      end

      def show
      	spot = Spot.find(params[:id])
      	render json: spot, status: 200
      end

      def new
      	spot = Spot.new()
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

      def edit
      	spot = Spot.find(params[:id])
      	#authorize spot
      	render json: spot, status: 200 
      end

      def update
      	spot = Spot.find(params[:id])
      	#authorize spot
      	spot_params.merge! image_params 
      	if spot.update(spot_params)
          render json: spot, status: 200
      	else
          render json: spot.errors, status: 422
      	end

      end

      def destroy
      	spot = Spot.find(params[:id])
      	#authorize spot
      	spot.destroy
      	render json: { success: 'Spot removed' }, status: 200
      end
    
    private
      
      def spot_params
        params.require(:spot).permit(*permitted_spot_params)
      end

      def permitted_spot_params
        [
          :name,
          :eat, :drink, :attend,
          :street, :city, :state,
          :neighborhood_id, 
		      :phone, :email, :about, :price, 
		      :website_url, :reservation_url, :menu_url, :facebook_url, :twitter_url, 
		      :payment_opts =>[], 
		      :feature_ids => [], 
		      :category_ids => []
        ]
      end 

      def image_params
        { :primary_image_attributes => [ :id, :file, :_destroy ], :images_attributes => [ :id, :file, :_destroy ] }
	  end 

    end
  end
end