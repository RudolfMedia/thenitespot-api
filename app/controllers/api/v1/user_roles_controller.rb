module API
  module V1
    class UserRolesController < ApplicationController
      before_action :authenticate_user!, :validate_role_type!
      before_action :set_role, only: [ :update, :destroy ]
      before_action :set_roleable_object, only: [ :index, :create ]

      def index
        user_roles = @roleable.send("#{params[:type]}_roles")
        render json: user_roles, status: 200 
      end
       
      def create
        user_role      = @roleable.user_roles.new(user_role_params)
        user_role.role = params[:type] 
        authorize user_role 
        if user_role.save
          render json: { success: 'User Added' }, status: 201
        else
          render json: { errors: user_role.errors }, status: 422
        end
      end

      def update
        authorize @user_role
        if @user_role.update_attribute(:role, params[:user_role][:role])
          render json: { success: 'User role updated!' }, status: 200
        else
          render json: { errors: @user_role.errors }, status: 422
        end
      end

      def destroy
        authorize @user_role
        begin
          @user_role.destroy
          render json: { success: 'User removed' }, status: 200
        rescue => e 
          render json: { errors: e.message }, status: 422
        end
      end

      def set_roleable_object 
        @roleable = klass.find(roleable_id) 
      end

      def set_role
        @user_role = UserRole.find(params[:id])
      end

      def roleable_request 
       @roleable_request ||= request.path.slice(/[a-zA-Z]+/) 
      end
    
      def roleable_name 
       @roleable_name ||= roleable_request.singularize
      end
    
      def roleable_id 
       @roleable_id ||= params["#{roleable_name}_id"]
      end
    
    private

      def user_role_params
        params.require(:user_role).permit(:user_id)
      end

      def validate_role_type!
        unless [ 'admin', 'editor' ].include? params[:type]
          render nothing: true, status: 422 and return 
        end
      end
   
      def klass
       roleable_name.capitalize.constantize
      end

    end
  end
end