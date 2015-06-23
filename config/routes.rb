Rails.application.routes.draw do
	
  mount_devise_token_auth_for 'User', at: 'auth', skip: [ :confirmable_callbacks ],
    controllers: {
    	registrations: 'overrides/registrations',
      omniauth_callbacks: 'overrides/omniauth_callbacks'
    }

  concern :user_roleable do 
    with_options except: [ :show, :new, :edit ], controller: :user_roles, shallow: true do 
      resources :admin_roles,  type: 'admin'
      resources :editor_roles, type: 'editor'
    end
  end

  concern :geolocateable do 
    get :near, on: :collection 
  end

  namespace :api, defaults: { format: :json }, path: '/' do # constraints: { subdomain: 'api' }
    scope module: :v1, constraints: ApiVersion.new(version: 1, default: true) do 

      with_options only: :index do 
        resources :features
        resources :categories
        resources :neighborhoods, concerns: :geolocateable
      end

      resources :events, only: [ :show, :update, :destroy ], concerns: :geolocateable

      resources :spots, concerns: [ :user_roleable, :geolocateable ] do
      
        with_options only: [ :create, :update, :destroy ] do
          resources :specials
          resources :hours
        end 
      
        resources :menus,    only: [ :index, :create, :update, :destroy ], shallow: true 
        resources :events,   only: [ :index, :create ] 
      
      end 
      
      resources :favorites, only: [ :create, :destroy ]
      
      with_options only: :create do 
        resources :checkins
        resources :reports 
      end
       
    end
  end
end
