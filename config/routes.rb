Rails.application.routes.draw do
  get 'address/index'
  get 'address/show'
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
  end
  resources 'client/address', as: 'address', path: 'address', except: :show
  resources :menu , only: :index
end
