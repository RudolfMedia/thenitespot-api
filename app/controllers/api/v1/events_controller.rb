module API
  module V1
    class EventsController < ApplicationController
      before_action :authenticate_user!, except: [:show, :near]

      def index
        spot   = Spot.find(params[:spot_id])
      	events = spot.events 
      	render json: events, status: 200
      end

      def near
        nearby_venues = params[:ngh].present? ? Spot.ngh(params[:ngh]).attend.pluck(:id) : Spot.geolocate(ll_params, radius).attend.pluck(:id)
      	events =  Event.venue(nearby_venues).upcoming
        render json: events, status: 200
      end

      def show
      	event = Event.find(params[:id])
      	render json: event, status: 200
      end

      def new
        spot = Spot.find(params[:spot_id])
        event = spot.events.new()
        #authorize event.spot 
        render json: event, status: 200 
      end

      def create
        spot  = Spot.find(params[:spot_id])
      	event = spot.events.new(event_params)
      	#authorize event.spot  
      	if event.save
      	  render json: event, status: 201
      	else
      	  render json: event.errors, status: 422
      	end
      end

      def edit
      	event = Event.find(params[:id])
      	#authorize event.spot 
      	render json: event, status: 200 
      end

      def update
      	event = Event.find(params[:id])
      	#authorize event.spot
      	if event.update(event_params)
          render json: event, status: 200
      	else
          render json: event.errors, status: 422
      	end

      end

      def destroy
      	event = Event.find(params[:id])
      	#authorize event.spot
      	event.destroy
      	render json: { success: 'Event removed' }, status: 200
      end
    
    private
      
      def event_params
        params.require(:event).permit(*permitted_event_params)
      end

      def permitted_event_params
        [
          :spot_id,
          :name,
          :age, :entry, :entry_fee,
		      :phone, :email, :about,
		      :website_url, :facebook_url, :twitter_url,
		      :category_ids => [],
          :occurrences_attributes => [ 
            :id, 
            :start_date, :start_time, 
            :end_date, :end_time, 
            :_destroy
          ],
          :primary_image_attributes => [ :id, :file, :_destroy ], 
          :images_attributes => [ :id, :file, :_destroy ] 
        ] 
      end

    end
  end
end