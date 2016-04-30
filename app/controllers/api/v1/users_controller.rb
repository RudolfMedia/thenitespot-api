module API
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!, except: :emailexists 

      def emailexists
        if params[:email].present?
          resp = User.exists?(["lower(email) = ?", params[:email].downcase])
          if current_user && current_user.email == params[:email]
            resp = false
          end
        else
          resp = false
        end
        render json: resp, status: 200 
      end

      def search
        if params[:q].present?
          q = "%#{params[:q]}%"
          users = User.where('name ILIKE ?', q).limit(10)
          render json: users, status: 200
        end
      end

    end
  end
end