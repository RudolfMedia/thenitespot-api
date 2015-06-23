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

  namespace :api, defaults: { format: :json }, path: '/' do # constraints: { subdomain: 'api' }
    scope module: :v1, constraints: ApiVersion.new(version: 1, default: true) do 
      
      get 'features/index',   to: 'features#index'

      get 'categories/index', to: 'categories#index'

      get 'neighborhoods/index', to: 'neighborhoods#index'
      get 'neighborhoods/near',  to: 'neighborhoods#near'

      get 'events/near', to: 'events#near'

      resources :spots, concerns: :user_roleable do 
        get 'near', on: :collection
        resources :specials, only: [ :create, :update, :destroy ]
        resources :hours,    only: [ :create, :update, :destroy ]
        resources :menus,    only: [ :index , :create, :update, :destroy ], shallow: true 
        resources :events, shallow: true 
      end
      
      resources :favorites, only: [:create, :destroy]
      
      post 'checkins', to: 'checkins#create'
      post 'reports',  to: 'reports#create'
      
    end
  end
end
