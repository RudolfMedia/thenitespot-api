module API
  module V1
    class EventsController < ApplicationController
      before_action :authenticate_user!, except: [:index]

      def index
        spot   = Spot.find(params[:spot_id])
      	events = spot.events.includes(:primary_image,:categories) 
      	render json: events, status: 200
      end

      def show
      	event = Event.find(params[:id])
      	render json: event, status: 200
      end

      def create
        spot  = Spot.find(params[:spot_id])
      	event = spot.events.new(event_params)
        authorize event
      	if event.save
      	  render json: event, status: 201
      	else
      	  render json: event.errors, status: 422
      	end
      end

      def update
      	event = Event.find(params[:id])
      	authorize event
      	if event.update(event_params)
          render json: event, status: 200
      	else
          render json: event.errors, status: 422
      	end

      end

      def destroy
      	event = Event.find(params[:id])
      	authorize event
      	event.destroy
      	render json: { success: 'Event removed' }, status: 200
      end
    
    private
      
      def event_params
        params.permit(*permitted_event_params)
      end

      def permitted_event_params
        [
          :name,
          :start_date, :start_time, 
          :end_date, :end_time,
          :age, :entry, :entry_fee,
		      :phone, :email, :about,
		      :website_url, 
          :ticket_url,
		      :category_ids => [],
          :primary_image_attributes => [ :id, :file_data_uri, :_destroy ]
        ] 
      end

    end
  end
end