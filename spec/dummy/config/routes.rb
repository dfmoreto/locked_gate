Rails.application.routes.draw do
  get '/authenticated', to: 'authenticated#index'
end
