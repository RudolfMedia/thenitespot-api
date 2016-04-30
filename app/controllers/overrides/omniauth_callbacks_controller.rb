module Overrides
  class OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController 
  
    def assign_provider_attrs(user, auth_hash)
      Rails.logger.info(auth_hash)
      user.assign_attributes({
        email:    auth_hash['info']['email'],
        name:     auth_hash['info']['name'], 
        # gender:   auth_hash['info']['gender'],
        # location: auth_hash['extra']['raw_info']['location']['name'],
        # dob:      Date.strptime(auth_hash['extra']['raw_info']['birthday'], "%m/%d/%Y"),
        remote_avatar_url: auth_hash['info']['image']
      })
    end

  end
end