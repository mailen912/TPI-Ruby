Rails.application.routes.draw do
  
  root to:"professionals#index" #ruta de inicio
  resources :professionals do
    resources :appointments
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  """root to:professionals#index #ruta de inicio
  resources :professionals do
      resources :appointments, only: [:index, :new, :create]
  end
  resources :appointments, only: [:show, :edit, :update, :destroy]"""
end