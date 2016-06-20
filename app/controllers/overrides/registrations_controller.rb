module Overrides
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    skip_before_action :verify_authenticity_token, only: :create 
    before_action :configure_permitted_parameters

  protected

    def configure_permitted_parameters
      [ :first_name, :last_name, :location, :gender, :dob, :avatar_data_uri, :remove_avatar, :business, :phone ].each do |val|
        devise_parameter_sanitizer.for(:sign_up)        << val   
        devise_parameter_sanitizer.for(:account_update) << val 
      end
      logger.debug devise_parameter_sanitizer.for(:account_update)
    end
    
    
    def account_update_params
      params.permit(:first_name, :last_name, :location, :gender, :dob, :business, :phone, :avatar_data_uri, :remove_avatar, :password, :password_confirmation, :current_password)
    end

    # def render_update_success
    #   render json: @resource.as_json, status: 200
    # end

  end
end