Rails.application.routes.draw do
  # get 'address/index'
  # get 'address/show'
  constraints(AdminDomainConstraint.new) do
    namespace :admin do
      root "home#index"
    end
    devise_for :users, as: :admin, path: 'admin', controllers: {
      sessions: 'admin/users/sessions'
    }, skip: [:registrations]
  end

  constraints(ClientDomainConstraint.new) do
    namespace :client do
      root "home#index"

    end
    devise_for :users, as: :client, path: 'client', controllers: {
      sessions: 'client/users/sessions',
      registrations: 'client/users/registrations'
    }
    get "/me", to: 'client/me#index'
    resources 'client/address', as: 'address', path: 'address', except: :show
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
