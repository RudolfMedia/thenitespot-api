module Overrides
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    skip_before_action :verify_authenticity_token, only: :create 
    before_action :configure_permitted_parameters

  protected

    def configure_permitted_parameters
      [ :name, :location, :gender, :dob, :avatar_data_uri, :remove_avatar ].each do |val|
        devise_parameter_sanitizer.for(:sign_up)        << val   
        devise_parameter_sanitizer.for(:account_update) << val 
      end
      logger.debug devise_parameter_sanitizer.for(:account_update)
    end
    
    
    def account_update_params
      params.permit(:name, :location, :gender, :dob, :avatar_data_uri, :remove_avatar, :password, :password_confirmation, :current_password)
      # Rails.logger.info 
    end

    # def render_update_success
    #   render json: @resource.as_json, status: 200
    # end

  end
end