Rails.application.routes.draw do
	
  mount_devise_token_auth_for 'User', at: 'auth', skip: [ :confirmable_callbacks ]

  namespace :api, defaults: { format: :json }, path: '/' do # constraints: { subdomain: 'api' }
    scope module: :v1, constraints: ApiVersion.new(version: 1, default: true) do 
      
    end
  end
end
