Rails.application.routes.draw do
  
  
  resources :users
  devise_for :users, path: '/auth'
  root to:"professionals#index" #ruta de inicio
  resources :professionals do
      resources :appointments do
        collection do
          delete 'cancelall', action: 'cancel_all'
        end
      end
  end
  get '/grids/new', to: 'grids#new'

  post '/grids', to: 'grids#to_export'

  #get 'profile', action: :new, controller: 'grids'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end