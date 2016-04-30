module API
  module V1
    class CategoriesController < ApplicationController
      #before_action :authenticate_user!
      def index
        @categories = Category.main 
        @categories = @categories.send(params[:sort].to_sym) if valid_sort?
        render json: @categories, status: 200 	
      end

    end
  end
end