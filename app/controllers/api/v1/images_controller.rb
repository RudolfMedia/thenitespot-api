module API
  module V1
    class ImagesController < ApplicationController
      before_action :authenticate_user!, except: [ :index ]
      before_action :set_imageable_object, only: [ :index, :create ]

      def index
       images = @imageable.images
       render json: images, status: 200
      end

      def create
        image = @imageable.images.new(image_params)
        authorize image 
        if image.save
          render json: image, status: 201
        else
          render json: image.errors, status: 422 
        end
      end

      def update
        image = Image.find(params[:id])
        authorize image
        if image.update_attribute(:primary, params[:primary])
          render json: image, status: 200
        else
          render json: image.errors, status: 422 
        end
      end

      def destroy
        image = Image.find(params[:id])

        authorize image
        if image.destroy 
          render json: :no_content, status: 200
        else
          render json: image.errors, status: 422 
        end
      end

      def set_imageable_object
        @imageable = klass.find(imageable_id)
      end

      def imageable_request
        @imageable_request ||= request.path.slice(/[a-zA-z]+/)
      end
 
      def imageable_name
        @imageable_name ||= imageable_request.singularize
      end
    
      def imageable_id
        @imageable_id ||= params["#{imageable_name}_id"]
      end
    
    private

      def image_params
        params.permit(:id, :primary, :file_data_uri, :remove_image );
      end

      def klass
       imageable_name.capitalize.constantize
      end

    end
  end
end