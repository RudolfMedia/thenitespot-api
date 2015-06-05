module Overrides
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    skip_before_action :verify_authenticity_token, only: :create 
    before_action :configure_permitted_parameters

    def configure_permitted_parameters
      [ :name, :location, :gender, :dob, :avatar ].each do |val|
        devise_parameter_sanitizer.for(:sign_up)        << val   
        devise_parameter_sanitizer.for(:account_update) << val 
      end
    end
    
  end
end