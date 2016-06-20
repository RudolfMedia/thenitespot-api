module Overrides
  class OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController 
  
    def assign_provider_attrs(user, auth_hash)
      user.assign_attributes({
        email:    auth_hash['info']['email'],
        first_name: auth_hash['info']['first_name'],
        last_name:  auth_hash['info']['last_name'],
        # gender:   auth_hash['info']['gender'],
        remote_avatar_url: auth_hash['info']['image']
      })
    end

  end
end