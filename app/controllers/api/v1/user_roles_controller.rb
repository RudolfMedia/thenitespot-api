module API
  module V1
    class UserRolesController < ApplicationController
      before_action :authenticate_user! #, :validate_role_type!
      before_action :set_spot, only: [ :index, :create ]
      before_action :set_role, only: [ :update, :destroy ]

      def index
        authorize @spot 
        user_roles = @spot.user_roles
        render json: user_roles, status: 200 
      end
       
      def create
        user_role = @spot.user_roles.new(user_role_params)
        authorize user_role 
        if user_role.save
          UserRoleMailer.notify_user(current_user, user_role).deliver_later
          render json: user_role, status: 201
        else
          render json: user_role.errors, status: 422
        end
      end

      def update
        authorize @user_role
        if @user_role.update({role: params[:role]})
          render json: @user_role, status: 200
        else
          render json: @user_role.errors, status: 422
        end
      end

      def destroy
        authorize @user_role
        if @user_role.destroy
           render json: :no_content, status: 200
        else
           render json: @user_role.errors, status: 422
        end
      end

      def set_spot
        @spot = Spot.find(params[:spot_id])
      end

      def set_role
        @user_role = UserRole.find(params[:id])
      end
   
    private

      def user_role_params
        params.permit(:user_id, :role)  
      end
    end
  end
end