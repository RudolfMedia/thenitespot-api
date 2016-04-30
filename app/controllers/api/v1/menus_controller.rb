module API
  module V1
    class MenusController < ApplicationController
      before_action :authenticate_user!, except: :index

      def index
       spot = Spot.find(params[:spot_id])
       render json: spot.menus.all, status: 200 
      end

      def create
        spot = Spot.find(params[:spot_id])
        menu = spot.menus.new(menu_params)
        authorize menu
        if menu.save
          render json: menu, status: 201
        else
          render json: menu.errors , status: 422 
        end
      end

      def update
        menu = Menu.find(params[:id])
        authorize menu
        if menu.update(menu_params)
          render json: menu, status: 201
        else
          render json: menu.errors, status: 422 
        end
      end

      def destroy
        menu = Menu.find(params[:id])
        authorize menu
        menu.destroy
        render json: :no_content, status: 200
      end
    
    private
      
      def menu_params
        params.permit(*permitted_menu_params)
      end

      def permitted_menu_params
        [
          :name,
          :description,
          :sort,
          :items_attributes => [ :id, :name, :description, :price, :_destroy ]
        ]
      end

    end
  end
end