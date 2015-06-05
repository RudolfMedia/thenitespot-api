Rails.application.routes.draw do
	
  mount_devise_token_auth_for 'User', at: 'auth', skip: [ :confirmable_callbacks ]

  namespace :api, defaults: { format: :json }, path: '/' do # constraints: { subdomain: 'api' }
    scope module: :v1, constraints: ApiVersion.new(version: 1, default: true) do 
      
      get 'features/index',   to: 'features#index'
      
      get 'categories/index', to: 'categories#index'

      get 'neighborhoods/index', to: 'neighborhoods#index'
      get 'neighborhoods/near',  to: 'neighborhoods#near'

    end
  end
end
