module API
  module V1
    class CategoriesController < ApplicationController
      
      def index
        @categories = Category.main 
        @categories = @categories.send(params[:sort].to_sym) if valid_sort?
        render json: @categories, status: 200 	
      end

    end
  end
end