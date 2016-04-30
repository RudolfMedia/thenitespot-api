Rails.application.routes.draw do
	
  mount_devise_token_auth_for 'User', at: 'auth', skip: [ :confirmable_callbacks ],
    controllers: {
    	registrations: 'overrides/registrations',
      omniauth_callbacks: 'overrides/omniauth_callbacks'
    }


  namespace :api, defaults: { format: :json }, path: '/' do # constraints: { subdomain: 'api' }
    scope module: :v1, constraints: ApiVersion.new(version: 1, default: true) do 

      root to: 'spots#index'

      with_options only: :index do 
        resources :features
        resources :categories
      end
      
      get 'users/search', to: 'users#search'
      get 'users/emailexists', to: 'users#emailexists'

      resources :events, only: [ :show, :update, :destroy ] do 
          resources :images, only: [ :create ]
      end
    
      get 'spots/spot_exists', to: 'spots#spot_exists' 
      
      resources :spots, except: [ :new, :edit ] do
        
        collection do
          get :near
          get :favorites 
          get :search
          get :user_index
        end

        with_options only: [ :index, :create, :update, :destroy ], shallow: true do
          resources :specials
          resources :hours
          resources :menus
          resources :images
          resources :user_roles 
          resources :events do
            resources :images, only: [ :create ]
          end
        end 
      end

         
      
      resources :favorites, only: [ :create, :destroy ]
      
      with_options only: :create do 
        resources :checkins
        resources :reports 
      end

    end
  end
  
  match "*path", to: "application#not_found", via: :all

end