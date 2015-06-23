module API
  module V1
    class MenusController < ApplicationController
      before_action :authenticate_user!

      def index
       spot = Spot.find(params[:spot_id])
       render json: spot.menus.all, status: 200 
      end

      # def show
      #   menu = Menu.find(params[:id])
      #   render json: menu, status: 200 
      # end

      # def new
      #   spot = Spot.find(params[:spot_id])
      #   menu = spot.menus.new()
      #   #authorize menu.spot..
      #   render json: Menu.new(), status: 200
      # end

      def create
        spot = Spot.find(params[:spot_id])
        menu = spot.menus.new(menu_params)
        authorize menu
        if menu.save
          render json: { success: 'Menu added!'}, status: 201
        else
          render json: { errors: menu.errors }, status: 422 
        end
      end

      # def edit
      #   menu = Menu.find(params[:id])
      #   #authorize menu.spot
      #   render json: menu, status: 200 
      # end

      def update
        menu = Menus.find(params[:id])
        authorize menu
        if menu.update(menu_params)
          render json: { success: 'Menu updated.'}, status: 201
        else
          render json: { errors: menu.errors }, status: 422 
        end
      end

      def destroy
        menu = Menus.find(params[:id])
        authorize menu
        menu.destroy
        render json: { success: 'Menu removed.' }, status: 200
      end
    
    private
      
      def menu_params
        params.require(:menu).permit(*permitted_menu_params)
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