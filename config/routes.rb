Rails.application.routes.draw do
  # get 'address/index'
  # get 'address/show'
  constraints(AdminDomainConstraint.new) do
    namespace :admin do
      root "home#index"
    end
    devise_for :users, as: :admin, controllers: {
      sessions: 'admin/users/sessions'
    }, skip: [:registrations]

    resources 'admin/items', as: 'items', path: 'items'
    resources 'admin/categories', as: 'categories', path: 'categories', except: [:show]
    resources 'admin/tickets', as: 'tickets', path: 'tickets', only: [:index, :update]
  end


  constraints(ClientDomainConstraint.new) do
    namespace :client do
      root "home#index"

    end
    devise_for :users, as: :client, controllers: {
      sessions: 'client/users/sessions',
      registrations: 'client/users/registrations'
    }
    get "/me", to: 'client/me#index'
    get "/invite", to: 'client/invite#index'
    resources 'client/address', as: 'address', path: 'address', except: [:show, :edit] do
      member do
        patch 'default'
      end
    end
    resources 'client/lottery', as: 'lottery', path: 'lottery', only: :index
  end


  namespace :api do
    namespace :v1 do
      resources :regions, only: [:index, :show], defaults: { format: :json } do
        resources :provinces, only: :index, defaults: { format: :json }
      end

      resources :provinces, only: [:index, :show], defaults: { format: :json } do
        resources :cities, only: :index, defaults: { format: :json }
      end

      resources :cities, only: [:index, :show], defaults: { format: :json } do
        resources :barangays, only: :index, defaults: { format: :json }
      end

      resources :barangays, only: [:index, :show], defaults: { format: :json }
    end
  end

  resources :menu , only: :index
end
