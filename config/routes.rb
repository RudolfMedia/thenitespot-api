Rails.application.routes.draw do
	
  mount_devise_token_auth_for 'User', at: 'auth', skip: [ :confirmable_callbacks ],
    controllers: {
    	registrations: 'overrides/registrations',
      omniauth_callbacks: 'overrides/omniauth_callbacks'
    }

  namespace :api, defaults: { format: :json }, path: '/' do # constraints: { subdomain: 'api' }
    scope module: :v1, constraints: ApiVersion.new(version: 1, default: true) do 
      
      get 'features/index',   to: 'features#index'

      get 'categories/index', to: 'categories#index'

      get 'neighborhoods/index', to: 'neighborhoods#index'
      get 'neighborhoods/near',  to: 'neighborhoods#near'

      resources :spots do 
        get 'near', on: :collection
        resources :specials, only: [ :create, :update, :destroy ]
        resources :hours,    only: [ :create, :update, :destroy ]
        resources :menus,    only: [ :index , :create, :update, :destroy ], shallow: true 
      end

      resources :favorites, only: [:create, :destroy]
      
      post 'checkins', to: 'checkins#create'
      post 'reports',  to: 'reports#create'
      
    end
  end
end
