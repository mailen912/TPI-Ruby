Rails.application.routes.draw do
  
  devise_for :users
  root to:"professionals#index" #ruta de inicio
  resources :professionals do
      resources :appointments do
        collection do
          delete 'cancelall', action: 'cancel_all'
        end
      end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  """root to:professionals#index #ruta de inicio
  resources :professionals do
      resources :appointments, only: [:index, :new, :create]
  end
  resources :appointments, only: [:show, :edit, :update, :destroy]"""
end