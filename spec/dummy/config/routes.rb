Rails.application.routes.draw do
  namespace :no_custom_api do
    get :authenticated, to: 'authenticated#index'
    get :unauthenticated, to: 'unauthenticated#index'
  end

  namespace :custom_api do
    get :no_custom_authenticated, to: 'no_custom_authenticated#index'
    get :custom_authenticated, to: 'custom_authenticated#index'
    get :unauthenticated, to: 'unauthenticated#index'
  end
end
